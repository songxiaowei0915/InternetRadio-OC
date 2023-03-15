//
//  ViewModel.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "ViewModel.h"
#import "RadioStationFetcher.h"
#import "RadioStationParser.h"

@implementation ViewModel

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.items = @[];
        self.fetcher = [[RadioStationFetcher alloc] initWithParser:[[RadioStationParser alloc] init]];
    }
    
    return self;
}

- (void) getRadioStationsWithSuccess:(void (^)(NSArray<RadioStationDisplay *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    __weak ViewModel *weakSelf = self;
    [self.fetcher fetchRadioStationsWithSuccess:^(NSMutableArray<RadioStation *> * _Nonnull radioStations) {
        NSArray *sortedArray = [radioStations sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(RadioStation *obj1, RadioStation *obj2) {
                return obj1.votes < obj2.votes;
            }];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (RadioStation *station in sortedArray) {
            [items addObject:[[RadioStationDisplay alloc] initWithRaioStation:station]];
        }
        
        [weakSelf setItems:items];
        successCompletion(items);
    } error:errorCompletion];
}

- (NSInteger) numberOfItems {
    return self.items.count;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (RadioStationDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count ) {
        return nil;
    }
    
    return self.items[indexPath.row];
}

@end
