//
//  NetworkManager.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+ (instancetype) sharedInstance;
- (void) loadDataWithURL: (NSString *)api completionHandler:(void (^)(NSArray* jsonArray))callback;
- (void) getStationList: (void (^)(NSArray* jsonArray))callback;
- (void) getStationListByCountryCode:(NSString *)contrycode completionHandler:(void (^)(NSArray* jsonArray))callback;
- (void) getStationListByName:(NSString *)name completionHandler:(void (^)(NSArray* jsonArray))callback;

@end

NS_ASSUME_NONNULL_END
