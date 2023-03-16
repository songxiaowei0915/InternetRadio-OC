//
//  HomeViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "HomeViewController.h"
#import "StationTableViewCell.h"


@interface HomeViewController ()
@property (nonatomic, assign) NSIndexPath *selectIndexPath;
@end

@implementation HomeViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        self.viewModel = [[ViewModel alloc] init];
        [[RadioPlayer sharedInstance] setDelegate:self];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self getData];
}

- (void) getData {
    __weak HomeViewController *weakSelf = self;
    [self.viewModel getRadioStationsWithSuccess:^(NSArray<RadioStationDisplay *> * _Nonnull radioStations) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
        
    }];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"=====");
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    StationTableViewCell *tableCell = (StationTableViewCell *)cell;
    RadioStationDisplay *display = [self.viewModel itemAtIndexPath:indexPath];
    [tableCell setDisplay:display];
    if (self.selectIndexPath == indexPath) {
        [tableCell playAnim];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItems];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    RadioStationDisplay *display = cell.display;
    [[RadioPlayer sharedInstance] playURL:display.url withName:display.name withImage:display.image];
    self.selectIndexPath = indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    StationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell stopAnim];
}

- (void) readipPlayerStateChange:(RadioPalyerState)state {
    if (!self.selectIndexPath) {
        return;
    }
    StationTableViewCell *selectCell = [self.tableView cellForRowAtIndexPath:self.selectIndexPath];
    switch (state) {
        case playing:
            if (selectCell) {
                [selectCell playAnim];
            }
            break;
        default:
            if (selectCell) {
                [selectCell stopAnim];
            }
            break;
    }
}

@end
