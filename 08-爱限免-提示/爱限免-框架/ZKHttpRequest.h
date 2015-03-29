//
//  ZKHttpRequest.h
//  01-网络下载-基本使用
//
//  Created by zhaokai on 15-2-27.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZKHttpRequest;
typedef void (^myBlock)(ZKHttpRequest *request);

@interface ZKHttpRequest : NSObject

@property(nonatomic,strong)NSMutableData *myData;
//构造方法-构造方法家族(必须以init开头,遵循驼峰原则)

-(id)initWithRequest:(NSURLRequest *)request andBlock:(myBlock)block;
@end
