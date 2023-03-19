//
//  MiniPlayerViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/19.
//

#import "MiniPlayerViewController.h"
#import "MessageDefine.h"

@interface MiniPlayerViewController ()

@end

@implementation MiniPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioStop) name:MessageDefine.RADIOPLAYER_STOP object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioPlaying) name:MessageDefine.RADIOPLAYER_PLAYING object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioPause) name:MessageDefine.RADIOPLAYER_PAUSE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioBuffering) name:MessageDefine.RADIOPLAYER_BUFFERING object:nil];
    
    [self.statusView setImagesColor:UIColor.whiteColor];
    [self.statusView setupAnimationImages];
    [self.statusView setAnimationDuration:1];
    
    
}

- (void) setDisplay:(RadioStationDisplay *)display {
    _display = display;
    
    [self.nameLabel setText:display.name];
    [self.descLabel setText:display.desc];
}

- (void) playAnim {
    [self.statusView.superview setHidden:NO];
    [self.statusView startAnimating];
}

- (void) stopAnim {
    [self.statusView.superview setHidden:YES];
    [self.statusView stopAnimating];
}

- (void) loading {
    
}

- (void) loadingOver {
    
}

- (void) radioStop {
    [self stopAnim];
}

- (void) radioPlaying {
    [self playAnim];
}

- (void) radioPause {
    [self stopAnim];
}

- (void) radioBuffering {
    [self stopAnim];
}


@end
