//
//  StationTableViewCell.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <UIKit/UIKit.h>
#import "RadioStationDisplay.h"
#import "AnimatedView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationTableViewCell : UITableViewCell {
   
}

@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet AnimatedView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (nonatomic, assign) RadioStationDisplay *display;

- (void) playAnim;
- (void) stopAnim;

@end

NS_ASSUME_NONNULL_END
