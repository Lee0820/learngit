//
//  ZKTabBarViewController.h
//  爱限免-框架
//
//  Created by zhaokai on 15/3/10.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKTabBarViewController : UITabBarController
-(UIViewController *)controllerWithString:(NSString *)controller title:(NSString *)title andImage:(NSString *)imageName;
@end
