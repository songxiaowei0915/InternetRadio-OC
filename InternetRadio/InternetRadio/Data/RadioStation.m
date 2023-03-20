//
//  RadioStation.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "RadioStation.h"

@implementation RadioStation 

- (instancetype) initWithUUID:(NSString *)uuid named:(NSString *)name url:(NSString *)url imageUrl:(NSString *)imageUrl tags:(NSString *)tags country:(NSString *)country countryCode:(NSString *)countrycode language:(NSString *)language state:(NSString *)state votes:(NSInteger)votes {
    self = [super init];
    
    if (self) {
        _stationuuid = uuid;
        _name = name;
        _url = url;
        _imageUrl = imageUrl;
        _tags = tags;
        _country = country;
        _countrycode = countrycode;
        _language = language;
        _state = state;
        _votes = votes;
    }
    
    return self;
}

@end
