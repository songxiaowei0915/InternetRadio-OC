//
//  UIButton+Completion.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Completion)

- (void) springAnimate: (nullable void (^)(void)) completion;

@end

NS_ASSUME_NONNULL_END
