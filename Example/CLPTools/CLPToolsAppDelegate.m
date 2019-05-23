//
//  CLPToolsAppDelegate.m
//  CLPTools
//
//  Created by clapnwhy on 08/24/2016.
//  Copyright (c) 2016 clapnwhy. All rights reserved.
//

#import "CLPToolsAppDelegate.h"
#import "CLPToolsViewController.h"
#import <CLPTools/CLPTools.h>//change In target setting the "Allow Non-modular Includes in Framework modules" setting to YES
@implementation CLPToolsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [CLPNavConfig_Sl initCLPNavigation:[UIColor colorWithRed:92/255.0 green:192/255.0 blue:78/255.0 alpha:1.0f] andnavBgColor:[UIColor redColor] ornavBgIma64:nil andnavBackIma:[UIImage imageNamed:@"leftback"]];
    
    [CLPNetworking initCLPNetworking: @"" IsPrintDebug:YES ActivityMsgHD:@"loading..." ErrorMsgHD:@"连接超时..." :kCLPRequestTypeJSON responseType:kCLPResponseTypeJSON];
    
 
    
    //    CLPToolsViewController *myCLPTvc = [[CLPToolsViewController alloc]init];
    //    CLPNavigationController *centerNav = [[CLPNavigationController alloc] initWithRootViewController:myCLPTvc];
    
    
    NSArray *vcNames = @[@{
                    CLPvcName:@"CLPToolsViewController",
                    CLPTabBarItemTitle:@"发现",
                    CLPTabBarItemImage:@"tabbar_find_us",
                    CLPTabBarItemSelectedImage:@"tabbar_find_s"
                    
                    },
                @{
                    CLPvcName:@"SecondViewController",
                    CLPTabBarItemTitle:@"主页",
                    CLPTabBarItemImage:@"tabbar_index_us",
                    CLPTabBarItemSelectedImage :@"tabbar_index_s"
                    }
                
                ];
    
    
    [self.window setRootViewController: [[CLPTabBarVc shareInstance] CLPTabBarWithViewControllers:vcNames withNormalTextColor:[UIColor blackColor] withSelTextColor:[UIColor yellowColor] withTabBarBgColor:[UIColor greenColor] withTabBarBgIma:nil]];

    
    //    [CLPTabBarVc CLPTabBarWithViewControllers:vcNames withNormalTextColor:[UIColor blackColor] withSelTextColor:[UIColor yellowColor] withTabBarBgColor:[UIColor whiteColor] withTabBarBgIma:nil];
    
    
    //    self.window.rootViewController = centerNav;
//    self.window.rootViewController = [CLPTabBarVc CLPTabBarWithViewControllers:arr withSelectedTextColor:[UIColor redColor] withNavBgColor:[UIColor yellowColor] withNavBgIma:nil];
    
    
//    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void)tabBarController_didSelectViewController:(NSNotification*)notify{
    
    NSString *tabBaridSelectindex =[notify object];
    // [tabBaridSelectindex isEqualToString:@"3"]
    if (![tabBaridSelectindex intValue]) {
    }
    NSLog(@"SEL Tab: %@",tabBaridSelectindex);
    
    
    
}

//-(void)MorenselectedIndexuitabbaritem :(int)selectedindex
//{
//    //0,1,2,3,4,5
//    _tabBarController.selectedIndex = selectedindex;
//}
//
//-(void)Hidentabbar
//{
//    [_tabBarController hideTabBarAnimated:NO];
//
//}
//-(void)Showtabbar
//{
//    [_tabBarController showTabBarAnimated:NO];
//    
//}
//



@end
