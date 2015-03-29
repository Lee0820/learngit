//
//  ZKCategoryCell.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKCategoryModel;

@interface ZKCategoryCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)ZKCategoryModel *myModel;

+(ZKCategoryCell *)cellWithTableView:(UITableView *)tableView;
@end
