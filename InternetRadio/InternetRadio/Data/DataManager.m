//
//  DataManager.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "DataManager.h"
#import "NetworkManager.h"

@implementation DataManager

static DataManager *_instance = nil;

+ (id) sharedInstance {
    if (!_instance) {
        _instance = [[self alloc]init];
    }
    
    return _instance;
}

- (void) getRecommendedStations:(getDataBlock)callback {
    [[NetworkManager sharedInstance] getRecommendedStations:^(NSMutableArray * array) {
        callback([self parseResponse:array]);
    }];
}

- (void) getStationsForSearch:(NSString *)searchTerms completionHandler:(getDataBlock)callback {
    [[NetworkManager sharedInstance] getStationsForSearch:searchTerms completionHandler:^(NSMutableArray<RadioStation *> * array) {
            callback([self parseResponse:array]);
    }];
}

- (NSMutableArray<RadioStation *>*) parseResponse:(NSMutableArray* ) responseBody  {
    NSMutableArray<RadioStation *>* results = [[NSMutableArray alloc] init];
    
    for (NSDictionary *obj in responseBody) {
        NSString *name = obj[@"text"];
        NSString *streamURL = obj[@"URL"];
        NSString *type = obj[@"type"];
        if (!name || !streamURL || !type) {
            continue;
        }
        
        if(![type isEqualToString:@"audio"]) {
            continue;
        }
        
        NSString *imageURL = @"";
        if (obj[@"image"]) {
            imageURL = obj[@"image"];
        }
        
        NSString *desc = @"";
        if (obj[@"subtext"]) {
            desc = obj[@"subtext"];
        }
        
        RadioStation *station = [[RadioStation alloc] initWithName:name withURL:streamURL withImage:imageURL withDesc:desc];
        [results addObject:station];
    }
    
    return  results;
}

@end
