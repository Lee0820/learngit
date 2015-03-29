//
//  ZKTopicRightView.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKTopicRightView.h"
#import "StarView.h"
#import "UIKit+AFNetworking.h"
#import "ZKAppListModel.h"

@implementation ZKTopicRightView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //左边的图
        _subLeftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        _subLeftView.clipsToBounds = YES;
        _subLeftView.layer.cornerRadius = 10;
        
        [self addSubview:_subLeftView];
        
        //标题
        _subNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_subLeftView.frame)+5, 0, 120, 20)];
        _subNameLabel.font = UIFONT12;
        [self addSubview:_subNameLabel];
        
        //评论
        UIImageView *commentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_subLeftView.frame)+5, CGRectGetMaxY(_subNameLabel.frame), 10, 10)];
        commentImageView.image = [UIImage imageNamed:@"topic_Comment"];
        [self addSubview:commentImageView];
        
        _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(commentImageView.frame)+5, CGRectGetMaxY(_subNameLabel.frame), 40, 10)];
        _commentLabel.font = UIFONT9;
        [self addSubview:_commentLabel];
        
        //下载
        UIImageView *downloadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_commentLabel.frame), CGRectGetMaxY(_subNameLabel.frame), 10, 10)];
        downloadImageView.image = [UIImage imageNamed:@"topic_Download"];
        [self addSubview:downloadImageView];
        
        _downloadLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(downloadImageView.frame)+5, CGRectGetMaxY(_subNameLabel.frame), 40, 10)];
        _downloadLabel.font = UIFONT9;
        [self addSubview:_downloadLabel];
        
        //星星
        _starView = [[StarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_subLeftView.frame)+5, CGRectGetMaxY(commentImageView.frame), 100, 10)];
        [self addSubview:_starView];
        
    }
    return self;
}

-(void)setModel:(ZKAppListModel *)model{
    _model = model;
    
    [_subLeftView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    
    _subNameLabel.text = model.name;
    //原因:原始的数据的类型不确定,可能是简单数据类型或NSNumber或字符串,所以统一转化成字符串
    _commentLabel.text = [NSString stringWithFormat:@"%@",model.comment];
    
    _downloadLabel.text = [NSString stringWithFormat:@"%@",model.downloads];
    
    [_starView setStar:[model.starOverall floatValue]];
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
