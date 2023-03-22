//
//  FavoriteViewController.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/20.
//

#import <UIKit/UIKit.h>
#import "FavoriteViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FavoriteViewModel * viewModel;

@end

NS_ASSUME_NONNULL_END
