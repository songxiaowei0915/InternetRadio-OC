//
//  ViewModel.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <Foundation/Foundation.h>
#import "RadioStationDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

@property (nonatomic, strong) id<RadioStationFetcherProtocol> fetcher;
@property (nonatomic, strong) NSArray<RadioStationDisplay *> *items;

- (void)getRadioStationsWithSuccess:(void (^)(NSArray<RadioStationDisplay*> *radioStations))successCompletion error:(void (^)(NSError *error))errorCompletion;

- (NSInteger) numberOfItems;
- (NSUInteger)numberOfSections;
- (RadioStationDisplay *) itemAtIndexPath: (NSIndexPath *) indexPath;

@end

NS_ASSUME_NONNULL_END
