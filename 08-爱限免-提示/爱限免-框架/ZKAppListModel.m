//
//  ZKAppListModel.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKAppListModel.h"

@implementation ZKAppListModel
+(ZKAppListModel *)appListModelWithDic:(NSDictionary *)dic{
    return [[ZKAppListModel alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        //kvc模式
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}
@end
