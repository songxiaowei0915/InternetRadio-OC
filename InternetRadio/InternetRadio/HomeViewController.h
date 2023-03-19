//
//  HomeViewController.h
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewModel.h"
#import "RadioPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, RadioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *miniPlayerView;

@property (nonatomic, strong) ViewModel * viewModel;

@end

NS_ASSUME_NONNULL_END
