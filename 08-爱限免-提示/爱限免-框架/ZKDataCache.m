//
//  ZKDataCache.m
//  爱限免-框架
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKDataCache.h"
#import "NSString+Hashing.h"//哈希算法  数据结构

@implementation ZKDataCache
static ZKDataCache *cache = nil;
+ (ZKDataCache *)sharedDataCache {
    @synchronized(self){
        if (cache == nil) {
            cache = [[ZKDataCache alloc] init];
//            cache = [[[self class] alloc] init];
        }
    }
    return cache;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    if (cache == nil) {
        cache = [super allocWithZone:zone];
    }
    return cache;
}

+ (void)releaseDataCache {
    if (cache != nil) {
        cache = nil;
    }
}
//存数据
- (void)saveData:(NSData *)data withUrlString:(NSString *)url {
    //完整的路径
    NSString *path = [NSString stringWithFormat:@"%@/Documents/DataCache/", NSHomeDirectory()];
    
    //文件管理类
    NSFileManager *fileManager = [NSFileManager defaultManager];//单例
    //创建当前路径文件夹  创建必须有yes  如果是no 没有
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    //给url加密 MD5 通过加密可以得到一个固定长度的值(16位),每个值都是唯一的
    //1.可以加密 2.得到一个固定长度的值
    NSString *str = [url MD5Hash];
    
//    BOOL isSuc = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,str]];//读数据用到
    BOOL isSuc = [data writeToFile:[NSString stringWithFormat:@"%@/%@",path,str] atomically:YES];
    if (isSuc) {
        NSLog(@"存储成功");
    } else {
        NSLog(@"存储失败");
    }
}

//q取数据
- (NSData *)getDataWithUrlStirng:(NSString *)url {
     NSString *path = [NSString stringWithFormat:@"%@/Documents/DataCache/%@", NSHomeDirectory(), [url MD5Hash]];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    //判断文件是否存在
    BOOL isExit = [fileManger fileExistsAtPath:path];
    if (!isExit) {
        NSLog(@"文件不存在");
        return nil;
    }
    
    //判断时间 是否要重新下载数据 当前时间和存入时间相比较
    NSTimeInterval timeinte = [[NSDate date] timeIntervalSinceDate:[self getmodifyTime:path]];
        //与设置好的时间进行比较
    if (timeinte >= 60) {
        return nil;
        NSLog(@"时间还没到");
    }
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}
//取最后一次存入数据的时间
- (NSDate *)getmodifyTime:(NSString *)path {
    NSFileManager *fileManager =  [NSFileManager defaultManager];
    //获取关于该文件的所有属性
    NSDictionary *dic = [fileManager attributesOfItemAtPath:path error:nil];
    NSLog(@"%@", dic);
    return dic[@"NSFileModificationDate"];
}
@end






