//
//  CLPTabBarVc.m
//  Pods
//
//  Created by 曹郎鹏 on 16/8/31.
//
//

#import "CLPTabBarVc.h"
#import "CYLTabBarController.h"
#import "CLPNavigationController.h"



//static CYLTabBarController *tabBarController;
//NSString *const CYLvcName = @"CYLvcName";


@implementation CLPTabBarVc


static CYLTabBarController *cYLTabBar = nil;



static CLPTabBarVc *cLPTabBarVc = nil;
//单例模式-共享内存
+ (CLPTabBarVc *)shareInstance{
    @synchronized(self){
        if (!cLPTabBarVc) {
            cLPTabBarVc = [[CLPTabBarVc alloc] init];
            return cLPTabBarVc;
        }
    }
    return cLPTabBarVc;
}





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
- (UITabBarController *)CLPTabBarWithViewControllers :(NSArray *)vcNames  withNormalTextColor:(UIColor *)normalTextColor withSelTextColor :(UIColor *)selTextColor  withTabBarBgColor :(UIColor *)tabBarBgColor withTabBarBgIma :(UIImage *)tabBarBgIma {
    
 
    
    
    NSMutableArray *arr = [self vcWithNavs: vcNames];
 
    cYLTabBar = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:cYLTabBar vcNames:vcNames ];
    
    [cYLTabBar setViewControllers: arr ];
    
    [self customizeInterface: normalTextColor withSelTextColor:selTextColor withTabBarBgColor: tabBarBgColor withTabBarBgIma: tabBarBgIma];
    
    return cYLTabBar;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController vcNames:(NSArray *)vcNames {
    
    
    NSArray *tabBarItemsAttributes = vcNames;
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}



/**
 *  tabBarItem 的选中和不选中文字属性、背景图片
 */
- (void)customizeInterface :(UIColor *)normalTextColor withSelTextColor :(UIColor *)selTextColor  withTabBarBgColor :(UIColor *)tabBarBgColor withTabBarBgIma :(UIImage *)tabBarBgIma
{
    
    
    // Customize UITabBar height
    // 自定义 TabBar 高度
//    tabBarController.tabBarHeight = 40.f;
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = normalTextColor;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = selTextColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    if (tabBarBgColor != nil) {
        // 设置背景色
        UITabBar *tabBarAppearance = [UITabBar appearance];
        [tabBarAppearance setBackgroundImage: [self CLPcreateImageWithColor:tabBarBgColor]];
    }
    else if(tabBarBgIma  != nil)
    {
        // 设置背景图片
        UITabBar *tabBarAppearance = [UITabBar appearance];
        [tabBarAppearance setBackgroundImage: tabBarBgIma];
    }
    
        

}




//name-->viewController
-(NSMutableArray *) vcWithNavs:(NSArray *)vcNames{
    
    NSMutableArray *arr = [NSMutableArray array];;
    for (int k = 0; k <vcNames.count; k ++) {
        Class class = NSClassFromString(vcNames[k][CLPvcName]);
        if (class == nil) {
            NSLog(@"vcNames 数组中 vcName 名称的 UIViewController 必须存在");
            return nil;
        }
        //        NSAssert(class != nil, @"Class 必须存在");
        //        UIViewController *vc = [[class alloc] init] ;
        
        CLPNavigationController *navVc = [[CLPNavigationController alloc]initWithRootViewController: [[class alloc] init]];

        [arr addObject:  navVc];
    }
    
    return arr;
    
    
}


- (UIImage *) CLPcreateImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


-(UITabBarController *)CLPtabBarController
{
    return cYLTabBar;
}

/*******************/
/**   获取TabBar 选中位置 */
-(NSUInteger)CLPgetselectedIndex
{
    return cYLTabBar.selectedIndex;
}
/**   设置TabBar 选中位置 */
-(void)CLPsetSelectedIndex :(NSUInteger)selectedIndex
{
    [cYLTabBar setSelectedIndex: selectedIndex];

}
@end
