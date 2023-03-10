//
//  DataManager.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import <Foundation/Foundation.h>
#import "RadioStation.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

typedef void(^getDataBlock)(NSMutableArray<RadioStation *>* array);

+ (id) sharedInstance;
- (void) getRecommendedStations:(getDataBlock)callback;
- (void) getStationsForSearch:(NSString *) searchTerms completionHandler:(getDataBlock)callback;

@end

NS_ASSUME_NONNULL_END
