//
//  CLPNetworking.m
//  Pods
//
//  Created by clapn on 16/8/30.
//
//

#import "CLPNetworking.h"
#import "HYBNetworking.h"
#import "CLPHUD.h"
#import "Randation.h"
#import <CLPTools/CLPTools.h>


static CLPResponseType sg_responseType = kCLPResponseTypeJSON;
static CLPRequestType  sg_requestType  = kCLPRequestTypePlainText;

@implementation CLPNetworking
static NSString *ActivityMsgHD = @"Loading...";
static NSString *ErrorMsgHD = @"请求超时";
static NSString *sg_privateNetworkBaseUrl = nil;
static BOOL kIsPrintDebug = nil;

 
+ (void)initCLPNetworking :(NSString *)BaseUrl IsPrintDebug:(BOOL)IsPrintDebug ActivityMsgHD:(NSString *)myActivityMsgHD  ErrorMsgHD:(NSString *)myErrorMsgHD :(CLPRequestType)requestType
              responseType:(CLPResponseType)responseType  {
    
    // 通常放在appdelegate就可以了
    [HYBNetworking updateBaseUrl: BaseUrl];
    
    kIsPrintDebug = IsPrintDebug;
     sg_privateNetworkBaseUrl = BaseUrl;
    
    ErrorMsgHD = myErrorMsgHD;
    ActivityMsgHD = myActivityMsgHD;
    [self initialize :requestType responseType:responseType];
//    cacheGetRequest
}


+(void) initialize :(CLPRequestType)requestType
       responseType:(CLPResponseType)responseType {
//    NSLog(@"Duck initialize");
    
    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
    [HYBNetworking configRequestType:requestType
                        responseType:responseType
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    
 }


/*!
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)CLPconfigCommonHttpHeaders:(NSDictionary *)httpHeaders
{
    [HYBNetworking configCommonHttpHeaders: httpHeaders];
}





+ (void)cancelAllRequest {
    
    [HYBNetworking cancelAllRequest];
}

+ (void)cancelRequestWithURL:(NSString *)url {
    [HYBNetworking cancelRequestWithURL:url];

}

+(void)CLPNetworkGeturl:(NSString *)url showHUD:(BOOL)showHUD   success:(CLPResponseSuccess)success
                   fail:(CLPResponseFail)fail{
    
//    [HYBNetworking getWithUrl: url refreshCache:YES success:success fail: fail];
   
    
//    __weak CLPNetworking *weakSelf = self;
    if (showHUD) [self showActivityMsgHD];

    [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
        
        if(kIsPrintDebug)  CLPAppLog(@"%@",response);

        if (showHUD) [self hiddenActivityMsgHD];
         if (success) {
            success(response);
          }
        
    } fail:^(NSError *error) {
        [self showErrorMsgHD];
        if (fail) {
            fail(error);
        }
    }];
}




+(void)CLPNetworkGeturl:(NSString *)url showHUD:(BOOL)showHUD params:(NSDictionary *)params success:(CLPResponseSuccess)success
                   fail:(CLPResponseFail)fail{
 
    if (showHUD) [self showActivityMsgHD];
    //    [HYBNetworking getWithUrl: url refreshCache:YES success:success fail: fail];
    [HYBNetworking getWithUrl:url refreshCache:YES params:params success:^(id response) {
        if(kIsPrintDebug)  CLPAppLog(@"%@",response);

        if (showHUD) [self hiddenActivityMsgHD];
        if (success) {
            success(response);
        }
        
    } fail:^(NSError *error) {
        [self showErrorMsgHD];
        if (fail) {
            fail(error);
        }
    }];
     
     
}



+(void)CLPNetworkPOSTurl:(NSString *)url showHUD:(BOOL)showHUD params:(NSDictionary *)params  success:(CLPResponseSuccess)success
                    fail:(CLPResponseFail)fail{
    
    
//    __weak CLPNetworking *weakSelf = self;

    if (showHUD) [self showActivityMsgHD];
 
    [HYBNetworking postWithUrl: url refreshCache:YES params:params success:^(id response)
     {
         if(kIsPrintDebug)  CLPAppLog(@"%@",response);

         if (showHUD) [self hiddenActivityMsgHD];
          if (success) {
             success(response);
         }
         
     } fail:^(NSError *error) {
         
         [self showErrorMsgHD];
         if (fail) {
             fail(error);
         }
     }];
    
}
+ (void)CLPuploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                                   name:(NSString *)name
                             params:(NSDictionary *)params
                                success:(CLPResponseSuccess)success
                                  fail:(CLPResponseFail)fail {
    
    [HYBNetworking uploadWithImage:image url:url filename:[self imageNamedateTimeStr] name:name mimeType:@"image/jpeg" parameters:params progress:^(int64_t bytesWritten, int64_t totalBytesWritten) {
        
    } success:^(id response) {
        if(kIsPrintDebug)  CLPAppLog(@"%@",response);
         success(response);

     } fail:^(NSError *error) {
          fail(error);
     }];



}

+(NSString *)imageNamedateTimeStr
{
     //获取当前时间
    NSDate* today = [NSDate date];
    //转换时间格式
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* s1 = [df stringFromDate:today];
    NSDate* date = [df dateFromString:s1];

    //转换时间格式
    NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
    [df2 setDateFormat:@"yyyyMMddHHmmss"];
    [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSString *todadyStr = [df2 stringFromDate:date];
    NSString *imageName = [NSString stringWithFormat:@"%@%@.jpg",todadyStr,[Randation getmm:@"4"]];
//    NSLog(@"imageNameUpdate=>",imageName);
    return  imageName;
 }

+(void)showActivityMsgHD
{
    if (ActivityMsgHD != nil) {
        [CLPHUD CLPHUDActivity: ActivityMsgHD];
//        dispatch_async(dispatch_get_main_queue(), ^{
//         [MBProgressHUD showMessage: ActivityMsgHD];
//        });

     }
}


+(void)hiddenActivityMsgHD
{
    if (ActivityMsgHD != nil) {
//        dispatch_async(dispatch_get_main_queue(), ^{
        
            [CLPHUD CLPHUDHidden];

//         [MBProgressHUD hideHUD];
//            [MBProgressHUD hideHUDForView:nil];
//            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];

//        });

    }
}


+(void)showErrorMsgHD
{
    if (ErrorMsgHD != nil) {
//        dispatch_async(dispatch_get_main_queue(), ^{

        [CLPHUD CLPHUDError: ErrorMsgHD];
//        });
    }

}






/****************************/
/**
 *  图片上传调用方法
 *
 *  @param url                请求的URL地址
 *  @param params             额外的参数
 *  @param arrImage           图片集合数组
 *  @param compressionQuality 压缩比例
 */
+(void)CLPuploadImageWithUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(NSArray *)arrImage withCompressionQuality:(CGFloat)compressionQuality success:(CLPResponseSuccess)success fail:(CLPResponseFail)fail
{
    __weak CLPNetworking *weakSelf = self;

    url = [self absoluteUrlWithPath:url];
    //检查参数是否正确
    if (!url|| !arrImage) {
        NSLog(@"参数不完整");
        return;
    }
    
    
//    if ([url rangeOfString:@"http://"].location == NSNotFound) {
//        url = [NSString stringWithFormat:@"http://%@",url];
//    }
    //初始化
    NSString *hyphens = @"--";
    NSString *boundary = @"chenfengfeng";
    NSString *end = @"\r\n";
    //初始化数据
    NSMutableData *myRequestData1=[NSMutableData data];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //添加其他参数
    for(int i = 0;i < [keys count];i ++)
    {
        NSMutableString *body = [[NSMutableString alloc]init];
        [body appendString:hyphens];
        [body appendString:boundary];
        [body appendString:end];
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //添加字段名称
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"%@%@",key,end,end];
        
        //添加字段的值
        [body appendFormat:@"%@",[params objectForKey:key]];
        [body appendString:end];
        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"添加字段的值==%@",[params objectForKey:key]);
    }
    //添加图片资源
    for (int i = 0; i < arrImage.count; i++) {
        if (![arrImage[i] isKindOfClass:[UIImage class]]) {
            return;
        }
        //获取资源
        UIImage *image = arrImage[i];
        //得到图片的data
        NSData* data = UIImageJPEGRepresentation(image,compressionQuality);
        //所有字段的拼接都不能缺少，要保证格式正确
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        //要上传的文件名和key，服务器端接收
        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"file\";filename=\"file%u.png\"",i];
        [fileTitle appendString:end];
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:application/octet-stream%@",end]];
        [fileTitle appendString:end];
        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:data];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //拼接结束~~~
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData1 length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    //回调返回值
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        
        if (connectionError) {
            
            
            [self showErrorMsgHD];
            
            if (fail) {
                fail(connectionError);
            }
//            if (imageUpdateComplete) {
//                imageUpdateComplete(nil,connectionError);
//            }
//            if ([self.delegate respondsToSelector:@selector(requestErrorFromServer:)]) {
//                [self.delegate requestErrorFromServer:@"请求超时"]; //出现任何服务器端返回的错误，交给代理处理
//            }
        }else{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            
            if (success) {
                success(dic);
            }
//            if(imageUpdateComplete)
//            {
//                imageUpdateComplete(dic,nil);
//            }
//            if ([self.delegate respondsToSelector:@selector(finish)]) {
//                [self.delegate finish];
//            }
        }
        
    }];
    
}




+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([[self baseUrl] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseUrl], mutablePath];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }
        } else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseUrl], path];
            }
        }
    }
    
    return absoluteUrl;
}


+ (NSString *)baseUrl {
    return sg_privateNetworkBaseUrl;
}




//urlall = [[NSString stringWithFormat:@"%@%@",[self decrypt: STRAESC  password: @"DHsoft"],urlbody] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


//NSString *url= (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)[NSString stringWithFormat:@"%@user_search.ashx?keyword=%@&easemob_id=%@",HttpUrl,_textField.text,loginUsername], NULL, NULL,  kCFStringEncodingUTF8 ));


@end
