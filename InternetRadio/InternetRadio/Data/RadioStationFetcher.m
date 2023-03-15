//
//  RadioStationFetcher.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "RadioStationFetcher.h"
#import "NetworkManager.h"

@implementation RadioStationFetcher

- (instancetype)initWithParser:(id<RadioStationParserProtocol>)parser
{
    self = [super init];
    if (self) {
        self.parser = parser;
    }
    return self;
}

- (void)fetchRadioStationsWithSuccess:(nonnull void (^)(NSMutableArray<RadioStation *> * _Nonnull))successCompletion error:(nonnull void (^)(NSError * _Nonnull))errorCompletion { 
    
    __weak RadioStationFetcher * weakSelf = self;
        
    void (^dataResponse)(NSArray *) = ^(NSArray *jsonArray){
        [weakSelf.parser parseRadioStations:jsonArray withSuccess:successCompletion error:errorCompletion];
    };
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString * countryCode = [[NSLocale currentLocale] countryCode];
        [[NetworkManager sharedInstance] getStationListByCountryCode:countryCode completionHandler:dataResponse];
    });
}

@end
