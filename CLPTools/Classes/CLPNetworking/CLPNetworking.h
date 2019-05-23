//
//  CLPNetworking.h
//  Pods
//
//  Created by clapn on 16/8/30.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^complete)(id json, NSError* error);

typedef void(^imageUpdateComplete)(id response, NSError *error);


typedef NS_ENUM(NSUInteger, CLPResponseType) {
    kCLPResponseTypeJSON = 1, // 默认
    kCLPResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kCLPResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, CLPRequestType) {
    kCLPRequestTypeJSON = 1, // 默认
    kCLPRequestTypePlainText  = 2 // 普通text/html
};




@class NSURLSessionTask;


typedef NSURLSessionTask CLPURLSessionTask;
typedef void(^CLPResponseSuccess)(id response);
typedef void(^CLPResponseFail)(NSError *error);





@interface CLPNetworking : NSObject


/**取消所有请求 */
+ (void)cancelAllRequest;

/**取消某个请求 */
+ (void)cancelRequestWithURL:(NSString *)url;

/** 参数配置 （option）*/
+ (void)initCLPNetworking :(NSString *)BaseUrl IsPrintDebug:(BOOL)IsPrintDebug ActivityMsgHD:(NSString *)myActivityMsgHD  ErrorMsgHD:(NSString *)myErrorMsgHD :(CLPRequestType)requestType
              responseType:(CLPResponseType)responseType;

/*!
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)CLPconfigCommonHttpHeaders:(NSDictionary *)httpHeaders;


/** Get请求 */
+(void)CLPNetworkGeturl:(NSString *)url showHUD:(BOOL)showHUD  success:(CLPResponseSuccess)success
                   fail:(CLPResponseFail)fail;


/** Get请求 (另带参数) */
+(void)CLPNetworkGeturl:(NSString *)url showHUD:(BOOL)showHUD params:(NSDictionary *)params success:(CLPResponseSuccess)success
                   fail:(CLPResponseFail)fail;

/** Post请求 */
+(void)CLPNetworkPOSTurl:(NSString *)url showHUD:(BOOL)showHUD params:(NSDictionary *)params  success:(CLPResponseSuccess)success
                    fail:(CLPResponseFail)fail;




/**
 *  图片上传调用方法
 *  image   图片
 *  url     请求的URL地址
 *  name    图片对应的参数
 *  params  额外的参数
 *
 */
+ (void)CLPuploadWithImage:(UIImage *)image
                       url:(NSString *)url
                      name:(NSString *)name
                    params:(NSDictionary *)params
                   success:(CLPResponseSuccess)success
                      fail:(CLPResponseFail)fail;

///**
// *  图片上传调用方法
// *
// *  @param url                请求的URL地址
// *  @param params             额外的参数
// *  @param arrImage           图片集合数组
// *  @param compressionQuality 压缩比例
// */
//+(void)CLPuploadImageWithUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(NSArray *)arrImage withCompressionQuality:(CGFloat)compressionQuality success:(CLPResponseSuccess)success fail:(CLPResponseFail)fail;





/*
 添加Http支持
 在Info.plist中添加NSAppTransportSecurity类型Dictionary。
 在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
 
 */
@end
