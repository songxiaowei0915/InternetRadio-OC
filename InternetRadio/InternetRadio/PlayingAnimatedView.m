//
//  PlayingAnimatedView.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/15.
//

#import "PlayingAnimatedView.h"
#import "UIImage+Color.h"

@interface PlayingAnimatedView () {
    UIColor *imageColor;
}

@end

@implementation PlayingAnimatedView

- (instancetype) initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self setupAnimationImages];
    }
    
    return self;
}

- (void) setupAnimationImages {
    [self setAnimationImages:[self animFrames]];
}

- (void) setImagesColor:(UIColor *)color {
    imageColor = color;
    [self setupAnimationImages];
}

-(NSArray<UIImage *> *) animFrames {
    NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
    for (int i = 0; i <= 3; i++) {
        NSString *name = [NSString stringWithFormat:@"NowPlayingBars-%d",i];
        UIImage *image = [[UIImage imageNamed:name] withColor:imageColor];
        [animationFrames addObject:image];
    }
    
    for (int i = 2; i >= 0; i--) {
        NSString *name = [NSString stringWithFormat:@"NowPlayingBars-%d",i];
        UIImage *image = [[UIImage imageNamed:name] withColor:imageColor];
        [animationFrames addObject:image];
    }
    
    return animationFrames;
}

@end
