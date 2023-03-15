//
//  RadioPlayer.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/14.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RadioPalyerState) {
    none,
    playing,
    paused,
    stopped,
    buffering
};

@protocol RadioPlayerDelegate <NSObject>

@end

@interface RadioPlayer : NSObject {
    AVPlayer *avPlayer;
}

+ (instancetype) sharedInstance;

@property (nonatomic, readonly) RadioPalyerState state;
@property (nonatomic, readonly) RadioPalyerState interruptStatus;

- (void) playURL: (NSURL *)streamUrl withName:(NSString *)name withImage:(UIImage *) showImage;
- (void) play;
- (void) stop;
- (void) pause;
- (void) interrupt;
- (void) resume;

@end

NS_ASSUME_NONNULL_END
