//
//  CLPNavConfig.m
//  Pods
//
//  Created by 曹郎鹏 on 16/8/28.
//
//

#import "CLPNavConfig.h"
@interface CLPNavConfig()
{
    
    
}

//@property (nonatomic, strong) UIViewController* mainVc;
//@property (nonatomic, strong) UIViewController* NowVc;


@end
@implementation CLPNavConfig

static CLPNavConfig *cLPNav = nil;
+(CLPNavConfig *)shareInstance
{
    if (cLPNav==nil)
    {
        cLPNav = [[CLPNavConfig alloc]init];
    }
    return cLPNav;
}



-(void)initCLPNavigation :(UIColor *)navTitleColor andnavBgColor :(UIColor *)navBgColor ornavBgIma64 :(UIImage *)navBgIma64 andnavBackIma :(UIImage *)navBackIma ornavBackTitle :(NSString *)navBackTitle andnavBackTitleColor :(UIColor *)navBackTitleColor andnavBackColor :(UIColor *)navBackColor
{
    _navTitleColor = navTitleColor;
    _navBgColor = navBgColor;
    _navBgIma64 = navBgIma64;
    _navBackIma = navBackIma;
    _navBackTitle = navBackTitle;
    _navBackTitleColor = navBackTitleColor;
    _navBackColor = navBackColor;
  
}

-(void)initCLPNavigation :(UIColor *)navTitleColor andnavBgColor :(UIColor *)navBgColor ornavBgIma64 :(UIImage *)navBgIma64 andnavBackIma :(UIImage *)navBackIma
{
    _navTitleColor = navTitleColor;
    _navBgColor = navBgColor;
    _navBgIma64 = navBgIma64;
    _navBackIma = navBackIma;
 
}

-(void)CLPsetNavTitle :(NSString *)title :(UIViewController *)selfVc
{
    selfVc.navigationItem.title = title;
}
-(void)CLPNavShow :(UIViewController *)selfVc
{
    selfVc.navigationController.navigationBarHidden = NO;
}
-(void)CLPNavHidden :(UIViewController *)selfVc
{
    selfVc.navigationController.navigationBarHidden = YES;
}

@end
