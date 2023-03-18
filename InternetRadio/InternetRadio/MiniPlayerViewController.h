//
//  MiniPlayerViewController.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/16.
//

#import <UIKit/UIKit.h>
#import "AnimatedView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MiniPlayerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UIImageView *playingImageView;
@property (weak, nonatomic) IBOutlet AnimatedView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (IBAction)favoriteClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
