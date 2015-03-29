//
//  ZKTopicViewController.m
//  爱限免-框架
//
//  Created by zhaokai on 15/3/10.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//

#import "ZKTopicViewController.h"
#import "ZKTopicModel.h"
#import "ZKTopicCell.h"

@interface ZKTopicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) int page;

@property(nonatomic,strong)NSMutableArray *datas;

@property(nonatomic,strong)UITableView  *tableView;
@end

@implementation ZKTopicViewController

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
    //请求数据
    _page = 1;
    
    _datas = [NSMutableArray array];
    
    [self downloadData];
    
    //建表
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView ];
    // Do any additional setup after loading the view.
}

-(void)downloadData{
    NSString *path = [NSString stringWithFormat:TOPIC_URL,_page];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        //解析
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",arr[0]);
        for (NSDictionary *dic in arr) {
            ZKTopicModel *model = [ZKTopicModel modelWithDic:dic];
            
            [_datas addObject:model];
        }
        //刷新表
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}

#pragma mark tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZKTopicCell *cell = [ZKTopicCell cellWithTableView:tableView];
    
    ZKTopicModel *model = _datas[indexPath.row];
    
    cell.topicModel = model;
    
    return cell;
}

#pragma mark tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
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
