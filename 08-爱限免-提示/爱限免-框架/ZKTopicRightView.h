//
//  ZKTopicRightView.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@class ZKAppListModel;

@interface ZKTopicRightView : UIView
@property(nonatomic,strong)UIImageView *subLeftView;
@property(nonatomic,strong)UILabel *subNameLabel;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *downloadLabel;
@property(nonatomic,strong)StarView *starView;

@property(nonatomic,strong)ZKAppListModel *model;

@end
