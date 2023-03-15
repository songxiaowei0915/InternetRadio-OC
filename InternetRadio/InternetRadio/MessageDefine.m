//
//  MessageDefine.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/15.
//

#import "MessageDefine.h"

@implementation MessageDefine
static NSString* _RADIOPLAYER_PLAYING = @"radioplayer_playing";
static NSString* _RADIOPLAYER_PAUSE = @"radioplayer_pause";
static NSString* _RADIOPLAYER_BUFFERING = @"radioplayer_buffering";
static NSString* _RADIOPLAYER_STOP = @"radioplayer_stop";

static NSString* _STATION_PLAY = @"station_play";
static NSString* _STATION_PLAY_OR_PAUSE = @"station_play_or_pause";
static NSString* _STATION_FAVORITE = @"station_favorite";

+ (NSString *) RADIOPLAYER_PLAYING {
    return _RADIOPLAYER_PLAYING;
}

+ (NSString *) RADIOPLAYER_PAUSE {
    return _RADIOPLAYER_PAUSE;
}

+ (NSString *) RADIOPLAYER_BUFFERING {
    return _RADIOPLAYER_BUFFERING;
}

+ (NSString *) RADIOPLAYER_STOP {
    return _RADIOPLAYER_STOP;
}

+ (NSString *) STATION_PLAY {
    return _STATION_PLAY;
}

+ (NSString *) STATION_PLAY_OR_PAUSE {
    return _STATION_PLAY_OR_PAUSE;
}

+ (NSString *) STATION_FAVORITE {
    return _STATION_FAVORITE;
}


@end
