//
//  RadioStationParser.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "RadioStationParser.h"

@implementation RadioStationParser


- (void)parseRadioStations:(nonnull NSArray *)jsonArray withSuccess:(nonnull void (^)(NSMutableArray<RadioStation *> * _Nonnull))successCompletion error:(nonnull void (^)(NSError * _Nonnull))errorCompletion {
    
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
        
        RadioStation *station = [[RadioStation alloc] initWithUUID:stationuuid withName:name withUrl:url withImageUrl:favicon withTags:tags withCountry:country withCountryCode:countrycode withLanguage:language withState:state withVotes:votes];
        [stations addObject:station];
    }
    
    successCompletion(stations);
}

@end
