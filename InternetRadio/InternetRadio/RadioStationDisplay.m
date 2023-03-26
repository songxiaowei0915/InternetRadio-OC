//
//  RadioStationDisplay.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "RadioStationDisplay.h"

@interface RadioStationDisplay () {
    
}

@end

@implementation RadioStationDisplay

- (instancetype) initWithRaioStation:(nonnull RadioStation *)radioStation {
    self = [super init];
    
    if (self) {
        _station = radioStation;
        _stationuuid = radioStation.stationuuid;
        _name = radioStation.name;
        _url = [NSURL URLWithString:radioStation.url];
        if (radioStation.imageUrl.length != 0) {
            _imageUrl= [NSURL URLWithString:radioStation.imageUrl];
        } else {
            _imageUrl = nil;
        }
        _desc = radioStation.tags;
    }
        
    return self;
}

- (void) toggleFavorite {
    _isFavorite = !_isFavorite;
}

//- (void) getImage: (void (^)(UIImage *))callback {
//    if (self.image) {
//        if(callback) {
//            callback(self.image);
//        }
//        return;
//    }
//
//    if (!self.imageUrl) {
//        self->_image = [self deaultImage];
//        if(callback) {
//            callback(self.image);
//        }
//        return;
//    }
//
//    [[[NSURLSession sharedSession] dataTaskWithURL:_imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!data || error) {
//            self->_image = [self deaultImage];
//            if(callback) {
//                callback(self.image);
//            }
//            return;
//        }
//
//        self->_image = [UIImage imageWithData:data];
//        if(callback) {
//            callback(self.image);
//        }
//    }] resume];
//}

- (UIImage *) deaultImage {
    return [UIImage imageNamed:@"radio-default"];
}

- (void) getImage:(void (^)(UIImage *))callback {
    if (self.image) {
        if(callback) {
            callback(self.image);
        }
        return;
    }
        
    if (!self.imageUrl) {
        self->_image = [self deaultImage];
        if(callback) {
            callback(self.image);
        }
        return;
    }

    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    if (!documentsURL) {
        self->_image = [self deaultImage];
        if(callback) {
            callback(self.image);
        }
        return;
    }

    NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[self.stationuuid stringByAppendingString:@".png"]];
    NSString *filePath = fileURL.path;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        self->_image = image;
        if(callback) {
            callback(self.image);
        }
        return;
    }

    [[[NSURLSession sharedSession] downloadTaskWithURL:self.imageUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (location && !error) {
            @try {
                [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:nil];
                UIImage *image = [UIImage imageWithContentsOfFile:fileURL.path];
                self->_image = image;
                if(callback) {
                    callback(self.image);
                }
            } @catch (NSException *exception) {
                NSLog(@"Error creating a file %@ : %@", fileURL, exception);
            }
        }
        }] resume];
}

@end
