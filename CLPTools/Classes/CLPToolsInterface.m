//
//  CLPToolsInterface.m
//  Pods
//
//  Created by clapn on 16/8/24.
//
//

#import "CLPToolsInterface.h"
#import <CommonCrypto/CommonDigest.h>//md5的支持CC_MD5
#import "NSData+AES.h"
#import "AES256.h"



#import <QuartzCore/QuartzCore.h>




@interface CLPToolsInterface()
{
    
    
}
@end
@implementation CLPToolsInterface




//单例模式-共享内存
+ (CLPToolsInterface *)SharedInstance{
    static CLPToolsInterface *SharedInstance = nil;
    @synchronized(self){
        if (!SharedInstance) {
            SharedInstance = [[CLPToolsInterface alloc] init];
            return SharedInstance;
        }
    }
    return SharedInstance;
}



#pragma mark-字符串处理区
/** 判断字符串状态YES、NO */
-(BOOL ) CLPpdStrBOOL :(id )str
{
      BOOL PDBZ  = YES;
    PDBZ = ( str != nil && ![str  isEqual: @""] && str != [NSNull null] && str != NULL && str ? YES : NO);
    return PDBZ;
}


/** 判断字符串状态返回*/
-(NSString *) CLPpdStrReturn :(NSString *)str
{
     NSString *PDBZ;
    // PDBZ = ( str != nil && ![str  isEqual: @""] && str != [NSNull null] && str != NULL ? str : @"");
    PDBZ =  ( [self CLPpdStrBOOL : str] ? str : @"");
    if ([PDBZ isKindOfClass:[NSString class]]) {
        if ([PDBZ isEqualToString:@"<null>"]) {
            PDBZ = @"";
        }
     }
    return PDBZ;
}

/** HTML过滤*/
+(NSString *)CLPhTMLfilter:(NSString *)html
{
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
        //找到标签的起始位置
        [scanner scanUpToString:@"&" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@";" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;",text] withString:@""];
        
        html = [html stringByReplacingOccurrencesOfString :@"<p>" withString:@""];
        html = [html stringByReplacingOccurrencesOfString :@"</p>" withString:@""];
        
        
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

/** 去转义符（如Html中的\，\\，\"等）*/
+(NSString *)CLPescapeSequence :(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    if ([str hasPrefix:@"\""]) {
        str = [str substringFromIndex:1];
    }
    
    if ([str hasSuffix:@"\""]) {
        str = [str substringToIndex:(str.length-1)];
    }
    return str;
}



/** 字符串转大写或小写 */
-(NSString *)CLPlowerOrUpper_caseString :(NSString *)str  Islower:(CLPToolsMD5LowerOrUpper)Islower
{
    
    if (Islower) {
        return [str lowercaseString];//返回转换为小写的字符串
     }
    return [str uppercaseString];//返回转换为大写的字符串

}




#pragma mark-控件处理区*************------------>

#pragma mark-UIImage/Color
//判断image类型
- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

/**判断image类型 (png/jpeg)*/
- (NSString *) CLPpdimageType: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        mimeType = @"image/png";
    } else {
        mimeType = @"image/jpeg";
    }
    return mimeType;
}



/**image -> NSData */
- (NSData *) CLPimageToNSData: (UIImage *) image
{
    NSData *imageData = nil;
     if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
     } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
     }
    return imageData;
}





/** color -> Image*/
- (UIImage *) CLPcolorToImage:(UIColor*) color
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


/**  色值转化为Color*/
- (id) CLPColorWithHex:(NSString *) hex
{
    NSAssert(7 == hex.length, @"Hex color format error!");
    
    unsigned color = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
    [hexValueScanner scanHexInt:&color];
    
    int blue = color & 0xFF;
    int green = (color >> 8) & 0xFF;
    int red = (color >> 16) & 0xFF;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];

}



/**  压缩图片*/
- (UIImage*) CLPimageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;

}

/** UIimage等比率缩放
 *(float)scaleSize 改变图片大小 0.5就是一半，2，就是两倍。
 */
- (UIImage *) CLPscaleImageBeiLv:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height *scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

/** 缩放图片
 * image 图片对象
 * toWidth 宽
 * toHeight 高
 * return 返回图片对象
 */
-(UIImage *) CLPscaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight
{
    int width=0;
    int height=0;
    int x=0;
    int y=0;
    if (image.size.width<toWidth){
        width = toWidth;
        height = image.size.height*(toWidth/image.size.width);
        y = (height - toHeight)/2;
    }else if (image.size.height<toHeight){
        height = toHeight;
        width = image.size.width*(toHeight/image.size.height);
        x = (width - toWidth)/2;
    }else if (image.size.width>toWidth){
        width = toWidth;
        height = image.size.height*(toWidth/image.size.width);
        y = (height - toHeight)/2;
    }else if (image.size.height>toHeight){
        height = toHeight;
        width = image.size.width*(toHeight/image.size.height);
        x = (width - toWidth)/2;
    }else{
        height = toHeight;
        width = toWidth;
    }
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGSize subImageSize = CGSizeMake(toWidth, toHeight);
    CGRect subImageRect = CGRectMake(x, y, toWidth, toHeight);
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return subImage;
}

/*
 * 缩放图片数据
 * imageData 图片数据
 * toWidth 宽
 * toHeight 高
 * return 返回图片数据对象
 */
- (NSData *) CLPscaleData:(NSData *)imageData toWidth:(int)toWidth toHeight:(int)toHeight
{
 
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    int width=0;
    int height=0;
    int x=0;
    int y=0;
    
    if (image.size.width<toWidth){
        width = toWidth;
        height = image.size.height*(toWidth/image.size.width);
        y = (height - toHeight)/2;
    }else if (image.size.height<toHeight){
        height = toHeight;
        width = image.size.width*(toHeight/image.size.height);
        x = (width - toWidth)/2;
    }else if (image.size.width>toWidth){
        width = toWidth;
        height = image.size.height*(toWidth/image.size.width);
        y = (height - toHeight)/2;
    }else if (image.size.height>toHeight){
        height = toHeight;
        width = image.size.width*(toHeight/image.size.height);
        x = (width - toWidth)/2;
    }else{
        height = toHeight;
        width = toWidth;
    }
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGSize subImageSize = CGSizeMake(toWidth, toHeight);
    CGRect subImageRect = CGRectMake(x, y, toWidth, toHeight);
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    NSData *data = UIImageJPEGRepresentation(subImage,1.0);
    return data;

}


/** UIImageView 圆形 */
- (void) CLPimageViewCircle: (UIImageView *)imageView
{
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.height/2;
}


/** UIImageView 半圆 */
- (void) CLPimageViewSemiCircle: (UIImageView *)imageView
{
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
}

#pragma mark- UILabel
/**UILabel样式字体或变色处理
 * mylb :需要处理UILabel
 * selstr :需要处理部份
 * size :处理部份字体大小
 */
-(void) CLPreturnlablekind :(UILabel *)mylb :(NSString *)selstr size:(float)size
{
    NSRange range = [mylb.text rangeOfString:selstr];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:mylb.text];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size: size] range:range];
    //    [str addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor]  range: range];
    mylb.attributedText = str;
}

#pragma mark- UIView
/** UIView 圆形 */
- (void) CLPviewCircle: (UIView *)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = view.frame.size.height/2;
}

/** UIView 半圆 */
- (void) CLPviewSemiCircle: (UIView *)view
{
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}

#pragma mark-设备相关区


#pragma mark-加密处理区
/**
 加密Md5,
 Sel16or32: 16 位 或者 32 位
 Islower:   YES 小写 或 NO 大写
 */
- (NSString *) CLPmd5:(NSString *)str Sel16or32:(CLPToolsMD5Digit)Digit Islower:(CLPToolsMD5LowerOrUpper)Islower
{
    
    
    if ([str isEqualToString:@""] == NO && str) {
        const char *cStr = [str UTF8String];
        unsigned char result[16];
        CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
        
        if (Digit == 16) {
#pragma mark-DHSoft_MD5_Form 16位编码
            
           return [self CLPlowerOrUpper_caseString:[[NSString stringWithFormat:            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                                       result[0], result[1], result[2], result[3],
                                       result[4], result[5], result[6], result[7],
                                       result[8], result[9], result[10], result[11],
                                       result[12], result[13], result[14], result[15]
                                       ] substringWithRange:NSMakeRange(8,16)] Islower:Islower];
            
            
        }
        else
        {
#pragma mark-_MD5_Form 32位编码
            //CLPAppLog(@"_MD5_Form");
            
            return [self CLPlowerOrUpper_caseString:[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                                             result[0], result[1], result[2], result[3],
                                             result[4], result[5], result[6], result[7],
                                             result[8], result[9], result[10], result[11],
                                             result[12], result[13], result[14], result[15]
                                             ] Islower:Islower];
            
        }
        
    }
    
    return @"Dont't be nil OR empty";
}





/**Base64_NSString加密*/
-(NSString *)CLPbase64Encoded :(NSString *)str
{
    // Create NSData object
    NSData *nsdata = [str
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
//    NSLog(@"Encoded: %@", base64Encoded);
    return base64Encoded;
}

/**Base64_NSString解密*/
-(NSString *)CLPbase64Decoded :(NSString *)base64Encoded
{
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
//    NSLog(@"Decoded: %@", base64Decoded);
    return base64Decoded;


}


/**UIImage -> Base64_字符串 */
-(NSString *)CLPimageToBase64 :(UIImage *)image
{
    NSData* pictureData ;
    
    if (UIImagePNGRepresentation(image)==nil) {
        pictureData = UIImageJPEGRepresentation(image, 1.0);
    }else{
        pictureData = UIImagePNGRepresentation(image);
    }

    
//    NSData* pictureData = UIImageJPEGRepresentation(image,1.0);
    NSString* pictureDataString = [pictureData base64Encoding];
    
    
//    NSData *_data = UIImageJPEGRepresentation(image, 1.0f);
////    NSString *_encodedImageStr = [_data base64Encoding];
//    
//    NSString * _encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//
////    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
////    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    //    NSLog(@"===Encoded image:\n%@", _encodedImageStr);
    return pictureDataString;
}

/**Base64_字符串 -> UIImage */
-(UIImage *)CLPbase64ToImage :(NSString *)imaBase64Str
{

    NSData* dataFromString = [[NSData alloc] initWithBase64EncodedString:imaBase64Str options:0];
    UIImage *image = [UIImage imageWithData:dataFromString];

    
    
//    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:imaBase64Str];
//    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    //    NSLog(@"===Decoded image size: %@", NSStringFromCGSize(_decodedImage.size));
    return  image;
}


/**Base64_NSData加密*/
-(NSString *)CLPbase64_NSDataEncoded :(NSData *)data
{
    
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64data = [[NSData alloc]
                                    initWithBase64EncodedData:data options:0];
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdataFromBase64data base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    //    NSLog(@"Encoded: %@", base64Encoded);
    return base64Encoded;
}

/**Base64_NSData解密*/
-(NSString *)CLPbase64_NSDataDecoded :(NSData *)data
{
    
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64data = [[NSData alloc]
                                      initWithBase64EncodedData:data options:0];
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64data encoding:NSUTF8StringEncoding];
    //    NSLog(@"Decoded: %@", base64Decoded);
    return base64Decoded;
    
    
}


/**AESData256_Base64加密*/
+(NSString *)CLPencryptAES256_Base64:(NSString*)str Password:(NSString *)Password {
 
    return [AES256 encrypt:str Password:Password];
}

/**AESData256_Base64解密*/
+(NSString*)CLPdecryptAES256_Base64:(NSString*)str  Password:(NSString *)Password {
    
    return [AES256 decrypt:str Password:Password];
}


/**AESData256加密*/
+(NSData*)CLPencryptAESData256:(NSString*)string Password:(NSString *)Password {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES256EncryptWithKey:Password];
    return encryptedData;
}

/**AESData256解密*/
+(NSString*)CLPdecryptAESData256:(NSData*)data  Password:(NSString *)Password {
    //使用密码对data进行解密
    NSData *decryData = [data AES256DecryptWithKey:Password];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

/**AESData128加密*/
+(NSData*)CLPencryptAESData128:(NSString*)string Password:(NSString *)Password {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:Password AESStr:string];
    return encryptedData;
}



/**AESData128解密*/
+(NSString*)CLPdecryptAESData128 :(NSString*)string  Password:(NSString *)Password {
    //使用密码对data进行解密
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //将解了密码的nsdata转化为nsstring
    
    NSData *encryptedData = [data AES128DecryptWithKey:Password AESStr:string];

    NSString *str = [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    return str;
}


#pragma mark-适配处理*************------------>
/**定义iphoneX_tableview_Set*/
-(void) setIphoneX_TableviewFrame :(UITableView *)mytableview
{
    if (@available(iOS 11.0, *)) {
        [mytableview setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    } else {
        // Fallback on earlier versions
    }
}



@end
