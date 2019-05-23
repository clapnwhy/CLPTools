//
//  NSData+AES.h
//  Smile
//
//  Created by 周 敏 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

/**AES256加密*/
- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
/**AES256解密*/
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密


/**AES128加密*/
- (NSData *)AES128EncryptWithKey:(NSString *)key AESStr:(NSString *)AESStr;

/**AES128解密*/
- (NSData *)AES128DecryptWithKey:(NSString *)key AESStr:(NSString *)AESStr;
@end
