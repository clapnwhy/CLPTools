//
//  AES256.h
//  Pods
//
//  Created by 曹郎鹏 on 16/9/12.
//
//

#import <Foundation/Foundation.h>

@interface AES256 : NSObject


/**NSString -> Base64加密*/
+ (NSString *)encrypt:(NSString *)string Password:(NSString *)password;
/**Base64  -> NSString解密*/
+ (NSString *)decrypt:(NSString *)base64EncodedString Password:(NSString *)password;


/**********************/

/**NSString -> NSData 加密*/
+(NSData*)encryptAESData:(NSString*)string  Password:(NSString *)password  ;
/**NSData -> NSString 解密*/
+(NSString*)decryptAESData:(NSData*)data  Password:(NSString *)password  ;
@end
