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

- (void) getRadioStationsWithSuccess:(void (^)(NSArray<RadioStationDisplay *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    if (self.radioStations) {
        NSString * countryCode = [[NSLocale currentLocale] countryCode];
        NSArray *stations = [self getDataByCounryCode:countryCode];
        NSArray *items = [self organizationalItems:stations];
        [self setItems:items];
        successCompletion(items);
    } else {
        [self.fetcher fetchRadioStationsWithSuccess:^(NSArray<RadioStation *> * _Nonnull radioStations) {
            self->_radioStations = radioStations;
            NSString * countryCode = [[NSLocale currentLocale] countryCode];
            NSArray *stations = [self getDataByCounryCode:countryCode];
            NSArray *items = [self organizationalItems:stations];
            [self setItems:items];
            successCompletion(items);
        } error:errorCompletion];
    }
}

- (NSArray *) getDataByCounryCode: (NSString *)countryCode {
    NSMutableArray *stations = [[NSMutableArray alloc] init];
    for (RadioStation *station in self.radioStations) {
        if ([station.countrycode isEqualToString:countryCode]) {
            [stations addObject:station];
        }
    }
    
    return stations;
}

- (void) searchRadioStations:(NSString *)searchText completionHandler:(void (^)(NSArray<RadioStationDisplay *> * _Nonnull))successCompletion {
    NSMutableArray *stations = [[NSMutableArray alloc] init];
    for (RadioStation *station in self.radioStations) {
        if ([station.name containsString:searchText] || [station.tags containsString:searchText] || [station.country containsString:searchText] || [station.countrycode isEqualToString:searchText] || [station.language containsString:searchText] || [station.state containsString:searchText]) {
            [stations addObject:station];
        }
    }
    NSArray *items = [self organizationalItems:stations];
    [self setItems:items];
    successCompletion(items);
}

- (NSArray *)organizationalItems:(NSArray<RadioStation *> *) radioStations {
    NSArray *sortedArray = [radioStations sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(RadioStation *obj1, RadioStation *obj2) {
            return obj1.votes < obj2.votes;
        }];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (RadioStation *station in sortedArray) {
        [items addObject:[[RadioStationDisplay alloc] initWithRaioStation:station]];
    }
    return items;
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
