//
//  ZKLookSnapShotViewController.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKLookSnapShotViewController.h"
#import "ZKSnapShotModel.h"
@interface ZKLookSnapShotViewController ()

@end

@implementation ZKLookSnapShotViewController

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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    [imageView setImageWithURL:[NSURL URLWithString:_snapModel.originalUrl]];
    
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
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
