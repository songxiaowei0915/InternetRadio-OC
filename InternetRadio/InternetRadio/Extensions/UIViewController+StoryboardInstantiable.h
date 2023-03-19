//
//  UIViewController+StoryboardInstantiable.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (StoryboardInstantiable)
+ (NSString *) defaultFileName;
+ (instancetype) instantiateViewController;
@end

NS_ASSUME_NONNULL_END
