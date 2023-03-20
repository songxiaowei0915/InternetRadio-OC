//
//  LoadingPlayerView.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/20.
//

#import "LoadingPlayerView.h"

@implementation LoadingPlayerView

- (void) setUpAnimationWithSize:(CGSize)size Color:(UIColor *)color Named:(NSString *)imageName {
    CFTimeInterval duration = 0.75;
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    [rotateAnimation setValues:@[@0, @M_PI, @(2*M_PI)]];
    
    CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
    [animation setAnimations:@[rotateAnimation]];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    animation.duration = duration;
    animation.repeatCount = HUGE;
    [animation setRemovedOnCompletion:false];
    
    CGSize newScaleSize = CGSizeMake(size.width * 0.5, size.height * 0.5);
    UIView *image = [self getImageWithSize:newScaleSize imageNamed:imageName];
    CALayer *imageLayer = image.layer;
    imageLayer.position = self.center;
    [self.layer addSublayer:imageLayer];
    
    CGSize sizeForCircle = CGSizeMake(size.width * 0.9,size.height * 0.9);
    CAShapeLayer *circle = [self getRingThirdFourWithSize:sizeForCircle Color:color];
    CGRect frame = CGRectMake((self.layer.bounds.size.width - sizeForCircle.width) / 2,
                       (self.layer.bounds.size.height - sizeForCircle.height) / 2,
                              sizeForCircle.width,sizeForCircle.height);
    
    circle.frame = frame;
    [circle addAnimation:animation forKey:@"animation"];
    [self.layer addSublayer:circle];
}

- (UIView *)getImageWithSize: (CGSize)size imageNamed: (NSString*) imageName {
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    UIImage *image = [UIImage imageNamed:imageName];
  
    UIImageView *playImageView = [[UIImageView alloc]initWithImage:image];
    playImageView.contentMode = UIViewContentModeScaleAspectFit;
    playImageView.frame = frame;
    return playImageView;
}

- (CAShapeLayer *) getRingThirdFourWithSize:(CGSize)size  Color:(UIColor *)color {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(size.width / 2, size.height / 2) radius:size.width / 2 startAngle:-3 * M_PI/4 endAngle:-M_PI/4 clockwise:false];
    [layer setFillColor:nil];
    [layer setStrokeColor:color.CGColor];
    [layer setLineWidth:2];
    
    [layer setBackgroundColor:nil];
    [layer setPath:path.CGPath];
    [layer setFrame:CGRectMake(0, 0, size.width, size.height)];
  
    return layer;
}

@end
