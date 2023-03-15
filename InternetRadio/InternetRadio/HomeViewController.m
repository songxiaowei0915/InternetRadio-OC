//
//  HomeViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/12.
//

#import "HomeViewController.h"
#import "StationTableViewCell.h"
#import "RadioPlayer.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        self.viewModel = [[ViewModel alloc] init];
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
    
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell"];
    
    if (cell) {
        [cell setDisplay:[self.viewModel itemAtIndexPath:indexPath]];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItems];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RadioStationDisplay *display = [self.viewModel itemAtIndexPath:indexPath];
    [[RadioPlayer sharedInstance] playURL:display.url withName:display.name withImage:display.image];
//    NSURL *url = [NSURL URLWithString:display.url];
//    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
//    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
//    NSLog(@"%@", display.url);
//    [player play];
    
}

@end
