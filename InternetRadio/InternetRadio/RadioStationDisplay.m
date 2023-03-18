//
//  RadioStationDisplay.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "RadioStationDisplay.h"

@implementation RadioStationDisplay

- (instancetype) initWithRaioStation:(nonnull RadioStation *)radioStation {
    self = [super init];
    
    if (self) {
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

- (void) getImage: (void (^)(UIImage *))callback {
    if (self.image) {
        callback(self.image);
        return;
    }
    
    if (!self.imageUrl) {
        self->_image = [self deaultImage];
        callback(self.image);
        return;
    }
    
    [[[NSURLSession sharedSession] dataTaskWithURL:_imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data || error) {
            self->_image = [self deaultImage];
            callback(self->_image);
            return;
        }
        
        self->_image = [UIImage imageWithData:data];
        callback(self->_image);
    }] resume];
}

- (UIImage *) deaultImage {
    return [UIImage imageNamed:@"radio-default"];
}

//- (void) getImage:(void (^)(UIImage *))callback {
//    if (!self.imageUrl) {
//        UIImage *image = [UIImage imageNamed:@"radio-default"];
//        self->_image = image;
//        callback(image);
//        return;
//    }
//
//    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
//    if (!documentsURL) {
//        return;
//    }
//
//    NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[self.stationuuid stringByAppendingString:@".png"]];
//    NSString *filePath = fileURL.path;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *image = [UIImage imageWithContentsOfFile:filePath];
//            callback(image);
//            return;
//        });
//    }
//
//    [[[NSURLSession sharedSession] downloadTaskWithURL:self.imageUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (location && !error) {
//            @try {
//                [[NSFileManager defaultManager] copyItemAtURL:location toURL:fileURL error:nil];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIImage *image = [UIImage imageWithContentsOfFile:fileURL.path];
//                    callback(image);
//                });
//            } @catch (NSException *exception) {
//                NSLog(@"Error creating a file %@ : %@", fileURL, exception);
//            }
//        }
//        }] resume];
//}

@end
