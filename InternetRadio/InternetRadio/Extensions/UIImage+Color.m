//
//  UIImage+Color.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/16.
//

#import "UIImage+Color.h"

@implementation UIImage(Color)

- (UIImage *) withColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
    CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color setFill];
    UIRectFill(drawRect);
    [self drawInRect:drawRect blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

@end
