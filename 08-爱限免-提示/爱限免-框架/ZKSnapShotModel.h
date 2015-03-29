//
//  ZKSnapShotModel.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKSnapShotModel : NSObject
@property (nonatomic,copy) NSString *smallUrl;
@property (nonatomic,copy) NSString *originalUrl;

+(ZKSnapShotModel *)modelWithDic:(NSDictionary *)dic;
@end
