//
//  ZKCollectonViewController.m
//  爱限免-框架
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKCollectonViewController.h"
#import "ZKAppListModel.h"

@interface ZKCollectonViewController ()

@end

@implementation ZKCollectonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    
    ZKDataCenter *center = [ZKDataCenter singleInstance];
    
    NSArray *array = [center getApplistModelsWithRecondType:RecondTypeWithcollection];
    
    //NSArray *titles = @[@"我的收藏" ,@"我的下载" ,@"帮助" ,@"设置" ,@"我的蚕豆" ,@"评论" ,@"账户" ,@"我的分享" ];
    //NSArray *images = @[@"collect" ,@"download" ,@"help" ,@"setting" ,@"candou" ,@"comment" ,@"user" ,@"favorite" ];
    CGFloat w = 80;
    CGFloat h = 80;
    CGFloat gap = 20;
    
    
    
    for (int i = 0; i < array.count; i++) {
        CGFloat lie = i%3;
        CGFloat hang = i/3;
        
        ZKAppListModel *model = array[i];
        
        ZKButton *button = [ZKButton buttonWithframe:CGRectMake(gap+(w+gap)*lie, 100+hang*(h+gap), w, h) type:UIButtonTypeCustom title:nil backgroundImage:nil image:nil andBlock:^(ZKButton *button) {
            if (0 == i) {
                NSLog(@"%i", i);
            }
        }];
        [button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.iconUrl]];
        button.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:button];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(gap+(w+gap)*lie, 100+hang*(h+gap)+80, w, 20)];
        name.text = model.name;
        [self.view addSubview:name];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
