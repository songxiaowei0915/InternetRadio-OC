//
//  ViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[DataManager sharedInstance] getRecommendedStations:^(NSMutableArray* jsonArray){
        
    }];
}


@end
