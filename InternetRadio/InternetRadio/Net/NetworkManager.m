//
//  NetworkManager.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "NetworkManager.h"

@implementation NetworkManager

static NetworkManager *_instance = nil;
const NSString *baseURL = @"http://nl1.api.radio-browser.info/json/";

+ (instancetype) sharedInstance {
    if (!_instance) {
        _instance = [[self alloc]init];
    }
    
    return _instance;
}

- (void) loadDataWithURL:(NSString *)api completionHandler:(void (^)(NSArray* jsonArray))callback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURL, api]];
    if (!url) {
        NSLog(@"url error!");
        return;
    }
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error);
                return;
            }
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (!httpResponse || httpResponse.statusCode != 200) {
                NSLog(@"Response error!");
                return;
            }
            
            NSArray *jsonArray = (NSArray*)[NSJSONSerialization JSONObjectWithData:data options:NSASCIIStringEncoding error:&error];
            if (jsonArray) {
                callback(jsonArray);
            }
        }] resume];
}

- (void) getStationList: (void (^)(NSArray* jsonArray))callback {
    NSString *api = @"stations";
    [self loadDataWithURL:api completionHandler:callback];
}

- (void) getStationListByCountryCode:(NSString *)contrycode completionHandler:(void (^)(NSArray * _Nonnull))callback {
    NSString *api = @"stations/bycountrycodeexact/";
    [self loadDataWithURL:[[api stringByAppendingString:contrycode] lowercaseString] completionHandler:callback];
}

@end
