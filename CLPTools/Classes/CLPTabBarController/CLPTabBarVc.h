//
//  CLPTabBarVc.h
//  Pods
//
//  Created by 曹郎鹏 on 16/8/31.
//
//

#import <Foundation/Foundation.h>

//防重名冲突
#define CLPvcName @"CYLvcName"
#define CLPTabBarItemTitle @"CYLTabBarItemTitle"
#define CLPTabBarItemImage @"CYLTabBarItemImage"
#define CLPTabBarItemSelectedImage @"CYLTabBarItemSelectedImage"



@class CLPTabBarController;

@interface CLPTabBarVc : NSObject
+(CLPTabBarVc *)shareInstance;

/**
 *  TabBar初始化设置，，返回自定义TabBar
 *  可以给self.window.rootViewController赋值
 *  vcNames 定义 :
 例如：
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

 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 CLPvcName： ViewController名称集合
 CLPTabBarItemTitle： TabBarItemTitle文字内容
 CLPTabBarItemImage： TabBarItemTitle普通状态下的图片
 CLPTabBarItemSelectedImage： TabBarItemTitle选中状态下的图片
 
 
 normalTextColor： 普通状态下的文字属性
 selTextColor： 选中状态下的文字属性
 tabBarBgColor： tabBar背景颜色
 tabBarBgIma： tabBar背景图片
 
 */
- (UITabBarController *)CLPTabBarWithViewControllers :(NSArray *)vcNames  withNormalTextColor:(UIColor *)normalTextColor withSelTextColor :(UIColor *)selTextColor  withTabBarBgColor :(UIColor *)tabBarBgColor withTabBarBgIma :(UIImage *)tabBarBgIma;

/**   获取TabBar 选中位置 */
-(NSUInteger)CLPgetselectedIndex;

/**   设置TabBar 选中位置 */
-(void)CLPsetSelectedIndex :(NSUInteger)selectedIndex;

/**   初始化后，可以用实例方法（shareInstance）获取TabBar进行属性设置 */
@property (nonatomic, strong) UITabBarController *CLPtabBarController;



@end
