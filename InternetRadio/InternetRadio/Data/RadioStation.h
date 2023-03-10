//
//  RadioStation.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadioStation : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *url;
@property (nonatomic, readonly) NSString *image;
@property (nonatomic, readonly) NSString *desc;

- (id) initWithName: (NSString *)name withURL:(NSString *)url withImage: (NSString *)image  withDesc: (NSString *)desc;

@end

NS_ASSUME_NONNULL_END
