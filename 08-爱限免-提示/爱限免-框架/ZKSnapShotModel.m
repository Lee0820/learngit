//
//  ZKSnapShotModel.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKSnapShotModel.h"

@implementation ZKSnapShotModel
+(ZKSnapShotModel *)modelWithDic:(NSDictionary *)dic{
    return [[ZKSnapShotModel alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
