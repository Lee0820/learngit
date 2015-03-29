//
//  ZKButton.h
//  03-block的基本知识
//
//  Created by zhaokai on 15-3-6.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKButton;
typedef void (^block)(ZKButton *button);
@interface ZKButton : UIButton
+(ZKButton *)buttonWithFrame:(CGRect)frame  type:(UIButtonType)type  title:(NSString *)title target:(id)target andAction:(SEL)sel;

+(ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock;

+(ZKButton *)buttonWithframe:(CGRect)frame type:(UIButtonType)type title:(NSString *)title backgroundImage:(NSString *)background image:(NSString *)image andBlock:(block)tempBlock;
@end
