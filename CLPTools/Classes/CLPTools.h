//
//  CLPTools.h
//  Pods
//
//  Created by clapn on 16/8/24.
//
//

#ifndef CLPTools_h
#define CLPTools_h

#import <Foundation/Foundation.h>

//#import "CLPNavConfig.h"
//#import "CLPNavigationController.h"
//#import "CLPTabBarVc.h"
//#import "CLPNetworking.h"
//#import "CLPDatastores.h"
//#import "CLPToolsInterface.h"
//#import "UIView+Extension.h"
//#import "CLPHUD.h"



#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "UIViewController+KeyboardCorver.h"
#import "CLPBadge.h"
#import "CLPDatastores.h"
#import "CLPHUD.h"
#import "CLPNavConfig.h"
#import "CLPNavigationController.h"
#import "CLPNetworking.h"
#import "CLPSlidingMenu.h"
#import "CLPTabBarVc.h"
#import "CLPTools.h"
#import "CLPToolsInterface.h"
#import "AES128.h"
#import "AES256.h"
#import "NSData+AES.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"



//Singleton
/**CLP_Tools单例类*/
#define CLPTools_Sl [CLPToolsInterface SharedInstance]

/**CLP_Navigation单例类*/
#define CLPNavConfig_Sl [CLPNavConfig shareInstance]

/**CLP_TabBar单例类*/
#define CLPTabBarVc_Sl [CLPTabBarVc shareInstance]

/**CLP_数据存储单例类*/
#define CLPDatastores_Sl [CLPDatastores shareInstance]



#pragma mark-宏定义******************>>>>>>>>>>>>>>>>>>>





#pragma mark-路径 相关******************>>>>>>>>>>>>>>>>>>>

//存储路径
/**NSUserDefaults存储路径*/
#define CLPuserDefaults ([NSUserDefaults standardUserDefaults])
/**Document存储路径*/
#define CLPFilesDocument [NSString stringWithFormat:@"%@/Documents/", NSHomeDirectory()]
/**Caches存储路径*/
#define CLPFilesCaches [NSString stringWithFormat:@"%@/Library/Caches/", NSHomeDirectory()]


#pragma mark-界面参数 相关******************>>>>>>>>>>>>>>>>>>>

/**屏高*/
#define CLP_Width [[UIScreen mainScreen] bounds].size.width
/**屏高*/
#define CLP_Height [[UIScreen mainScreen] bounds].size.height

/**颜色*/
#define CLPRGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define CLPRGB(r,g,b) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1]



#pragma mark-系统Or软件版本 相关******************>>>>>>>>>>>>>>>>>>>

/**系统版本是否为IOS7*/
#define CLPIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
/**系统版本*/
#define CLPOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]

/**app名称*/
#define CLPapp_Name ＝[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/**app版本*/
#define CLPapp_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

/**app build版本*/
#define CLPapp_buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];

/**Bundle identifier*/
#define MidClapnBunle ([[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"])



#pragma mark-调用 相关******************>>>>>>>>>>>>>>>>>>>
/**AppDelegate调用*/
#define CLPAppDelegateEntity  ((AppDelegate *)[UIApplication sharedApplication].delegate)



#pragma mark-打印 相关******************>>>>>>>>>>>>>>>>>>>
/**发布后不会打印·*/
#ifdef DEBUG
#define CLPAppLog(s, ... ) NSLog( @"DEBUG_Msg: %@", [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else
#define CLPAppLog(s, ... )
#endif



#endif /* CLPTools_h */
