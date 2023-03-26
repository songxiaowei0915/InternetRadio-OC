//
//  HomeViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "HomeViewController.h"
#import "StationViewCell.h"
#import "MiniPlayerViewController.h"
#import "UIViewController+StoryboardInstantiable.h"

@interface HomeViewController () {
    NSIndexPath *selectIndexPath;
    NSTimer *delayPlay;
    MiniPlayerViewController *miniPlayer;
}
    
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[HomeViewModel alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"StationViewCell" bundle:nil] forCellReuseIdentifier:@"StationViewCell"];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.searchBar setDelegate:self];
    [[RadioPlayer sharedInstance] setDelegate:self];
    [self setupMiniPlayerView];
    
    [self getData];
}

- (void) getData {
    __weak HomeViewController *weakSelf = self;
    [self.viewModel getHomeRadioStationsWithSuccess:^(NSArray<RadioStationDisplay *> * _Nonnull radioStations) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
        
    }];
}

- (void) searchData:(NSString *) searchText {
    __weak HomeViewController *weakSelf = self;
    [self.viewModel searchRadioStations:searchText completionHandler:^(NSArray<RadioStationDisplay *> * _Nonnull radioStations) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchData:searchBar.text];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self getData];
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    StationViewCell *tableCell = (StationViewCell *)cell;
    RadioStationDisplay *display = [self.viewModel itemAtIndexPath:indexPath];
    [display getImage:nil];
    [tableCell setDisplay:display];
    if (display.isPlaying) {
        selectIndexPath = indexPath;
        [tableCell playAnim];
    } else {
        [tableCell stopAnim];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationViewCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItems];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StationViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    RadioStationDisplay *display = cell.display;
    display.isSelected = YES;
    [[RadioPlayer sharedInstance] playURL:display.url withName:display.name withImage:display.image];
    selectIndexPath = indexPath;
    [self.miniPlayerView setHidden:NO];
    [miniPlayer setDisplay:display];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    StationViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    RadioStationDisplay *display = cell.display;
    display.isPlaying = NO;
    display.isSelected = NO;
    [cell stopAnim];
}

- (void) readipPlayerStateChange:(RadioPalyerState)state {
    if (!selectIndexPath) {
        return;
    }
    
    StationViewCell *selectCell = [self.tableView cellForRowAtIndexPath:selectIndexPath];
    RadioStationDisplay *display = selectCell.display;
    if (!display.isSelected) {
        return;
    }
    if (delayPlay) {
        [delayPlay invalidate];
    }
    delayPlay = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        switch (state) {
            case playing:
                if (selectCell) {
                    [selectCell playAnim];
                    display.isPlaying = YES;
                }
                break;
            default:
                if (selectCell) {
                    [selectCell stopAnim];
                    display.isPlaying = NO;
                }
                break;
        }
    }];
}

- (void) setupMiniPlayerView {
    miniPlayer = [[MiniPlayerViewController alloc] init];
    [miniPlayer.view setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.miniPlayerView addSubview:miniPlayer.view];

    NSArray<NSLayoutConstraint *> * constraints = [[NSArray alloc] initWithObjects:
                                                   [miniPlayer.view.topAnchor constraintEqualToAnchor:self.miniPlayerView.topAnchor],
                                                   [miniPlayer.view.leadingAnchor constraintEqualToAnchor:self.miniPlayerView.leadingAnchor],
                                                   [miniPlayer.view.trailingAnchor constraintEqualToAnchor:self.miniPlayerView.trailingAnchor],
                                                   [miniPlayer.view.bottomAnchor constraintEqualToAnchor:self.miniPlayerView.bottomAnchor],
                                                   nil];
    [NSLayoutConstraint activateConstraints:constraints];
    [self.miniPlayerView setHidden:YES];
}

@end
