//
//  AnimatedView.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/15.
//

#import "AnimatedView.h"
#import "UIImage+Color.h"

@implementation AnimatedView

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self setAnimationImages:[self animFrames]];
    }
    
    return self;
}

-(NSArray<UIImage *> *) animFrames {
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 3; i++) {
        NSString *name = [NSString stringWithFormat:@"NowPlayingBars-%d",i];
        UIImage *image = [[UIImage imageNamed:name] withColor:UIColor.blackColor];
        [animationFrames addObject:image];
    }
    
    for (int i = 2; i >= 0; i--) {
        NSString *name = [NSString stringWithFormat:@"NowPlayingBars-%d",i];
        UIImage *image = [[UIImage imageNamed:name] withColor:UIColor.blackColor];
        [animationFrames addObject:image];
    }
    
    return animationFrames;
}

@end
