//
//  FavoriteViewModel.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/20.
//

#import "FavoriteViewModel.h"

@implementation FavoriteViewModel

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.items = @[];
    }
    
    return self;
}

- (NSInteger) numberOfItems {
    return self.items.count;
}

- (NSUInteger)numberOfSections {
    return 1;
}

@end
