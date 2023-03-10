//
//  NetworkManager.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject {
    
}

typedef void(^getRequestBlock)(NSMutableArray* jsonArray);

+ (id) sharedInstance;
- (void) loadDataWithURL: (NSString *)url completionHandler:(getRequestBlock)callback;
- (void) getRecommendedStations:(getRequestBlock)callback;
- (void) getStationsForSearch:(NSString *) searchTerms completionHandler:(getRequestBlock)callback;

@end

NS_ASSUME_NONNULL_END
