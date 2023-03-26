//
//  RadioStationFetcher.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "RadioStationFetcher.h"
#import "NetworkManager.h"
#import "DataManager.h"

@implementation RadioStationFetcher

- (instancetype)initWithParser:(id<RadioStationParserProtocol>)parser
{
    self = [super init];
    if (self) {
        self.parser = parser;
    }
    return self;
}

- (void)fetchRadioStationsWithSuccess:(nonnull void (^)(NSArray<RadioStation *> * _Nonnull))successCompletion error:(nonnull void (^)(NSError * _Nonnull))errorCompletion { 
    
    __weak RadioStationFetcher * weakSelf = self;
        
    void (^dataResponse)(NSArray *) = ^(NSArray *jsonArray){
        [weakSelf.parser parseRadioStations:jsonArray withSuccess:successCompletion error:errorCompletion];
    };
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[NetworkManager sharedInstance] getStationList:dataResponse];
    });
}

- (void) fetchFavoriteStationsWithSuccess:(void (^)(NSArray<RadioStation *> * _Nonnull))successCompletion {
    
    __weak RadioStationFetcher * weakSelf = self;
    
    void (^dataResponse)(NSArray *) = ^(NSArray<NSString *> *dataArray) {
        [weakSelf.parser parseFavoriteStations:dataArray withSuccess:successCompletion];
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *dataArray = [userDefaults arrayForKey:DataManager.saveFavireKey];
        dataResponse(dataArray);
    });
}

@end
