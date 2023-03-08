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

typedef void(^postRequestBlock)(NSMutableArray* jsonArray);

+ (id) sharedInstance;
- (void) loadDataWithURL: (NSString *)url completionHandler:(postRequestBlock)callback;
- (void) getRecommendedStations:(postRequestBlock)callback;
- (void) getStationsForSearch:(NSString *) searchTerms completionHandler:(postRequestBlock)callback;

@end

NS_ASSUME_NONNULL_END
