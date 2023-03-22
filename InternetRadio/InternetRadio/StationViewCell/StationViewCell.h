//
//  StationViewCell.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/20.
//

#import <UIKit/UIKit.h>
#import "PlayingAnimatedView.h"
#import "RadioStationDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet PlayingAnimatedView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@property (nonatomic, assign) RadioStationDisplay *display;

- (void) playAnim;
- (void) stopAnim;

@end

NS_ASSUME_NONNULL_END
