//
//  RadioStationParser.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "RadioStationParser.h"

@implementation RadioStationParser


- (void)parseRadioStations:(nonnull NSArray *)jsonArray withSuccess:(nonnull void (^)(NSArray<RadioStation *> * _Nonnull))successCompletion error:(nonnull void (^)(NSError * _Nonnull))errorCompletion {
    
    NSMutableArray<RadioStation *>* stations = [[NSMutableArray alloc] init];

    for (NSDictionary *obj in jsonArray) {
        NSString *stationuuid = obj[@"stationuuid"];
        NSString *name = obj[@"name"];
        NSString *url = obj[@"url"];
        if (stationuuid.length == 0 || name.length == 0 || url.length == 0) {
            continue;
        }
        NSString *favicon = obj[@"favicon"];
        NSString *tags = obj[@"tags"];
        NSString *language = obj[@"language"];
        NSString *country = obj[@"country"];
        NSString *countrycode = obj[@"countrycode"];
        NSString *state = obj[@"state"];
        NSInteger votes = [obj[@"votes"] intValue];
        
        RadioStation *station = [[RadioStation alloc] initWithUUID:stationuuid named:name url:url imageUrl:favicon tags:tags country:country countryCode:countrycode language:language state:state votes:votes];
        [stations addObject:station];
    }
    
    successCompletion(stations);
}

@end
