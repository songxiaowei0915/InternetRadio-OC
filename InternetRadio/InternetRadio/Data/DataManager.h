//
//  DataManager.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/23.
//

#import <Foundation/Foundation.h>
#import "RadioStation.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (nonatomic, strong) id<RadioStationFetcherProtocol> fetcher;
@property (nonatomic, readonly)  NSArray<RadioStation *> * radioStations;
@property (nonatomic, readonly) NSDictionary* radioStationsDic;
@property (class,nonatomic, readonly) NSString *saveFavireKey;

+ (instancetype) sharedInstance;
- (void)getRadioStationsWithSuccess:(void (^)(NSArray<RadioStation*> *radioStations))successCompletion error:(void (^)(NSError *error))errorCompletion;

- (void)getFavoriteStationsWithSuccess:(void (^)(NSArray<RadioStation*> *radioStations))successCompletion;

@end

NS_ASSUME_NONNULL_END
