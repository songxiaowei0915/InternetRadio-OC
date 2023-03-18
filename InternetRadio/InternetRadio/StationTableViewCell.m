//
//  StationTableViewCell.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "StationTableViewCell.h"


@implementation StationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.statusView setAnimationDuration:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void) setDisplay:(RadioStationDisplay *)display {
    _display = display;

    [self.nameLabel setText:display.name];
    [self.descLabel setText:display.desc];

    if (display.image) {
        [self.homeImageView setImage:display.image];
    } else {
        [self.homeImageView setImage:[display deaultImage]];
        __weak StationTableViewCell *cell = self;
        [display getImage:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.homeImageView setImage:image];
            });
        }];
    }
}

- (void) playAnim {
    [self.statusView setHidden:false];
    [self.statusView startAnimating];
}

- (void) stopAnim {
    [self.statusView setHidden:YES];
    [self.statusView stopAnimating];
}

@end
