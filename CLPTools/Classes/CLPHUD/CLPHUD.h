//
//  CLPHUD.h
//  Pods
//
//  Created by clapn on 16/9/12.
//
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>


enum {
    CLPProgressHuDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    CLPProgressHuDMaskTypeClear, // don't allow
    CLPProgressHuDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    CLPProgressHuDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};
typedef NSUInteger CLPProgressHuDMaskType;



typedef NS_ENUM(NSUInteger, CLPHUDStateFlag) {
    CLPHUDErrorStateFlag = 1, //
    CLPHUDSuccessStateFlag = 2, //
    CLPHUDInfoStateFlag = 3 //

};


@interface CLPHUD : UIView


/** 成功信息状态显示 */
+(void ) CLPHUDSuccess :(NSString *)msgs;

/** 失败信息状态显示 */
+(void ) CLPHUDError :(NSString *)msgs;

/** 感叹号信息状态显示 */
+(void ) CLPHUDInfo :(NSString *)msgs;

/** 隐藏门板 */
+(void ) CLPHUDHidden;

/** 进度转圈圈状态显示  */
+(void ) CLPHUDActivity :(NSString *)msg;

@end
