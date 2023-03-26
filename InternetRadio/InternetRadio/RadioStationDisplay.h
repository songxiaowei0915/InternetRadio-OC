//
//  RadioStationDisplay.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RadioStation.h"

NS_ASSUME_NONNULL_BEGIN

@interface RadioStationDisplay : NSObject

@property (nonatomic, readonly) RadioStation *station;
@property (nonatomic, readonly) NSString *stationuuid;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSURL *imageUrl;
@property (nonatomic, readonly) NSString *desc;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) BOOL isFavorite;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype) initWithRaioStation: (nonnull RadioStation *)radioStation;
- (void) getImage: (nullable void (^)(UIImage *))callback;
- (UIImage *) deaultImage;
- (void) toggleFavorite;

@end

NS_ASSUME_NONNULL_END
