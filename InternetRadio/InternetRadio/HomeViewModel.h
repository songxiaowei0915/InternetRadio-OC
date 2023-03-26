//
//  HomeViewModel.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import "RadioStationDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

@property (nonatomic, readonly)  NSArray<RadioStationDisplay *> * radioStationDisplays;
@property (nonatomic, strong) id<RadioStationFetcherProtocol> fetcher;
@property (nonatomic, strong) NSArray<RadioStationDisplay *> *items;

- (void)getHomeRadioStationsWithSuccess:(void (^)(NSArray<RadioStationDisplay*> *radioStations))successCompletion error:(void (^)(NSError *error))errorCompletion;
- (void)searchRadioStations:(NSString *)searchText completionHandler:(void (^)(NSArray<RadioStationDisplay*> *radioStations))successCompletion;

- (NSInteger) numberOfItems;
- (NSUInteger)numberOfSections;
- (RadioStationDisplay *) itemAtIndexPath: (NSIndexPath *) indexPath;

@end

NS_ASSUME_NONNULL_END
