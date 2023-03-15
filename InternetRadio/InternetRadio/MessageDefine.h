//
//  MessageDefine.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface MessageDefine : NSObject
@property (class,nonatomic,readonly) NSString* RADIOPLAYER_PLAYING;
@property (class,nonatomic,readonly) NSString* RADIOPLAYER_PAUSE;
@property (class,nonatomic,readonly) NSString* RADIOPLAYER_BUFFERING;
@property (class,nonatomic,readonly) NSString* RADIOPLAYER_STOP;
@property (class,nonatomic,readonly) NSString* STATION_PLAY;
@property (class,nonatomic,readonly) NSString* STATION_PLAY_OR_PAUSE;
@property (class,nonatomic,readonly) NSString* STATION_FAVORITE;
@end

NS_ASSUME_NONNULL_END
