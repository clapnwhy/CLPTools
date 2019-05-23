//
//  CLPToolsInterface.h
//  Pods
//
//  Created by clapn on 16/8/24.
//
//

#import <Foundation/Foundation.h>


//MD5
typedef NS_ENUM(NSUInteger, CLPToolsMD5Digit) {
    CLPMD5_16 = 16, //
    CLPMD5_32 = 32 //
};

typedef NS_ENUM(BOOL, CLPToolsMD5LowerOrUpper) {
    CLPMD5_Lower = YES, //
    CLPMD5_Upper = NO //
};



@interface CLPToolsInterface : NSObject
{
}

+(CLPToolsInterface *)SharedInstance;

#pragma mark-字符串处理区*************------------>
/** 判断字符串状态YES、NO */
-(BOOL ) CLPpdStrBOOL :(id )str;

/** 判断字符串状态返回*/
-(NSString *) CLPpdStrReturn :(NSString *)str;

/** HTML过滤替换*/
+(NSString *)CLPhTMLfilter:(NSString *)html;

/** 去转义符（如Html中的\，\\，\"等）*/
+(NSString *)CLPescapeSequence :(NSString *)str;

/** 字符串转大写或小写 */
-(NSString *)CLPlowerOrUpper_caseString :(NSString *)str  Islower:(CLPToolsMD5LowerOrUpper)Islower;

/** NSString -->  NSDictionary*/

/** NSString -->  NSArray*/









#pragma mark-控件处理区*************------------>

#pragma mark-UIImage / Color
/**判断image类型 (png/jpeg)*/
- (NSString *) CLPpdimageType: (UIImage *) image;

/**image -> NSData */
- (NSData *) CLPimageToNSData: (UIImage *) image;

/** color --> Image*/
- (UIImage *) CLPcolorToImage:(UIColor*) color;

/**UIImage -> Base64_字符串 (在下方有同样方法声明，可直接调用) */
//-(NSString *)CLPimageToBase64 :(UIImage *)image;

/**Base64_字符串 -> UIImage (在下方有同样方法声明，可直接调用) */
//-(UIImage *)CLPbase64ToImage :(NSString *)imaBase64Str;

/**  色值转化为Color*/
- (id) CLPColorWithHex:(NSString *) hex;

/**  压缩图片*/
+(UIImage*) CLPimageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/** UIimage等比率缩放
 *(float)scaleSize 改变图片大小 0.5就是一半，2，就是两倍。
 */
+ (UIImage *) CLPscaleImageBeiLv:(UIImage *)image toScale:(float)scaleSize;

/** 缩放图片
 * image 图片对象
 * toWidth 宽
 * toHeight 高
 * return 返回图片对象
 */
+(UIImage *) CLPscaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight;

/*
 * 缩放图片数据
 * imageData 图片数据
 * toWidth 宽
 * toHeight 高
 * return 返回图片数据对象
 */
+(NSData *) CLPscaleData:(NSData *)imageData toWidth:(int)toWidth toHeight:(int)toHeight;


/** UIImageView 圆形 */
- (void) CLPimageViewCircle: (UIImageView *)imageView;


/** UIImageView 半圆 */
- (void) CLPimageViewSemiCircle: (UIImageView *)imageView;


#pragma mark- UILabel
/**UILabel样式字体或变色处理
 * mylb :需要处理UILabel
 * selstr :需要处理部份
 * size :处理部份字体大小
 */
-(void) CLPreturnlablekind :(UILabel *)mylb :(NSString *)selstr size:(float)size;



#pragma mark- UIView
/** UIView 圆形 */
- (void) CLPviewCircle: (UIView *)view;

/** UIView 半圆 */
- (void) CLPviewSemiCircle: (UIView *)view;



#pragma mark-设备相关区*************------------>





#pragma mark-加密处理区*************------------>
/**
 加密Md5,
 Sel16or32: 16 位 或者 32 位
 Islower:   YES 小写 或 NO 大写
 */
- (NSString *) CLPmd5:(NSString *)str Sel16or32:(CLPToolsMD5Digit)Digit Islower:(CLPToolsMD5LowerOrUpper)Islower;

/**Base64_NSString加密*/
-(NSString *)CLPbase64Encoded :(NSString *)str;

/**Base64_NSString解密*/
-(NSString *)CLPbase64Decoded :(NSString *)base64Encoded;

/**UIImage -> Base64_字符串 */
-(NSString *)CLPimageToBase64 :(UIImage *)image;

/**Base64_字符串 -> UIImage */
-(UIImage *)CLPbase64ToImage :(NSString *)imaBase64Str;

/**Base64_NSData加密*/
-(NSString *)CLPbase64_NSDataEncoded :(NSData *)data;

/**Base64_NSData解密*/
-(NSString *)CLPbase64_NSDataDecoded :(NSData *)data;


/**AESData256_Base64加密*/
+(NSString *)CLPencryptAES256_Base64:(NSString*)str Password:(NSString *)Password;

/**AESData256_Base64解密*/
+(NSString*)CLPdecryptAES256_Base64:(NSString*)str  Password:(NSString *)Password;

/**AESData256加密*/
+(NSData*)CLPencryptAESData256:(NSString*)string Password:(NSString *)Password;

/**AESData256解密*/
+(NSString*)CLPdecryptAESData256:(NSData*)data  Password:(NSString *)Password;

/**AESData128加密*/
+(NSData*)CLPencryptAESData128:(NSString*)string Password:(NSString *)Password;

/**AESData128解密*/
+(NSString*)CLPdecryptAESData128 :(NSString*)string  Password:(NSString *)Password;


#pragma mark-适配处理*************------------>
/**定义iphoneX_tableview_Set*/
-(void) setIphoneX_TableviewFrame :(UITableView *)mytableview;


@end
