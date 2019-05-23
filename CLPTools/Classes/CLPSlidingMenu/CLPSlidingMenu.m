//
//  CLPSlidingMenu.m
//  Pods
//
//  Created by clapn on 16/9/5.
//
//

#import "CLPSlidingMenu.h"
#import <ViewDeck/ViewDeck.h>


@interface CLPSlidingMenu ()
    {
        
    }
    @property (strong,nonatomic) IIViewDeckController* deckController;
    
    @end
@implementation CLPSlidingMenu
    
    
 



static CLPSlidingMenu *cLPSlidingMenu = nil;

//单例模式-共享内存
+ (CLPSlidingMenu *)shareInstance{
    @synchronized(self){
        if (!cLPSlidingMenu) {
            cLPSlidingMenu = [[CLPSlidingMenu alloc] init];
            return cLPSlidingMenu;
        }
    }
    return cLPSlidingMenu;
}



/**
 *  SlidingMenu初始化设置，返回SlidingMenuViewController
 *  可以给self.window.rootViewController赋值
 *  centerViewController :中间视图
 *  leftViewController :左侧视图，无需要可赋值为nil
 *  rightViewController :右侧视图，无需要可赋值为nil
 
 */
- (UIViewController *) CLPinitWithSlidingMenu:(UIViewController*)centerviewController leftViewController:(UIViewController*)leftviewController rightViewController:(UIViewController*)rightviewController {
    
    
    _deckController = [[IIViewDeckController alloc] initWithCenterViewController:centerviewController leftViewController:leftviewController rightViewController:rightviewController];//可以只添加左边，也可以只添加右边，具体看里面的代码
    
    return _deckController;
    
}


-(void)CLPleftSliding :(BOOL)animated
{
    [_deckController openSide:IIViewDeckSideLeft animated:YES];
//    [_deckController toggleLeftViewAnimated:animated];
}

-(void)CLPrightSliding :(BOOL)animated
{
    [_deckController openSide:IIViewDeckSideRight animated:YES];
//    [_deckController toggleRightViewAnimated:animated];
}


-(void)CLPswitchLeftViewController :(UIViewController*)leftviewController
{
    
    _deckController.leftViewController = leftviewController;
    // prepare view controllers
//    _deckController.leftController = leftviewController;
 }

-(void)CLPswitchRightViewController :(UIViewController*)rightviewController
{
    // prepare view controllers
//    _deckController.rightController = rightviewController;
    _deckController.rightViewController = rightviewController;

}





-(UIViewController *)CLPSlidingMenuController
{
    return _deckController;
}





@end
