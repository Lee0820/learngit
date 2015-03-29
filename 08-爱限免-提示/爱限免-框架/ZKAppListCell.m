//
//  ZKAppListCell.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKAppListCell.h"
#import "StarView.h"
#import "UIKit+AFNetworking.h"
#import "ZKAppListModel.h"

@implementation ZKAppListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //背景视图
        UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cate_list_bg2"]];
        
        self.backgroundView = backgroundView;
        
        //左边的图片
        CGFloat leftGap = 15;
        CGFloat gap = 10;
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(leftGap, gap, 60, 60)];
        //设置圆角
        _leftImageView.clipsToBounds = YES;
        _leftImageView.layer.cornerRadius = 10;
        
        //_leftImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_leftImageView];
        
        //软件名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+gap, gap, 120, 30)];
        _nameLabel.font = UIBOLDFONT16;
       // _nameLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_nameLabel];
        
        //星星
        _myStarView = [[StarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+gap, CGRectGetMaxY(_nameLabel.frame), 80, 25)];
        [self.contentView addSubview:_myStarView];
        
        //软件大小
        _fileSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)+gap, 20, 70, 25)];
        _fileSizeLabel.font = UIFONT13;
        [self.contentView addSubview:_fileSizeLabel];
        
        //属性
        _categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)+gap, CGRectGetMaxY(_fileSizeLabel.frame), 50, 25)];
       // _categoryLabel.backgroundColor = [UIColor redColor];
        _categoryLabel.font = UIFONT13;
        [self.contentView addSubview:_categoryLabel];
        
        //分享
        _sharedLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftGap, CGRectGetMaxY(_leftImageView.frame), 100, 25)];
        _sharedLabel.font = UIFONT13;
        //_sharedLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_sharedLabel];
        
        //收藏
        _collectLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sharedLabel.frame), CGRectGetMaxY(_leftImageView.frame), 100, 25)];
        //_collectLabel.backgroundColor = [UIColor redColor];
        _collectLabel.font = UIFONT13;
        [self.contentView addSubview:_collectLabel];
        
        //下载
        _downloadLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_collectLabel.frame), CGRectGetMaxY(_leftImageView.frame), 100, 25)];
        //_downloadLabel.backgroundColor = [UIColor redColor];
        _downloadLabel.font = UIFONT13;
        [self.contentView addSubview:_downloadLabel];
    }
    return self;
}

+(ZKAppListCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ident = @"cell";
    
    ZKAppListCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[ZKAppListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }

    return cell;
}

-(void)setMyModel:(ZKAppListModel *)myModel{
    _myModel = myModel;
    
    [_leftImageView setImageWithURL:[NSURL URLWithString:myModel.iconUrl]];
    
    _nameLabel.text = myModel.name;
    
    [_myStarView setStar:[myModel.starCurrent floatValue]];
    
    _fileSizeLabel.text = [NSString stringWithFormat:@"%@ MB",myModel.fileSize];
    
    _categoryLabel.text = myModel.categoryName;
    
    //分享
    _sharedLabel.text = [NSString stringWithFormat:@"分享:%@",myModel.shares];
    //收藏
    _collectLabel.text = [NSString stringWithFormat:@"收藏:%@",myModel.favorites];
    //下载
    _downloadLabel.text = [NSString stringWithFormat:@"下载:%@",myModel.downloads];
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
