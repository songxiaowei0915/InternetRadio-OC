//
//  MiniPlayerViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/19.
//

#import "MiniPlayerViewController.h"
#import "MessageDefine.h"
#import "LoadingPlayerView.h"
#import "RadioPlayer.h"
#import "UIButton+Completion.h"

@interface MiniPlayerViewController () {
    UIView *playView;
    LoadingPlayerView *loadingView;
    UIView *pauseView;
}

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
    [self.statusView setAnimationDuration:1];
    
    [self setupPlayerView];
    [self setupGestures];
}

- (void) setupPlayerView {
    playView = [self buildPlayerView];
    
    UIImageView *viewForPause = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn-pause"]];
    [viewForPause setContentMode:UIViewContentModeScaleAspectFit];
    pauseView = viewForPause;
    
    CGSize size = CGSizeMake(48, 48);
    CGRect frame =  CGRectMake(0, 0, size.width, size.height);
    LoadingPlayerView *viewForLoading = [[LoadingPlayerView alloc] initWithFrame:frame];
    [viewForLoading setUpAnimationWithSize:size Color:UIColor.whiteColor Named:@"pauseFill"];
    loadingView = viewForLoading;
    
    [self.playStackView addArrangedSubview:playView];
    [self.playStackView addArrangedSubview:pauseView];
    [self.playStackView addArrangedSubview:loadingView];
    self.playStackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [playView setHidden:YES];
    [pauseView setHidden:YES];
    [loadingView setHidden:YES];
}

- (void) setupGestures {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureView:)];
    [self.view addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *tapForStack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureStack:)];
    [self.playStackView addGestureRecognizer:tapForStack];
}

- (void) handleGestureView: (UITapGestureRecognizer *) sender {

}

- (void) handleGestureStack: (UITapGestureRecognizer *) sender {
    [[RadioPlayer sharedInstance] togglePlayPause];
}

- (UIView *) buildPlayerView {
    UIImageView *viewForPlay = [[UIImageView alloc]init];
    [viewForPlay setImage:[UIImage imageNamed:@"but-play"]];
    [viewForPlay setContentMode:UIViewContentModeScaleAspectFit];
  
    UIView *wrapperView = [[UIView alloc]initWithFrame:CGRectZero];
    viewForPlay.translatesAutoresizingMaskIntoConstraints = false;
    [wrapperView addSubview:viewForPlay];
    
    NSArray<NSLayoutConstraint *> * constraints = [[NSArray alloc] initWithObjects:
                                                   [viewForPlay.widthAnchor constraintEqualToAnchor:wrapperView.widthAnchor multiplier:0.75],
                                                   [viewForPlay.heightAnchor constraintEqualToAnchor:wrapperView.widthAnchor multiplier:1],
                                                   [viewForPlay.centerXAnchor constraintEqualToAnchor:wrapperView.centerXAnchor],
                                                   [viewForPlay.centerYAnchor constraintEqualToAnchor:wrapperView.centerYAnchor],
                                                   nil];
    [NSLayoutConstraint activateConstraints:constraints];

    return wrapperView;
}

- (void) setDisplay:(RadioStationDisplay *)display {
    _display = display;
    
    [self.nameLabel setText:display.name];
    [self.descLabel setText:display.desc];
    
    [self updateFavoriteState];
}

- (void) playAnim {
    [self.statusView setHidden:NO];
    [self.statusView startAnimating];
}

- (IBAction)favoriteClick:(UIButton *)sender {
    [self.favoriteBtn springAnimate:nil];
    [self.display toggleFavorite];
    [self updateFavoriteState];
    
}

- (void) stopAnim {
    [self.statusView setHidden:YES];
    [self.statusView stopAnimating];
}

- (void) radioStop {
    [self stopAnim];
    
    [loadingView setHidden:YES];
    [playView setHidden:NO];
    [pauseView setHidden:YES];
}

- (void) radioPlaying {
    [self playAnim];
    
    [loadingView setHidden:YES];
    [playView setHidden:YES];
    [pauseView setHidden:NO];
}

- (void) radioPause {
    [self stopAnim];
    
    [loadingView setHidden:YES];
    [playView setHidden:NO];
    [pauseView setHidden:YES];
}

- (void) radioBuffering {
    [self stopAnim];
    
    [loadingView setHidden:NO];
    [playView setHidden:YES];
    [pauseView setHidden:YES];
}

- (void) updateFavoriteState {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *imageFilled = self.display.isFavorite ? [UIImage imageNamed:@"btn-favoriteFill"] : [UIImage imageNamed:@"btn-favorite"];
        [self.favoriteBtn setImage:imageFilled forState:UIControlStateNormal];
    });
}

@end
