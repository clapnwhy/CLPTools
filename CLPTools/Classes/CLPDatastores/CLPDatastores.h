//
//  CLPDatastores.h
//  Pods
//
//  Created by clapn on 16/9/2.
//
//

#import <Foundation/Foundation.h>
#import "CLPTools.h"

//NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(BOOL, CLPFileType) {
    CLPDocumentsType = YES, //
    CLPCachesType = NO //
};


@interface CLPDatastores : NSObject
NS_ASSUME_NONNULL_BEGIN

+( CLPDatastores *) shareInstance;

#pragma mark-存取处理区(NSUserDefaults)
/*****************简易存储区(NSUserDefaults)**************/
/** Integer 类型存储*/
-(void) CLPSaveInteger :(int) intstr key:( NSString *) key;

/** Float 类型存储*/
-(void) CLPSaveFloat :(float) floatstr key:( NSString *) key ;

/** Double 类型存储*/
-(void) CLPSaveDouble:(double) doublestr key:( NSString *) key;

/** NSString,NSDictionary,NSArray,NSData 类型存储*/
-(void) CLPSaveValue :(id) Value key:(nullable  NSString *) key;

/** URL 类型存储*/
-(void) CLPSaveURL:(NSURL *) URL key:( NSString *) key;

/** UIImage 类型存储*/
-(void) CLPSaveImage :(UIImage *)image key:( NSString *) key;


/*****************简易读取区(NSUserDefaults)**************/
/** Integer 类型读取*/
-( NSInteger) CLPReadInteger :( NSString *) key;

/** Float 类型读取*/
-(float) CLPReadFloat :( NSString *) key;

/** Double 类型读取*/
-(double) CLPReadDouble :( NSString *) key;

/** NSString 类型读取*/
-(NSString *) CLPReadNSString :( NSString *) key;

/** NSDictionary 类型读取*/
-(NSDictionary *) CLPReadNSDictionary :( NSString *) key;

/** NSArray 类型读取*/
-(NSArray *) CLPReadNSArray :( NSString *) key;

/** NSData 类型读取*/
-(NSData *) CLPReadNSData :( NSString *) key;


/** URL 类型读取*/
-(NSURL *) CLPReadURL :( NSString *) key;


/** UIImage 类型读取*/
-(UIImage *) CLPReadImage :( NSString *) key;

/*****************简易删除区(NSUserDefaults)**************/
/** 简易删除区(NSUserDefaults)*/
-(void) CLPRemoveValue :( NSString *) key;

/** 简易删除所有数据(NSUserDefaults)*/
-(void) CLPRemoveAllValue;




#pragma mark-文件方式存取区(Documents,Caches)沙盒
/*
 *  dataInfo: 需要存入的数据
 *  fileName: 自己设定的文件名
 */
/*****************Documents**************/
/**保存文件（Documents）*/
-(void) CLPSaveFiletoDocuments :(id) dataInfo fileName:( NSString *) fileName;

/**读取文件（Documents）*/
-(id) CLPReadFileWithDocuments :( NSString *) fileName;


/**删除文件（Documents）*/
-(void )CLPRemoveDocumentsFiles :( NSString *)fileName;

/**清除整个Documents缓存_X */
-(BOOL) CLPDeletfilesDocumentsData_X;

/**获取文件路径（Documents）*/
-(NSString *) CLPGetDocumentsPath :( NSString *) fileName;

/**判断文件是否存在（Documents）*/
-(BOOL )CLPPDIsExistDocuments :( NSString *)fileName;


/*****************Caches**************/
/**保存文件（Caches）*/
-(void) CLPSaveFiletoCaches :(id) dataInfo fileName:( NSString *) fileName;

/**读取文件（Caches）*/
-(id) CLPReadFiletoCaches  :( NSString *) fileName;

/**删除文件（Caches）*/
-(void )CLPRemoveCachesFiles :( NSString *)fileName;

/**清除整个Caches缓存_X */
-(BOOL) CLPDeletfilesCachesData_X;

/**获取文件路径(Caches)*/
-(NSString *) CLPGetCachesPath :( NSString *) fileName;

/**判断文件是否存在（Caches）*/
-(BOOL )CLPPDIsExistCaches :( NSString *)fileName;


/*****************fileManager_X**************/
/*
 *  dataInfo:    需要存入的数据
 *  filePath:    文件路径
 *  CLPfileType: 沙盒类型
 *  folderPath:  文件夹路径
 */
/**保存文件_X*/
-(void) CLPSaveFile_X :(id) dataInfo filePath:( NSString *) filePath;

/**读取文件_X*/
-(id) CLPReadFile_X  :( NSString *) filePath;

/**获取单个文件的大小_X
 * filePath :文件路径
 */
- (long long) CLPfGetfileSizeAtPath_X :( NSString*) filePath;

/**删除文件_X*/
-(void )CLPRemoveFiles_X :( NSString *)filePath;

/**清除文件缓存_X */
-(BOOL) CLPDeletfilesData_X :(CLPFileType)CLPfileType;

/**获取文件路径(Documents,Caches)*/
-(NSString *) CLPGetfilePath_X  :(CLPFileType)CLPfileType;

/**判断文件是否存在_X */
-(BOOL )CLPPDfileIsExis_X :( NSString *)filePath;

/**遍历文件夹获得文件夹大小_X，返回多少M
 * folderPath :文件夹路径
 */
- (float ) CLPGetfolderSizeAtPath_X:( NSString*) folderPath;


//NS_ASSUME_NONNULL_END
NS_ASSUME_NONNULL_END
@end

