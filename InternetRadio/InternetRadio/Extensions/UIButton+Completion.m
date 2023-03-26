//
//  UIButton+Completion.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/22.
//

#import "UIButton+Completion.h"

@implementation UIButton (Completion)

- (void) springAnimate: (nullable void (^)(void)) completion {
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.1 delay:0.1 usingSpringWithDamping:0.1 initialSpringVelocity:6.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

@end
