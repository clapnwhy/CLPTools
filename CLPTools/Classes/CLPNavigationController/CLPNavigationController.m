//
//  CLPNavigationController.m
//  Pods
//
//  Created by 曹郎鹏 on 16/8/28.
//
//

#import "CLPNavigationController.h"
#import "CLPNavConfig.h"
#import "UIBarButtonItem+Extension.h"

@interface CLPNavigationController ()
{
    
}

@end

@implementation CLPNavigationController





+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //返回按钮文字颜色
    UIColor *navBackTitleColor = ([CLPNavConfig shareInstance].navBackTitleColor == nil ? [UIColor whiteColor] : [CLPNavConfig shareInstance].navBackTitleColor);
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: navBackTitleColor, NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
    UIImage *navBackIma = [[CLPNavConfig shareInstance].navBackIma imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
   
    
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //箭头颜色
    UIColor *navBackColor = ([CLPNavConfig shareInstance].navBackColor == nil ? [UIColor whiteColor] : [CLPNavConfig shareInstance].navBackColor);
    
    [bar setTintColor:navBackColor];
    
    
    //Nav标题颜色
    UIColor *navTitleColor = ([CLPNavConfig shareInstance].navTitleColor == nil ? [UIColor whiteColor] : [CLPNavConfig shareInstance].navTitleColor);
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:navTitleColor}];
    
    

    
    //Nav背景图
    if ([CLPNavConfig shareInstance].navBgIma64 == nil) {
        //Nav背景色
        UIColor *navBgColor = ([CLPNavConfig shareInstance].navBgColor == nil ? [UIColor whiteColor] : [CLPNavConfig shareInstance].navBgColor);

        
        [bar setBackgroundImage: [self CLPcreateImageWithColor: navBgColor] forBarMetrics:UIBarMetricsDefault];


    }
    else
    {
        [bar setBackgroundImage: [CLPNavConfig shareInstance].navBgIma64 forBarMetrics:UIBarMetricsDefault];
 //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];

    }
  

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    if ([CLPNavConfig shareInstance].navBackTitle.length) {
//        UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
//        back.title = [CLPNavConfig shareInstance].navBackTitle;
//        viewController.navigationItem.backBarButtonItem = back;
//     }
    
//    [super pushViewController:viewController animated:animated];
//    
//    if (self.viewControllers.firstObject != self) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）

    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        
//        [super pushViewController:viewController animated:animated];
    
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        
        if ([CLPNavConfig shareInstance].navBackIma != nil) {
            UIImage *navBackIma = [[CLPNavConfig shareInstance].navBackIma imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
          viewController.navigationItem.leftBarButtonItem = [self itemWithTarget:self action:@selector(LeftAction) image:navBackIma];
           }

//            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage: navBackIma style:UIBarButtonItemStyleDone target:self action:@selector(LeftAction:)];

        }
    [super pushViewController:viewController animated:animated];
   

    
        
        
        
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
        
//        // 设置右边的更多按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
//    }

    
}


- (void)LeftAction
{
    // 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
    
    
    
}




- (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    CGRect frame;
    frame.size = btn.currentBackgroundImage.size;
    btn.frame = frame;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIImage *) CLPcreateImageWithColor:(UIColor*) color
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




@end
