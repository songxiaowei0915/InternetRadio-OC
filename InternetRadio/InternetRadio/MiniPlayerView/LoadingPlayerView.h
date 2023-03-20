//
//  LoadingPlayerView.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingPlayerView : UIView

- (void) setUpAnimationWithSize: (CGSize)size Color: (UIColor *)color Named:(NSString *) imageName;

@end

NS_ASSUME_NONNULL_END
