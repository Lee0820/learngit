//
//  ZKTopicModel.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKTopicModel.h"
#import "ZKAppListModel.h"

@implementation ZKTopicModel
+(ZKTopicModel *)modelWithDic:(NSDictionary *)dic{
    return [[ZKTopicModel alloc]initWithDic:dic];
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        //先利用kvc转化外层字典
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *mutArray = [NSMutableArray array];
        //转化内层字典
        for (NSDictionary *subDic in _applications) {
            ZKAppListModel *model = [ZKAppListModel appListModelWithDic:subDic];
            
            [mutArray addObject:model];
        }
            //把数组有模型表示 再将模型存入数组
        _applications = mutArray;
    }
    return self;
}
@end
