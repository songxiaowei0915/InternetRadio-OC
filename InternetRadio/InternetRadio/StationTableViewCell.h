//
//  StationTableViewCell.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <UIKit/UIKit.h>
#import "RadioStationDisplay.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


- (void) setDisplay: (RadioStationDisplay *)display;

@end

NS_ASSUME_NONNULL_END
