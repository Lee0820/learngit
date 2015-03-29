//
//  ZKDetailViewController.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/11.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKDetailViewController.h"
#import "ZKAppListModel.h"
#import "ZKSnapShotModel.h"
#import "ZKLookSnapShotViewController.h"
#import "ZKImageView.h"
#import "UMSocial.h"

@interface ZKDetailViewController ()
@property(nonatomic,strong)UIScrollView *snapShotView;//截图的滚动视图

@property(nonatomic,strong)NSMutableArray *snapShots;//保存截图信息

@property(nonatomic,strong)UIScrollView *bottomView;//展示底部应用的滚动视图

@property(nonatomic,strong)NSMutableArray *nearByApps;//附近的应用

@property (nonatomic, strong)UIImageView *leftView;
@end

@implementation ZKDetailViewController

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
    
    self.title = @"应用详情";
    
    //1.设置上部的UI
    [self setTopUI];
    //2.下载应用的截图
    [self downloadSnapShotImage];
    //3.设置下部的UI
    [self setBottomUI];
    //4.下载周围的应用
    _nearByApps = [NSMutableArray array];
    [self downloadBottomApplicationList];
    // Do any additional setup after loading the view.
}

#pragma mark //4.下载周围的应用
-(void)downloadBottomApplicationList{
    NSString *path = [NSString stringWithFormat:NEARBY_APP_URL,40.0209,116.2148];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        //解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"applications"];
        
        for (NSDictionary *dic in array) {
            ZKAppListModel *model = [ZKAppListModel appListModelWithDic:dic];
            
            [_nearByApps addObject:model];
        }
        
        //填充底部的滚动视图
        [self createNearByAppScrollView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}

-(void)createNearByAppScrollView{
    CGFloat w = 40;
    for (int i = 0; i<_nearByApps.count; i++) {
        ZKImageView *imageView = [[ZKImageView alloc]initWithFrame:CGRectMake(10 + i*(w+10), 0, w, w)];
        //取出对应的模型
        ZKAppListModel *model = _nearByApps[i];
        
        [imageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        //设置圆角
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 10;
        
        imageView.userInteractionEnabled = YES;
        
        //添加动作
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        imageView.model = model;
        [_bottomView addSubview:imageView];
        
        //底部的题目
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+i*(w+10), w, w+8, 15)];
        nameLabel.text = model.name;
        nameLabel.font = UIFONT9;
        [_bottomView addSubview:nameLabel];
    }
    
    //设置滚动视图的内容大小
    _bottomView.contentSize = CGSizeMake(10 + (w+10)*_nearByApps.count, 0);
}

//点击应用时执行的方法
-(void)tapImageView:(UITapGestureRecognizer *)tap{
    ZKImageView *imageView = (ZKImageView *)tap.view;
    
    ZKDetailViewController *detail = [[ZKDetailViewController alloc]init];
    detail.detailModel = imageView.model;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark //3.设置下部的UI
-(void)setBottomUI{
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(10,64+280+5, 300, 80)];
    
    backgroundView.image = [UIImage imageNamed:@"appdetail_recommend"];
    
    backgroundView.userInteractionEnabled = YES;
    
    [self.view addSubview:backgroundView];
    
    //添加滚动视图
    _bottomView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 18, 280, 55)];
    //_bottomView.backgroundColor = [UIColor greenColor];
    [backgroundView addSubview:_bottomView];
}

#pragma mark //2.下载应用的截图
-(void)downloadSnapShotImage{
    //单独请求详情界面
    NSString *path = [NSString stringWithFormat:DETAIL_URL,[_detailModel.applicationId intValue]];
    
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"string:%@",string);
        
        //解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"photos"];
        
        _snapShots = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            ZKSnapShotModel *model = [ZKSnapShotModel modelWithDic:dic];
            [_snapShots addObject:model];
        }
        
        [self createSnapShotView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createSnapShotView{
    CGFloat wigth = 80;
  
    for (int i = 0; i<_snapShots.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*(wigth+5), 0, wigth, 80)];
        ZKSnapShotModel *model = _snapShots[i];
        
        [imageView setImageWithURL:[NSURL URLWithString:model.smallUrl]];
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextPage:)];
        
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        [_snapShotView addSubview:imageView];
        
        imageView.tag = i+100;
    }
    
    //内容的尺寸
    _snapShotView.contentSize = CGSizeMake(wigth*_snapShots.count, 0);
}

-(void)nextPage:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageView = (UIImageView *)tap.view;
    
    ZKLookSnapShotViewController *look = [[ZKLookSnapShotViewController alloc]init];
    look.snapModel = _snapShots[imageView.tag-100];
    [self.navigationController pushViewController:look animated:YES];
}

#pragma mark //1.设置上部的UI
-(void)setTopUI{
    
    CGFloat leftGap = 10;
    CGFloat gap = 5;
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(leftGap,64 + gap, 300, 280)];
    
    backgroundView.image = [UIImage imageNamed:@"appdetail_background"];
    backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundView];
    
    //左边的图片
    _leftView = [[UIImageView alloc]initWithFrame:CGRectMake(leftGap, gap+10, 80, 80)];
    [_leftView setImageWithURL:[NSURL URLWithString:_detailModel.iconUrl]];
    _leftView.clipsToBounds = YES;
    _leftView.layer.cornerRadius = 10;
    
    [backgroundView addSubview:_leftView];
    
    //应用的名字
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame)+gap, gap+10, 200, 30)];
    nameLabel.text = _detailModel.name;
    nameLabel.font = UIBOLDFONT17;
    
    [backgroundView addSubview:nameLabel];
    
    //原价
    UILabel *normalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame)+gap, CGRectGetMaxY(nameLabel.frame), 120, 25)];
    normalPriceLabel.text = [NSString stringWithFormat:@"原价:$ %@  %@中",_detailModel.lastPrice,_proTitle];
    normalPriceLabel.font = UIFONT13;
    [backgroundView addSubview:normalPriceLabel];
    
    //类型
    UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftView.frame)+gap, CGRectGetMaxY(normalPriceLabel.frame), 120, 25)];
    categoryLabel.text = [NSString stringWithFormat:@"类型:%@",_detailModel.categoryName];
    
    categoryLabel.font = UIFONT13;
    
    [backgroundView addSubview:categoryLabel];
    
    //软件的大小
    UILabel *fileLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(normalPriceLabel.frame), CGRectGetMaxY(nameLabel.frame), 90, 25)];
    fileLabel.font = UIFONT13;
    fileLabel.text = [NSString stringWithFormat:@"%@ MB",_detailModel.fileSize];
    [backgroundView addSubview:fileLabel];
    
    //评分
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(normalPriceLabel.frame), CGRectGetMaxY(fileLabel.frame), 90, 25)];
    commentLabel.font = UIFONT13;
    commentLabel.text = [NSString stringWithFormat:@"评分:%@",_detailModel.starOverall];
    [backgroundView addSubview:commentLabel];

    
    //三个按钮
    NSArray *titles = @[@"分享",@"收藏",@"下载"];
    NSArray *images = @[@"Detail_btn_left",@"Detail_btn_middle",@"Detail_btn_right"];
    
    ZKDataCenter *center = [ZKDataCenter singleInstance];
    
    //如果数据库中有本应用的modol 并且器RecondType 是RecondTypeWithcollection 那么本应用就已经收藏...
    __block BOOL isCollect = [center selectApplistModel:_detailModel andRecondType:RecondTypeWithcollection];
    
    
    for (int i = 0; i<titles.count; i++) {
        ZKButton *button = [ZKButton buttonWithframe:CGRectMake(i*100, CGRectGetMaxY(_leftView.frame)+10, 100, 40) type:UIButtonTypeCustom title:titles[i] backgroundImage:images[i]  image:nil andBlock:^(ZKButton *button) {
            //功能
            
            if (0 == i) {
                //分享
                //1.使用系统的方法
                    //注册分享菜单
                
//                UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"微信好友",@"微信圈子",@"邮件",@"短信", nil];
//                [sheet showInView:self.view];
                
                // 第二种 直接加载的是友盟的view
                
                /**
                 弹出一个分享列表的类似iOS6的UIActivityViewController控件
                 
                 @param controller 在该controller弹出分享列表的UIActionSheet
                 @param appKey 友盟appKey
                 @param shareText  分享编辑页面的内嵌文字
                 @param shareImage 分享内嵌图片,用户可以在编辑页面删除
                 @param snsNames 你要分享到的sns平台类型，该NSArray值是`UMSocialSnsPlatformManager.h`定义的平台名的字符串常量，有UMShareToSina，UMShareToTencent，UMShareToRenren，UMShareToDouban，UMShareToQzone，UMShareToEmail，UMShareToSms等
                 @param delegate 实现分享完成后的回调对象，如果不关注分享完成的状态，可以设为nil
                 */
                
                [UMSocialSnsService presentSnsIconSheetView:self
                                                appKey:@"507fcab25270157b37000010"
                                                  shareText:[NSString stringWithFormat:@"应用 %@ 的详情是：%@",self.detailModel.name,self.detailModel.description]
                                                 shareImage:_leftView.image
                                            shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms,nil]
                                                   delegate:nil];
                
                //2.使用um的API
                
                
            } else if (i == 1) {
                //收藏
                if (isCollect == NO) {
                    [button setTitle:@"取消收藏" forState:UIControlStateNormal];
                    isCollect = YES;
                    [center addApplistModel:_detailModel andRecondType:RecondTypeWithcollection];
                } else {
                    [button setTitle:@"收藏" forState:UIControlStateNormal];
                    isCollect = NO;
                    [center deleteApplistModel:_detailModel andRecondType:RecondTypeWithcollection];
                }
            } else {
                //下载
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_detailModel.itunesUrl]];
            }
            
        }];
        
        //第二次进入界面 
        if (i == 1) {
            if (isCollect == YES) {
                [button setTitle:@"取消收藏" forState:UIControlStateNormal];
            }
        }
        
        [backgroundView addSubview:button];
    }
    
    //截图视图
    _snapShotView = [[UIScrollView alloc]initWithFrame:CGRectMake(leftGap, CGRectGetMaxY(_leftView.frame)+10+40+5, 280, 80)];
    _snapShotView.backgroundColor = [UIColor redColor];
    
    [backgroundView addSubview:_snapShotView];
    
    //详情
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftGap, CGRectGetMaxY(_snapShotView.frame), 280, 50)];
    //detailLabel.backgroundColor = [UIColor redColor];
    detailLabel.numberOfLines = 0;
    detailLabel.font = UIFONT10;
    detailLabel.text = _detailModel.description;
    [backgroundView addSubview:detailLabel];
}


//使用第二种分享方法  不会调用这个方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex<5) {
        
        //定义分享内容
        NSString *shareText = @"日薪百万";

        //设置分享内容
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:_leftView.image socialUIDelegate:nil];
        //定义分型平台
        NSArray *sharedPlatform = @[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms];
        //选定当前的平台
        UMSocialSnsPlatform *platform = [UMSocialSnsPlatformManager getSocialPlatformWithName:sharedPlatform[buttonIndex]];
        platform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
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
