//
//  ZKAppListViewController.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/10.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKAppListViewController.h"
#import "ZKButton.h"

#import "AFNetworking.h"
#import "ZKAppListModel.h"
#import "ZKAppListCell.h"
#import "ZKDetailViewController.h"
#import "ZKSeachAppViewController.h"
#import "ZKCategoryViewController.h"
#import "ZKSetViewController.h"
//#import "MBProgressHUD.h"
#import "MMProgressHUD.h"

@interface ZKAppListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,assign) int page;//页数
@property (nonatomic,copy) NSString *categeryId;//分类的id

@property(nonatomic,strong)NSMutableArray *datas;//保存所有的数据

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UISearchBar *searchBar;//搜索栏
@end

@implementation ZKAppListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _datas = [NSMutableArray array];
    [self downloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getNavigationItem];
    
    //请求数据
    _page = 1;
     
  
//    //初始化datas
//    _datas = [NSMutableArray array];
    
    
    
    //搜索栏
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 40)];
    _searchBar.placeholder = @"60万款应用有你好看";
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];

    //创建表
    CGRect rect = self.view.bounds;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame), 320,rect.size.height-CGRectGetMaxY(_searchBar.frame)-44) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
       // Do any additional setup after loading the view.
}

#pragma mark searchBarDelegate
//开始编辑的时候
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //当编辑的时候,显示删除按钮
    [searchBar setShowsCancelButton:YES animated:YES];
}
//点击清除按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //隐藏删除按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [searchBar resignFirstResponder];
}
//点击搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    ZKSeachAppViewController *seachApp = [[ZKSeachAppViewController alloc]init];
    seachApp.searchText = searchBar.text;
    
    [self.navigationController pushViewController:seachApp animated:YES];
}

#pragma mark tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKAppListCell *cell = [ZKAppListCell cellWithTableView:tableView];
        
    ZKAppListModel *model = _datas[indexPath.row];
    
    cell.myModel = model;
    
    return cell;
}

#pragma mark tableViewDelegate
//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKDetailViewController *detail = [[ZKDetailViewController alloc]init];
    detail.detailModel = _datas[indexPath.row];
    
    detail.proTitle = self.title;
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark 下载数据
-(void)downloadData{
    NSString *path = [NSString stringWithFormat:_urlString,_page,_categeryId];
    //获取单例对像
    ZKDataCache *cache = [ZKDataCache sharedDataCache];
    NSData *data = [cache getDataWithUrlStirng:path];
        //如果缓存中有数据 直接使用
    if (data) {
        //解析
        //
        NSLog(@"读取缓存");
        [self getModelArrayWithData:data];
        return;
    }
    
    //用户第一次加载数据不显示提示框
    static BOOL isPro = NO;
    if (isPro == NO) {
        isPro = YES;
    } else {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        //参数1.提示框类型, 2.标题 3.当前状态
        [MMProgressHUD showProgressWithStyle:MMProgressHUDProgressStyleIndeterminate title:@"限免" status:@"正在下载"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getModelArrayWithData:responseObject];
            //保存数据 对数据进行缓存
        [cache saveData:responseObject withUrlString:path];
    
        //下载完成 结束提示
            //成功提示
        [MMProgressHUD dismissWithSuccess:@"下载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //失败提示
        [MMProgressHUD dismissWithError:@"下载失败"];
    }];
}

//解析
- (void)getModelArrayWithData:(NSData *)data {
    //进行json解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *array = dic[@"applications"];
    
    for (NSDictionary *tempDic in array) {
        ZKAppListModel *model = [ZKAppListModel appListModelWithDic:tempDic];
        
        [_datas addObject:model];
    }
    
    //刷新表要在block的内部
    [_tableView reloadData];
}

-(void)getNavigationItem{
    //设置左边的分类按钮
    ZKButton *categoryButton = [ZKButton buttonWithframe:CGRectMake(0, 0, 60, 30) type:UIButtonTypeCustom title:@"分类" backgroundImage:@"buttonbar_action" image:nil andBlock:^(ZKButton *button) {
        NSLog(@"写将来的分类的内容");
        
        ZKCategoryViewController *category = [[ZKCategoryViewController alloc]init];
        
        [self.navigationController pushViewController:category animated:YES];
    }];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:categoryButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    //设置右边的设置按钮
    ZKButton *setButton = [ZKButton buttonWithframe:CGRectMake(0, 0, 60, 30) type:UIButtonTypeCustom title:@"设置" backgroundImage:@"buttonbar_edit" image:nil andBlock:^(ZKButton *button) {
        NSLog(@"写将来的设置的内容");
        
        ZKSetViewController *set = [[ZKSetViewController alloc] init];
        [self.navigationController pushViewController:set animated:YES];
        
    }];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:setButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
