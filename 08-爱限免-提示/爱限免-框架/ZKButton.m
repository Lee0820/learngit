//
//  ZKButton.m
//  03-block的基本知识
//
//  Created by zhaokai on 15-3-6.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKButton.h"
@interface ZKButton()
//注意:给block变量写合成存取,一定要使用copy
@property (nonatomic,copy) block myBlock;
@end

@implementation ZKButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title target:(id)target andAction:(SEL)sel{
    ZKButton *button = [ZKButton buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return button;
}

//利用block生成button对象
+(ZKButton *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title andBlock:(block)tempBlock{
    ZKButton *button = [ZKButton buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    button.myBlock = tempBlock;
    
    return button;

}

-(void)buttonClicked:(ZKButton *)button{
    NSLog(@"这里是buttonClicked方法的内部");
    //触发按钮
    button.tag = 10;
    button.myBlock(button);
    
}

+(ZKButton *)buttonWithframe:(CGRect)frame type:(UIButtonType)type title:(NSString *)title backgroundImage:(NSString *)background image:(NSString *)image andBlock:(block)tempBlock{
    ZKButton *button = [ZKButton buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    //标题是蓝色
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:background] forState:UIControlStateNormal];
    
    button.myBlock = tempBlock;
    
    return button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
