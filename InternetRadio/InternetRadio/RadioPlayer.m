//
//  RadioPlayer.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/14.
//

#import "RadioPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MessageDefine.h"

@interface RadioPlayer () {
    id periodicTimeObserverObserver;
    NSString *lastName;
    NSURL *lastStreamUrl;
    UIImage *lastShowImage;
}

@end

@implementation RadioPlayer

static RadioPlayer *_instance = nil;

+ (instancetype) sharedInstance {
    if (!_instance) {
        _instance = [[self alloc]init];
    }
    
    return _instance;
}

- (instancetype) init {
    self = [super init];
    [self setState:none];
    AVAudioSession *audioSession =  [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeSpokenAudio options:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:AVAudioSessionInterruptionNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        int status = [[note.userInfo valueForKey:AVAudioSessionInterruptionTypeKey] intValue];
        
        if (status == AVAudioSessionInterruptionTypeBegan) {
            [self pause];
        } else if(status==AVAudioSessionInterruptionTypeEnded) {
            int shouldResume = [[note.userInfo valueForKey:AVAudioSessionInterruptionOptionKey] intValue];
            if (shouldResume == AVAudioSessionInterruptionOptionShouldResume) {
                [self play];
            }
       }
    }];
    [self setupRemoteCommandCenter];
    
    return self;
}

- (void) stop {
    if (avPlayer) {
        [self removeObserver];
        [avPlayer pause];
        [avPlayer replaceCurrentItemWithPlayerItem:nil];
        [avPlayer setRate:0];
        avPlayer = nil;
    }
    [self setState:stopped];
    
    NSLog(@"stopped");
}

- (void) pause {
    if (avPlayer && avPlayer.currentItem) {
        [avPlayer pause];
        [self setState:paused];
        
        NSLog(@"paused");
    }
}

- (void) interrupt {
    if (!avPlayer || !avPlayer.currentItem) {
        return;
    }
    
    _interruptStatus = _state;
    [avPlayer pause];
    [self setState:buffering];
}

- (void) setState:(RadioPalyerState)state {
    _state = state;
    [self postStateMessage];
}

- (void) resume {
    if (!avPlayer || !avPlayer.currentItem) {
        return;
    }
    
    switch (_interruptStatus) {
        case buffering:
        case playing:
            [self play];
            break;
        case paused:
            [self setState:paused];
            break;
        default:
            break;
    }

    _interruptStatus = none;
}

- (void) play {
    [self stop];
    [self playURL:lastStreamUrl withName:lastName withImage:lastShowImage];
}

- (void) playURL:(NSURL *)streamUrl withName:(NSString *)name withImage:(UIImage *)showImage {
    if (!streamUrl) {
        return;
    }
    
    [self stop];
    
    AVPlayerItem * avPlayerItem = [AVPlayerItem playerItemWithURL:streamUrl];
    if (!avPlayer.currentItem) {
        avPlayer = [AVPlayer playerWithPlayerItem:avPlayerItem];
        [avPlayer setAllowsExternalPlayback:false];
        [avPlayer setAutomaticallyWaitsToMinimizeStalling:true];
    } else {
        [avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
    }
    [self setState:buffering];
    
    [avPlayer play];
    [self addPlayerObserver];
    
    lastName = name;
    lastStreamUrl = streamUrl;
    lastShowImage = showImage;

    NSLog(@"buffering with url: %@", streamUrl);

    [self setupNowPlayingWithName:name withImage:showImage];
}

- (void) addPlayerObserver {
    RadioPlayer *strongSelf = self;
    periodicTimeObserverObserver = [avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(10, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if (strongSelf->avPlayer.currentItem.isPlaybackLikelyToKeepUp) {
            [strongSelf removeObserver];
            NSLog(@"Buffering completed");
        }
    }];
}

- (void) removeObserver {
    if (periodicTimeObserverObserver) {
        [avPlayer removeTimeObserver:periodicTimeObserverObserver];
        periodicTimeObserverObserver = nil;
    }
}

- (void) togglePlayPause {
    switch (_state) {
        case playing:
            [self pause];
            break;
        case paused:
            [self play];
            break;
        default:
            break;
    }
}

- (void) postStateMessage {
    NSString *message = @"";
    switch (_state) {
        case playing:
            message = MessageDefine.RADIOPLAYER_PLAYING;
            break;
        case paused:
            message = MessageDefine.RADIOPLAYER_PAUSE;
            break;
        case stopped:
            message = MessageDefine.RADIOPLAYER_STOP;
            break;
        case buffering:
            message = MessageDefine.RADIOPLAYER_BUFFERING;
            break;;
        case none:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:message object:nil];
}

- (void) setupNowPlayingWithName: (NSString*)name  withImage: (UIImage *)showImage {
    AVPlayerItem *playerItem = avPlayer.currentItem;
    long seconds = playerItem.currentTime.value/playerItem.currentTime.timescale;
    long duration = playerItem.duration.value/playerItem.duration.timescale;
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithBoundsSize:showImage.size requestHandler:^UIImage * _Nonnull(CGSize size) {
        return showImage;
    }];
    
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    infoDict[MPMediaItemPropertyTitle] = name;
    infoDict[MPMediaItemPropertyPlaybackDuration] = @(duration);
    infoDict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(seconds);
    infoDict[MPNowPlayingInfoPropertyPlaybackRate] = @(avPlayer.rate);
    infoDict[MPMediaItemPropertyArtwork] = artWork;
       
    infoCenter.nowPlayingInfo = nil;
    infoCenter.nowPlayingInfo = infoDict;
}

- (void) setupRemoteCommandCenter {
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];

    [commandCenter.nextTrackCommand setEnabled:false];
    [commandCenter.previousTrackCommand setEnabled:false];
    [commandCenter.playCommand setEnabled:true];
    [commandCenter.pauseCommand setEnabled:true];
    [commandCenter.playCommand addTarget:self action:@selector(palyCommandSel:)];
    [commandCenter.pauseCommand addTarget:self action:@selector(pauseCommandSel:)];
}

- (MPRemoteCommandHandlerStatus) palyCommandSel: (MPRemoteCommand *) sender {
    [self togglePlayPause];
    return  MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus) pauseCommandSel: (MPRemoteCommand *) sender {
    [self togglePlayPause];
    return  MPRemoteCommandHandlerStatusSuccess;
}

@end
