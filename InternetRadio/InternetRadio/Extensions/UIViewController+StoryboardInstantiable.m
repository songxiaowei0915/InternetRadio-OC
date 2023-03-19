//
//  UIViewController+StoryboardInstantiable.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/18.
//

#import "UIViewController+StoryboardInstantiable.h"

@implementation UIViewController (StoryboardInstantiable)

+ (NSString *) defaultFileName {
    return  [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
}

+ (instancetype) instantiateViewController {
    NSString *fileName = [self defaultFileName];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:fileName bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    return viewController;
}

@end
