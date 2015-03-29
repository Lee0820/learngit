//
//  ZKDataCache.h
//  爱限免-框架
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKDataCache : NSObject
//通过类方法得到唯一单例
+ (ZKDataCache *)sharedDataCache;
+ (void)releaseDataCache;

//存数据
- (void)saveData:(NSData *)data withUrlString:(NSString *)url;
//取数据
- (NSData *)getDataWithUrlStirng:(NSString *)url;
@end
