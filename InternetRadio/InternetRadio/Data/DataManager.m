//
//  DataManager.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/23.
//

#import "DataManager.h"
#import "RadioStationFetcher.h"
#import "RadioStationParser.h"

@implementation DataManager
static NSString* _saveFavireKey = @"StationsCache.SavedFavorite";
static DataManager *_instance = nil;
+ (instancetype) sharedInstance {
    if (!_instance) {
        _instance = [[self alloc]init];
    }
    
    return _instance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.fetcher = [[RadioStationFetcher alloc] initWithParser:[[RadioStationParser alloc] init]];
    }
    
    return self;
}

- (void) getRadioStationsWithSuccess:(void (^)(NSArray<RadioStation *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    if (self.radioStations) {
        successCompletion(self.radioStations);
    } else {
        [self.fetcher fetchRadioStationsWithSuccess:^(NSArray<RadioStation *> * _Nonnull radioStations) {
            [self setRadioStations:radioStations];
            successCompletion(self.radioStations);
        } error:errorCompletion];
    }
}

- (void) getFavoriteStationsWithSuccess:(void (^)(NSArray<RadioStation *> * _Nonnull))successCompletion {
    if (!self.radioStations) {
        [self getRadioStationsWithSuccess:^(NSArray<RadioStation *> * _Nonnull radioStations) {
            [self setRadioStations:radioStations];
            [self.fetcher fetchFavoriteStationsWithSuccess:^(NSArray<RadioStation *> * _Nonnull radioStations) {
                successCompletion(radioStations);
            }];
        } error:^(NSError * _Nonnull error) {
            
        }];
    } else {
        [self.fetcher fetchFavoriteStationsWithSuccess:^(NSArray<RadioStation *> * _Nonnull radioStations) {
            successCompletion(radioStations);
        }];
    }
}

- (void) setRadioStations:(NSArray<RadioStation *> * _Nonnull)radioStations {
    self->_radioStations = radioStations;
    [self resetRadiosDic];
}

- (void) resetRadiosDic {
    NSMutableDictionary *stationsDic = [NSMutableDictionary dictionary];
    for (RadioStation *station in self.radioStations) {
        [stationsDic setValue:station forKey:station.stationuuid];
    }
    self->_radioStationsDic = stationsDic;
}

+ (NSString *) saveFavireKey {
    return _saveFavireKey;
}

@end
