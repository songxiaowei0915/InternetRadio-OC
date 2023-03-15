//
//  RadioStationFetcher.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import "RadioStation.h"

NS_ASSUME_NONNULL_BEGIN

@interface RadioStationFetcher : NSObject <RadioStationFetcherProtocol>

@property (nonatomic, strong) id<RadioStationParserProtocol> parser;

- (instancetype)initWithParser:(id<RadioStationParserProtocol>)parser;

@end

NS_ASSUME_NONNULL_END
