//
//  CLPNavConfig.h
//  Pods
//
//  Created by 曹郎鹏 on 16/8/28.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLPNavConfig : NSObject

/** CLPNavConfig单例 */
+(CLPNavConfig *)shareInstance;

/** CLPNavigation 初始化 全
  * navTitleColor: 标题字体颜色
  * navBgColor: 导航栏背景颜色
  * navBgIma64: 导航栏背景图
  * navBackIma: 返回按钮图片
  * navBackTitle: 返回按钮字体内容
  * navBackTitleColor: 返回按钮字体颜色
  * navBackColor: 返回箭头颜色
 */
-(void)initCLPNavigation :(UIColor *)navTitleColor andnavBgColor :(UIColor *)navBgColor ornavBgIma64 :(UIImage *)navBgIma64 andnavBackIma :(UIImage *)navBackIma ornavBackTitle :(NSString *)navBackTitle andnavBackTitleColor :(UIColor *)navBackTitleColor andnavBackColor :(UIColor *)navBackColor;

/** CLPNavigation 初始化 简
 * navTitleColor: 标题字体颜色
 * navBgColor: 导航栏背景颜色
 * navBgIma64: 导航栏背景图
 * navBackIma: 返回按钮图片
 * navBackTitle: 返回按钮字体内容
 * navBackTitleColor: 返回按钮字体颜色
 * navBackColor: 返回箭头颜色
 */
-(void)initCLPNavigation :(UIColor *)navTitleColor andnavBgColor :(UIColor *)navBgColor ornavBgIma64 :(UIImage *)navBgIma64 andnavBackIma :(UIImage *)navBackIma ;

/** 设置当前Nav的Title */
-(void)CLPsetNavTitle :(NSString *)title :(UIViewController *)selfVc;

/** 显示当前Nav */
-(void)CLPNavShow :(UIViewController *)selfVc;

/** 隐藏当前Nav */
-(void)CLPNavHidden :(UIViewController *)selfVc;



//导航栏属性设置
@property (nonatomic, strong) UIColor* navTitleColor;//标题字体颜色设置
@property (nonatomic, strong) UIColor* navBgColor;//导航栏背景颜色
@property (nonatomic, strong) UIImage* navBgIma64;//导航栏背景图


//返回按钮属性设置
@property (nonatomic, strong) UIImage* navBackIma;//返回按钮图片设置
@property(nonatomic ,strong) NSString *navBackTitle;//返回按钮字体内容
@property (nonatomic, strong) UIColor* navBackTitleColor;//返回按钮字体颜色
@property (nonatomic, strong) UIColor* navBackColor;//返回箭头颜色







//49

@end
