//
//  CLPToolsViewController.m
//  CLPTools
//
//  Created by clapnwhy on 08/24/2016.
//  Copyright (c) 2016 clapnwhy. All rights reserved.
//

#import "CLPToolsViewController.h"

 
#import <CLPTools/CLPTools.h>
#import "SecondViewController.h"
//#import "HYBNetworking.h"
#import "SubViewController.h"

@interface CLPToolsViewController ()

@end

@implementation CLPToolsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的1";
//    NSLog(@"selectedIndex = %d", [CLPTabBarVc selectedIndex]);

    ;
//    NSLog(@"error =%@",   [[CLPToolsInterface SharedInstance] CLPimageToBase64 : [UIImage imageNamed:@"error"]]);
//
//
//
//    NSLog(@"info =%@",   [[CLPToolsInterface SharedInstance] CLPimageToBase64 : [UIImage imageNamed:@"info"]]);

    
//    [CLPNetworking CLPNetworkGeturl: @"http://zhwnlapi.etouch.cn/Ecalender/huangli/2016-08-31.json" success:^(id response) {
//        NSLog(@"success %@",response);
//        
//
//
//    } fail:^(NSError *error) {
//        NSLog(@"error");
//
//    }];
    
//    [HYBNetworking getWithUrl:@"http://zhwnlapi.etouch.cn/Ecalender/huangli/2016-08-31.json" refreshCache:YES success:^(id response) {
//        NSLog(@"success %@",response);
//
//        
//    } fail:^(NSError *error) {
//        NSLog(@"error");
//
//    }];

//    [CLPNavConfig CLPNavHidden : self ];
//    [CLPNavConfig initCLPNavigation:[UIColor redColor] andnavBgColor:[UIColor colorWithRed:92/255.0 green:192/255.0 blue:78/255.0 alpha:1.0f] andnavBgIma64:nil andnavBackIma:[UIImage imageNamed:@"leftback"] andnavBackTitle:<#(UIImage *)#> andnavBackTitleColor:<#(UIImage *)#> andnavBackColor:<#(UIImage *)#>];
    
    
//    [CLPNav initNavBackgroundColor:[UIColor brownColor] andnavtitlecolor:[UIColor redColor] andBtn_backima: [UIImage imageNamed:@"leftback"]];//[UIImage imageNamed:@"leftback"]
//
//    CLPNav.Btn_backTitleON = YES;
//    CLPNav.navBtn_backtitlecolor = [UIColor whiteColor];
//    
//    [CLPNav CLPNav_Show:self andTitle:@"业主"];
//
////    self.navigationItem.title = @"业主";
//    
//    NSLog(@"CLPToolsUse = %@", [CLPTools CLPMd5:@"123456" Sel16or32: 16 Islower: YES ] );
	// Do any additional setup after loading the view, typically from a nib.
}

    //    NSString *url= (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@user_search.ashx?keyword=%@&easemob_id=%@",HttpUrl,_textField.text,loginUsername], NULL, NULL,  kCFStringEncodingUTF8 ));

//+ (NSString *)getWithUrl:(NSString *)url
//                     refreshCache:(BOOL)refreshCache
//                          success:(HYBResponseSuccess)success
//                             fail:(HYBResponseFail)fail
//{
//
//    
//    [MBProgressHUD showMessage:@"Loading..."];
//    
//    [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
// 
//        success = response;
//    } fail:^(NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败"];
//        return error;
//
//     }];
//    
//    return nil;
//}
//




-(IBAction)selcccc:(id)sender
{
    [self getDataBase];
//    NSString *HUDSuccessImaStr =[[CLPToolsInterface SharedInstance] CLPimageToBase64 :  [UIImage imageNamed:@"success"]];
////    NSLog(@"success =%@",   [[CLPToolsInterface SharedInstance] CLPimageToBase64 : [UIImage imageNamed:@"xx.jpg"]]);
//
//    NSLog(@"HUDSuccessImaStr =%@",HUDSuccessImaStr);
//     _myima.image = [[CLPToolsInterface SharedInstance] CLPbase64ToImage:HUDSuccessImaStr];
//
//    [CLPHUD CLPHUDSuccess:@"dddddddddddd"];

//    [CLPTabBarVc_Sl CLPsetSelectedIndex:1];
}


-(void)getDataBase
{
    NSDictionary *dic = nil;
     dic  = @{
             @"name":@"admin",
             @"password":@"admin"
             };
    // http://zteits.gnway.cc:8081/Inspection_Server_Intserface/login/dologin
    //https://zteits.gnway.cc:8081/Inspection_Server_Interface/login/dologin
    //https://pay.service.rnting.com/
    [CLPNetworking CLPNetworkPOSTurl:@"https://pay.service.rnting.com/user/login" showHUD:YES  params:dic success:^(id response) {
        NSLog(@"response= %@",response);
 //        if ([response[@"status"] intValue] == 0) {
//
//            NSLog(@"response= %@",response);
//         }
//        else
//        {
//            NSLog(@"response= %@",response);
//
//            //            [CLPHUD CLPHUDError:response[@"mesg"]];
//        }
        
    } fail:^(NSError *error) {
        NSLog(@"error= %@",error);
     }];
    
}



-(IBAction)gotosecondVc:(id)sender
{
    
    SubViewController * mySecondVc = [[SubViewController alloc]init];
    [ self.navigationController pushViewController:mySecondVc animated:YES];
//    SecondViewController * mySecondVc = [[SecondViewController alloc]init];
//    [ self.navigationController pushViewController:mySecondVc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
