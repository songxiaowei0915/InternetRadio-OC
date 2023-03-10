//
//  RadioStation.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "RadioStation.h"

@implementation RadioStation 

- (id) initWithName:(NSString *)name withURL:(NSString *)url withImage:(NSString *)image withDesc:(NSString *)desc {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
        _image = image;
        _desc = desc;
    }
    
    return  self;
}

@end
