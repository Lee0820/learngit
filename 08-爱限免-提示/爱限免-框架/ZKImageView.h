//
//  ZKImageView.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKAppListModel.h"
@interface ZKImageView : UIImageView
@property(nonatomic,strong)ZKAppListModel *model;//当前应用所对应的模型数据
@end
