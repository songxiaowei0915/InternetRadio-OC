//
//  MiniPlayerViewController.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/19.
//

#import <UIKit/UIKit.h>
#import "RadioStationDisplay.h"
#import "PlayingAnimatedView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MiniPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet PlayingAnimatedView *statusView;
@property (weak, nonatomic) IBOutlet UIStackView *playStackView;

@property (nonatomic, assign) RadioStationDisplay *display;

- (void) playAnim;
- (void) stopAnim;

@end

NS_ASSUME_NONNULL_END
