//
//  ZKCategoryModel.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKCategoryModel : NSObject
@property (nonatomic,copy) NSString *category_count;
@property (nonatomic,copy) NSString *free;
@property (nonatomic,copy) NSString *limited;
@property (nonatomic,copy) NSString *same;
@property (nonatomic,copy) NSString *up;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *category_name;
@property (nonatomic,copy) NSString *category_cname;

+(ZKCategoryModel *)modelWithDic:(NSDictionary *)dic;
@end
