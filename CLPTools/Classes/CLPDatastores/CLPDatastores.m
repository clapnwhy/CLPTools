//
//  CLPDatastores.m
//  Pods
//
//  Created by clapn on 16/9/2.
//
//

#import "CLPDatastores.h"

#import "CLPToolsInterface.h"


@implementation CLPDatastores

//单例模式-共享内存.
+ (CLPDatastores *)shareInstance{
    static CLPDatastores *shareInstance = nil;
    @synchronized(self){
        if (!shareInstance) {
            shareInstance = [[CLPDatastores alloc] init];
            return shareInstance;
        }
    }
    return shareInstance;
}


#pragma mark-简易存储处理区(NSUserDefaults)

/** Integer 类型存储*/
-(void) CLPSaveInteger :(int) intstr key:( NSString *) key
{
 
    if (intstr == nil) {
        [self CLPRemoveValue :key];
    }
    else
    {
        [CLPuserDefaults setInteger: intstr forKey: key ];
    }
    [CLPuserDefaults synchronize];
}

/** Float 类型存储*/
-(void) CLPSaveFloat :(float) floatstr key:( NSString *) key {
    
    [CLPuserDefaults setFloat: floatstr forKey: key ];
    [CLPuserDefaults synchronize];
}

/** Double 类型存储*/
-(void) CLPSaveDouble:(double) doublestr key:( NSString *) key
{
    [CLPuserDefaults setDouble: doublestr forKey: key ];
    [CLPuserDefaults synchronize];
}

/** NSString,NSDictionary,NSArray,NSData 类型存储*/
-(void) CLPSaveValue :(id) Value key:( NSString *) key
{
  
    if (Value == nil || Value == [NSNull null] || Value == NULL) {
        [self CLPRemoveValue :key];
    }
    else
    {
        [CLPuserDefaults setObject:Value forKey:key ];
    }
    [CLPuserDefaults synchronize];
}


/** URL 类型存储*/
-(void) CLPSaveURL:( NSURL *) URL key:( NSString *) key
{
    [CLPuserDefaults setURL:URL forKey:key];
    [CLPuserDefaults synchronize];
}


/** UIImage 类型存储*/
-(void) CLPSaveImage :(UIImage *)image key:( NSString *) key
{
  
    if (image == nil) {
        [self CLPRemoveValue :key];
    }
    else
    {
        NSData *imageData;
        if (UIImagePNGRepresentation(image)==nil) {
            imageData = UIImageJPEGRepresentation(image, 1.0);
        }else{
            imageData = UIImagePNGRepresentation(image);
        }
        [CLPuserDefaults setObject:imageData forKey:key ];
    }
    
    [CLPuserDefaults synchronize];
    
}


#pragma mark-简易读取区(NSUserDefaults)
/** Integer 类型读取*/
-( NSInteger) CLPReadInteger :( NSString *) key
{
    return [CLPuserDefaults integerForKey: key ];
}

/** Float 类型读取*/
-(float) CLPReadFloat :( NSString *) key
{
    return [CLPuserDefaults floatForKey: key ];
}

/** Double 类型读取*/
-(double) CLPReadDouble :( NSString *) key
{
    return [CLPuserDefaults doubleForKey:key];
}

/** NSString 类型读取*/
-(NSString *) CLPReadNSString :( NSString *) key
{
    return [CLPuserDefaults stringForKey: key ];
}

/** NSDictionary 类型读取*/
-(NSDictionary *) CLPReadNSDictionary :( NSString *) key
{
    return [CLPuserDefaults dictionaryForKey: key ];
}

/** NSArray 类型读取*/
-(NSArray *) CLPReadNSArray :( NSString *) key
{
    return [CLPuserDefaults arrayForKey: key ];
}

/** NSData 类型读取*/
-(NSData *) CLPReadNSData :( NSString *) key
{
    return [CLPuserDefaults dataForKey: key ];
}


/** URL 类型读取*/
-(NSURL *) CLPReadURL :( NSString *) key
{
    return [CLPuserDefaults URLForKey: key ];
}


/** UIImage 类型读取*/
-(UIImage *) CLPReadImage :( NSString *) key
{
    
    NSData *imageData = [CLPuserDefaults dataForKey :key];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

#pragma mark-简易删除区(NSUserDefaults)
/** 简易删除区(NSUserDefaults)*/
-(void) CLPRemoveValue :( NSString *) key
{
    [CLPuserDefaults removeObjectForKey: key];
    [CLPuserDefaults synchronize];
}


/** 简易删除所有数据(NSUserDefaults)*/
-(void) CLPRemoveAllValue
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [CLPuserDefaults removePersistentDomainForName:appDomain];
}


#pragma mark-文件方式存取区(Documents,Caches)沙盒
/*
 *  dataInfo:需要存入的数据
 *  fileName:自己设定的文件名
 */
/*****************Documents**************/
/**保存文件（Documents）*/
-(void) CLPSaveFiletoDocuments :(id) dataInfo fileName:( NSString *) fileName
{
    [self CLPSaveFile:dataInfo fileName:fileName CLPfileType:CLPDocumentsType];
}

/**读取文件（Documents）*/
-(id) CLPReadFileWithDocuments :( NSString *) fileName
{
    return [self CLPReadFile:fileName CLPfileType:CLPDocumentsType];
}


/**删除文件（Documents）*/
-(void )CLPRemoveDocumentsFiles :( NSString *)fileName
{
    [self CLPRemoveFiles:fileName CLPfileType:CLPDocumentsType];
}

/**清除整个Documents缓存_X */
-(BOOL) CLPDeletfilesDocumentsData_X
{
    return [self CLPDeletfilesData_X:CLPDocumentsType];
}

/**获取文件路径（Documents）*/
-(NSString *) CLPGetDocumentsPath :( NSString *) fileName
{
    return [self CLPGetfilePath:fileName CLPfileType:CLPDocumentsType];
}

/**判断文件是否存在（Documents）*/
-(BOOL )CLPPDIsExistDocuments :( NSString *)fileName
{
    NSString *filePath = [self CLPGetDocumentsPath:fileName]  ;
    return [self CLPPDfileIsExis_X:filePath];
}

/*****************Caches**************/
/**保存文件（Caches）*/
-(void) CLPSaveFiletoCaches :(id) dataInfo fileName:( NSString *) fileName
{
    [self CLPSaveFile:dataInfo fileName:fileName CLPfileType:CLPCachesType];
}

/**读取文件（Caches）*/
-(id) CLPReadFiletoCaches  :( NSString *) fileName
{
    return [self CLPReadFile:fileName CLPfileType:CLPCachesType];
}

/**删除文件（Caches）*/
-(void )CLPRemoveCachesFiles :( NSString *)fileName
{
    [self CLPRemoveFiles:fileName CLPfileType:CLPCachesType];
}

/**清除整个Caches缓存_X */
-(BOOL) CLPDeletfilesCachesData_X
{
    return [self CLPDeletfilesData_X:CLPCachesType];
}

/**获取文件路径(Caches)*/
-(NSString *) CLPGetCachesPath :( NSString *) fileName
{
    return [self CLPGetfilePath:fileName CLPfileType:CLPCachesType];
}

/**判断文件是否存在（Caches）*/
-(BOOL )CLPPDIsExistCaches :( NSString *)fileName
{
    NSString *filePath = [self  CLPGetCachesPath:fileName]  ;
    return [self CLPPDfileIsExis_X:filePath];
    
}


#pragma mark-fileManager
/*****************fileManager**************/
/**保存文件*/
-(void) CLPSaveFile :(id) dataInfo fileName:( NSString *) fileName CLPfileType:(CLPFileType)CLPfileType
{
    [self CLPSaveFile_X:dataInfo filePath: [self CLPGetfilePath:fileName CLPfileType:CLPfileType]];
}


/**读取文件*/
-(id) CLPReadFile  :( NSString *) fileName CLPfileType:(CLPFileType)CLPfileType
{
    return [self CLPReadFile_X: [self CLPGetfilePath:fileName CLPfileType:CLPfileType]];
}

/**删除文件*/
-(void )CLPRemoveFiles :( NSString *)fileName  CLPfileType:(CLPFileType)CLPfileType
{
    [self CLPRemoveFiles_X:[self CLPGetfilePath:fileName CLPfileType:CLPfileType]];
}


/**获取文件路径*/
-(NSString *) CLPGetfilePath :( NSString *) fileName  CLPfileType:(CLPFileType)CLPfileType
{
    NSString *getfilename = [[self CLPGetfilePath_X:CLPfileType] stringByAppendingPathComponent: fileName ];
    return getfilename;
}



/*****************fileManager_X**************/
/**保存文件_X*/
-(void) CLPSaveFile_X :(id) dataInfo filePath:( NSString *) filePath
{
    if([NSKeyedArchiver archiveRootObject:dataInfo toFile:filePath] == NO )
    {
        CLPAppLog(@"write file error");
    }
    else {
        CLPAppLog(@"write file success");
    }
}


/**读取文件_X*/
-(id) CLPReadFile_X  :( NSString *) filePath
{
    id infodicarray = nil;
    infodicarray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return infodicarray;
}


/**获取单个文件的大小_X
 * filePath :文件路径
 */
- (long long) CLPfGetfileSizeAtPath_X :( NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/**删除文件_X*/
-(void )CLPRemoveFiles_X :( NSString *)filePath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath: filePath])
    {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    else
    {
        CLPAppLog(@"该文件不存在");
    }
}

/**清除文件缓存_X */
-(BOOL) CLPDeletfilesData_X :(CLPFileType)CLPfileType
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSArray *files = [fileManage subpathsAtPath: [self CLPGetfilePath_X:CLPfileType]];
    CLPAppLog(@"files = %@",files);
    // MidLog(@"[files objectAtIndex:k] = %@",[files objectAtIndex:0]);
    NSString *mystr;NSString *myfliename;
    for (int k = 0 ; k < files.count; k ++) {
        mystr = [NSString stringWithFormat:@"/%@",[files objectAtIndex:k]];
        myfliename = [[self CLPGetfilePath_X:CLPfileType]  stringByAppendingPathComponent:mystr];
        [fileManage removeItemAtPath:myfliename error:nil];
    }
    NSArray *files1 = [fileManage subpathsAtPath: [self CLPGetfilePath_X:CLPfileType]];
    CLPAppLog(@"files1 = %@",files1);
    //    -(void)removeImageForKey:( NSString *)key;
    //
    //    key就是你那个[url obsoluteString];
    
    if (!files1.count)
    {
        CLPAppLog(@"清除成功！");
        return YES;
    }
    else
    {
        CLPAppLog(@"清除失败！");
        return NO;
    }
    return NO;
}

/**获取文件路径(Documents,Caches)*/
-(NSString *) CLPGetfilePath_X  :(CLPFileType)CLPfileType
{
    NSString *CLPfileTypeStr ;
    if (CLPfileType) {
        CLPfileTypeStr = CLPFilesDocument;
    }
    else
    {
        CLPfileTypeStr = CLPFilesCaches;
    }
    return CLPfileTypeStr;
}


/**判断文件是否存在_X */
-(BOOL )CLPPDfileIsExis_X :( NSString *)filePath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath: filePath])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


/**遍历文件夹获得文件夹大小_X，返回多少M
 * folderPath :文件夹路径
 */
- (float ) CLPGetfolderSizeAtPath_X:( NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self CLPfGetfileSizeAtPath_X:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}




@end
