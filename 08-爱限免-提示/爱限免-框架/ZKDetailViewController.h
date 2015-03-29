//
//  ZKDetailViewController.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKRootViewController.h"
@class ZKAppListModel;
@interface ZKDetailViewController : ZKRootViewController
//接收从主界面传过来的数据
@property(nonatomic,strong)ZKAppListModel *detailModel;
@property (nonatomic,copy) NSString *proTitle;
@end
