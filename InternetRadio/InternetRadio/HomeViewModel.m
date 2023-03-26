//
//  HomeViewModel.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "HomeViewModel.h"
#import "RadioStationFetcher.h"
#import "RadioStationParser.h"

@implementation HomeViewModel

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.items = @[];
        self.fetcher = [[RadioStationFetcher alloc] initWithParser:[[RadioStationParser alloc] init]];
    }
    
    return self;
}

- (void) getHomeRadioStationsWithSuccess:(void (^)(NSArray<RadioStationDisplay *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    if (self.radioStationDisplays) {
        NSString * countryCode = [[NSLocale currentLocale] countryCode];
        NSArray *items = [self getDataByCounryCode:countryCode];
        [self setItems:items];
        successCompletion(items);
    } else {
        [self.fetcher fetchRadioStationsWithSuccess:^(NSArray<RadioStation *> * _Nonnull radioStations) {
            self->_radioStationDisplays = [self setDisplays:radioStations];
            NSString * countryCode = [[NSLocale currentLocale] countryCode];
            NSArray *items = [self getDataByCounryCode:countryCode];
            [self setItems:items];
            successCompletion(items);
        } error:errorCompletion];
    }
}

- (NSArray *) setDisplays:(NSArray<RadioStation *> *) radioStations {
    NSMutableArray *displays = [[NSMutableArray alloc] init];
    for (RadioStation *station in radioStations) {
        [displays addObject:[[RadioStationDisplay alloc] initWithRaioStation:station]];
    }
    return displays;
}

- (NSArray<RadioStationDisplay *> *) getDataByCounryCode: (NSString *)countryCode {
    NSMutableArray *displays = [[NSMutableArray alloc] init];
    for (RadioStationDisplay *display in self.radioStationDisplays) {
        RadioStation *station = display.station;
        if ([station.countrycode isEqualToString:countryCode]) {
            [displays addObject:display];
        }
    }
    
    return [self sortlArray:displays];
}

- (void) searchRadioStations:(NSString *)searchText completionHandler:(void (^)(NSArray<RadioStationDisplay *> * _Nonnull))successCompletion {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (RadioStationDisplay *display in self.radioStationDisplays) {
        RadioStation *station = display.station;
        if ([station.name containsString:searchText] || [station.tags containsString:searchText] || [station.country containsString:searchText] || [station.countrycode isEqualToString:searchText] || [station.language containsString:searchText] || [station.state containsString:searchText]) {
            [items addObject:display];
        }
    }
    [self setItems:items];
    successCompletion(items);
}

- (NSArray *)sortlArray: (NSArray<RadioStationDisplay *> *) displays {
    NSArray *sortedArray = [displays sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(RadioStationDisplay *obj1, RadioStationDisplay *obj2) {
            return obj1.station.votes < obj2.station.votes;
        }];
    
    return sortedArray;
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
