//
//  AES256.m
//  Pods
//
//  Created by 曹郎鹏 on 16/9/12.
//
//

#import "AES256.h"
#import "NSData+AES.h"

#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"


@implementation AES256



/**NSString -> Base64加密*/
+ (NSString *)encrypt:(NSString *)string Password:(NSString *)password
{
    NSData *encryptedData = [[string dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}
/**Base64  -> NSString解密*/
+ (NSString *)decrypt:(NSString *)base64EncodedString Password:(NSString *)password
{
    
    NSData *encryptedData = [NSData base64DataFromString:base64EncodedString];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}


+(NSData*)encryptAESData:(NSString*)string  Password:(NSString *)password   {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES256EncryptWithKey:password];
    return encryptedData;
}

//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data  Password:(NSString *)password  {
    //使用密码对data进行解密
    NSData *decryData = [data AES256DecryptWithKey:password];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}



@end
