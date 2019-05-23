//
//  CLPSlidingMenu.h
//  Pods
//
//  Created by clapn on 16/9/5.
//
//

#import <Foundation/Foundation.h>

@interface CLPSlidingMenu : NSObject
+(CLPSlidingMenu *)shareInstance;






/**
 *  SlidingMenu初始化设置，返回SlidingMenuViewController
 *  可以给self.window.rootViewController赋值
 *  centerViewController :中间视图
 *  leftViewController :左侧视图，无需要可赋值为nil
 *  rightViewController :右侧视图，无需要可赋值为nil

 */
- (UIViewController *) CLPinitWithSlidingMenu:(UIViewController*)centerviewController leftViewController:(UIViewController*)leftviewController rightViewController:(UIViewController*)rightviewController;


/**   初始化后，可以用实例方法（shareInstance）获取SlidingMenu 进行属性设置 */
@property (nonatomic, strong) UIViewController *CLPSlidingMenuController;

/** 左侧滑触发事件 */
-(void)CLPleftSliding :(BOOL)animated;

/** 右侧滑触发事件 */
-(void)CLPrightSliding :(BOOL)animated;

/** 左侧ViewController替换 */
-(void)CLPswitchLeftViewController :(UIViewController*)leftviewController;

/** 右侧ViewController替换 */
-(void)CLPswitchRightViewController :(UIViewController*)rightviewController;



@end
