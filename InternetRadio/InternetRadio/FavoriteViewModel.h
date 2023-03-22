//
//  FavoriteViewModel.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/20.
//

#import <Foundation/Foundation.h>
#import "RadioStationDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteViewModel : NSObject

@property (nonatomic, strong) NSArray<RadioStationDisplay *> *items;

- (NSInteger) numberOfItems;
- (NSUInteger)numberOfSections;

@end

NS_ASSUME_NONNULL_END
