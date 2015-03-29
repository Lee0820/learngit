//
//  ZKDataCenter.h
//  爱限免-框架
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKAppListModel;

typedef enum {
    RecondTypeWithcollection = 1,
    RecondTypeWithAttention,
    RecondTypeDownload
}RecondType;

@interface ZKDataCenter : NSObject
//得到当前类的单例对象
+ (ZKDataCenter *)singleInstance;

//创建数据库 重写init就可以了

//增加
- (void)addApplistModel:(ZKAppListModel *)model andRecondType:(RecondType)type;
//删除
- (void)deleteApplistModel:(ZKAppListModel *)model andRecondType:(RecondType)type;
//查找
- (BOOL)selectApplistModel:(ZKAppListModel *)model andRecondType:(RecondType)type;
//获取
- (NSArray *)getApplistModelsWithRecondType:(RecondType)type;
@end
