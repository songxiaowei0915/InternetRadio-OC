//
//  ViewController.m
//  InternetRadio
//
//  Created by 宋小伟 on 2023/3/8.
//

#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NetworkManager sharedInstance] getRecommendedStations:^(NSMutableArray* jsonArray){
        NSLog(@"The content of arry is%@",jsonArray);
    }];
}


@end
