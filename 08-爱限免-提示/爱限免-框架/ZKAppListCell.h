//
//  ZKAppListCell.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class ZKAppListModel;

@interface ZKAppListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *fileSizeLabel;
@property(nonatomic,strong)UILabel *categoryLabel;
@property(nonatomic,strong)UILabel *sharedLabel;
@property(nonatomic,strong)UILabel *collectLabel;
@property(nonatomic,strong)UILabel *downloadLabel;

@property(nonatomic,strong)StarView *myStarView;
@property(nonatomic,strong)ZKAppListModel *myModel;

+(ZKAppListCell *)cellWithTableView:(UITableView *)tableView;

@end
