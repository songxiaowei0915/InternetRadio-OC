//
//  NetworkManager.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "NetworkManager.h"

@implementation NetworkManager

static NetworkManager *_instance = nil;
const NSString *PARAMS = @"?filter=s:bit32*&render=json&formats=mp3,aac,ogg,flash,hls";

+ (id) sharedInstance {
    if (!_instance) {
        _instance = [[self alloc]init];
    }
    
    return _instance;
}

- (void) loadDataWithURL:(NSString *)url completionHandler:(getRequestBlock)callback {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dict = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSASCIIStringEncoding error:&error];
                NSMutableArray *jsonArray = dict[@"body"];
                if (jsonArray) {
                    callback(jsonArray);
                }
                

        }] resume];
}

- (void) getRecommendedStations:(getRequestBlock)callback {
    NSString *url = [[NSString alloc] initWithFormat:@"http://opml.radiotime.com/Browse.ashx%@&c=trending", PARAMS];
    [self loadDataWithURL:url completionHandler:callback];
}

- (void) getStationsForSearch:(NSString *)searchTerms completionHandler:(getRequestBlock)callback {
    NSString *searchTermsEncoded = [searchTerms stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *url = [[NSString alloc] initWithFormat:@"http://opml.radiotime.com/Search.ashx%@&render=json&query=%@", PARAMS,searchTermsEncoded];
    [self loadDataWithURL:url completionHandler:callback];
}

@end
