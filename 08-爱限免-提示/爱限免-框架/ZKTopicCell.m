//
//  ZKTopicCell.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/12.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKTopicCell.h"
#import "ZKTopicRightView.h"
#import "ZKTopicModel.h"
#import "UIKit+AFNetworking.h"
#import "ZKAppListModel.h"

@interface ZKTopicCell ()
@property(nonatomic,strong)UIView *rightView;
@end

@implementation ZKTopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //背景
        UIImageView *background = [[UIImageView alloc]initWithFrame:self.bounds];
        background.image = [UIImage imageNamed:@"topic_Cell_Bg"];
        self.backgroundView = background;
        
        CGFloat leftGap = 10;
        //标题
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftGap, leftGap, 300, 30)];
        _nameLabel.font = UIBOLDFONT16;
        [self.contentView addSubview:_nameLabel];
        
        //左边的图片
        _leftView = [[UIImageView alloc]initWithFrame:CGRectMake(leftGap, CGRectGetMaxY(_nameLabel.frame), 120, 180)];
        
        _leftView.clipsToBounds = YES;
        _leftView.layer.cornerRadius = 10;
        
        [self.contentView addSubview:_leftView];
        
        //右边
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame)+leftGap, CGRectGetMaxY(_nameLabel.frame), 320-CGRectGetMaxX(_leftView.frame)-10, 180)];
        
        [self.contentView addSubview:_rightView];
        
        for (int i= 0; i<4; i++) {
            ZKTopicRightView *subRightView = [[ZKTopicRightView alloc]initWithFrame:CGRectMake(0, i*(40+5), _rightView.bounds.size.width, 40)];
            subRightView.tag = i+100;
            [_rightView addSubview:subRightView];
        }
        
        //详情图标
        _detailView = [[UIImageView alloc]initWithFrame:CGRectMake(leftGap, CGRectGetMaxY(_leftView.frame)+5, 40, 40)];
        
        _detailView.clipsToBounds = YES;
        _detailView.layer.cornerRadius = 10;
        
        [self.contentView addSubview:_detailView];
        
        //详情信息
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_detailView.frame)+5, CGRectGetMaxY(_leftView.frame)+5, 250, 40)];
        _detailLabel.font = UIFONT10;
        _detailLabel.numberOfLines = 2;
        
        [self.contentView addSubview:_detailLabel];
    }
    return self;
}

+(ZKTopicCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ident = @"cell";
    
    ZKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[ZKTopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }

    return cell;
}

-(void)setTopicModel:(ZKTopicModel *)topicModel{
    _topicModel = topicModel;
    
    _nameLabel.text = topicModel.title;
    
    [_leftView setImageWithURL:[NSURL URLWithString:topicModel.img]];
//    _leftView setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>
    
    [_detailView setImageWithURL:[NSURL URLWithString:topicModel.desc_img]];
    
    _detailLabel.text = topicModel.desc;
    
    //右边的view
    for (int i = 0; i<topicModel.applications.count; i++) {
        ZKAppListModel *model = topicModel.applications[i];
        ZKTopicRightView *subView = (ZKTopicRightView *)[_rightView viewWithTag:i+100];
        
        
        subView.model = model;
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
