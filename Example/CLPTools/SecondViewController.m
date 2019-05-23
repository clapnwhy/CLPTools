//
//  SecondViewController.m
//  CLPTools
//
//  Created by clapn on 16/8/26.
//  Copyright © 2016年 clapnwhy. All rights reserved.
//

#import "SecondViewController.h"
#import <CLPTools/CLPTools.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的2";
    
    
    NSLog(@"selectedIndex = %lu", (unsigned long)[CLPTabBarVc_Sl CLPgetselectedIndex]);
    NSLog(@"selectedIndex = %@",  CLPTabBarVc_Sl.CLPtabBarController);

//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
//    [CLPNavConfig CLPNavShow : self ];

//    [CLPNav CLPNav_Show:self andTitle:@"业主2"];

    
    
//    _Btn_backima = [_Btn_backima imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"leftback"];

//    self.navigationController.viewControllers
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
