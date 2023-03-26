//
//  RadioStation.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadioStation : NSObject

@property (nonatomic, readonly) NSString *stationuuid;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *url;
@property (nonatomic, readonly) NSString *imageUrl;
@property (nonatomic, readonly) NSString *tags;
@property (nonatomic, readonly) NSString *country;
@property (nonatomic, readonly) NSString *countrycode;
@property (nonatomic, readonly) NSString *language;
@property (nonatomic, readonly) NSString *state;
@property (nonatomic, readonly) NSInteger votes;

- (instancetype) initWithUUID:(NSString *)uuid named:(NSString *)name url:(NSString *)url imageUrl:(NSString *)imageUrl tags:(NSString *)tags country:(NSString *)country countryCode:(NSString *)countrycode language:(NSString *)language state:(NSString *)state votes:(NSInteger)votes;

@end

@protocol RadioStationParserProtocol <NSObject>

- (void)parseRadioStations:(NSArray *)jsonArray withSuccess:(void (^)(NSArray<RadioStation *> *radioStations))successCompletion error:(void (^)(NSError *error))errorCompletion;

- (void)parseFavoriteStations:(NSArray<NSString *> *)dataArray withSuccess:(void (^)(NSArray<RadioStation *> *radioStations))successCompletion;

@end

@protocol RadioStationFetcherProtocol <NSObject>

- (void)fetchRadioStationsWithSuccess:(void (^)(NSArray<RadioStation *> *radioStations))successCompletion error:(void (^)(NSError *error))errorCompletion;

- (void)fetchFavoriteStationsWithSuccess:(void (^)(NSArray<RadioStation *> *radioStations))successCompletion;

@end

NS_ASSUME_NONNULL_END
