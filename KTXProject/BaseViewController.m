//
//  BaseViewController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "BaseViewController.h"
#import "TableViewCell.h"
#import "MJRefresh.h"
#import "WebViewController.h"
#import "AFNetworking.h"
#import "ELNAlerTool.h"
#import "AdvertScrollerView.h"
#import "ScrollModel.h"
#import "AFHttpRequest.h"
#import "CenterViewController.h"
#import "AppDelegate.h"
#import "ELNAlerTool.h"

#define URL_FIRSTPAGE_DETAIL @"http://news-at.zhihu.com/api/4/story/%@"

#define SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define SCREEN_H  [UIScreen mainScreen].bounds.size.height

@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate,returnBaseVCDelegate>
{
    ScrollModel * _sModel;
    UILabel * _label;
    UIButton * _item1;
}

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [NSMutableArray array];
        _advArr = [NSMutableArray array];
    
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTableView];
    [self addMJRefreshHeader];
   // [self addMjRefreshFooter];
    [self createRecommView];
    
    [self setBarItemButton];
    // Do any additional setup after loading the view from its nib.
    
}


- (void)setBarItemButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn setBackgroundImage:[UIImage imageNamed:@"Fav_Filter_ALL_HL.jpg"] forState:UIControlStateNormal];
    //[btn setImage:[UIImage imageNamed:@"Fav_Filter_ALL_HL.png"] forState:UIControlStateNormal];
    //[btn setTitle:@"TEST" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openOrClosedLeftList) forControlEvents:UIControlEventTouchUpInside];
    
    
    _item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _item1.frame = CGRectMake(0, 0, 24, 24);
    [_item1 setImage:[UIImage imageNamed:@"Dark_Management_Add.png"] forState:UIControlStateNormal];
    
    [_item1 addTarget:self action:@selector(setAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    //右侧边框
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_item1];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 24)];
   
    _label = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, 20, 24)];
   
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor blueColor];
    
    [view addSubview:btn];
    [view addSubview:_label];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
}

- (void)setAddBtnClick:(UIButton *)btn
{
    btn.selected ^= 1;
    if (btn.selected)
    {
        [_item1 setImage:[UIImage imageNamed:@"Dark_Management_Cancel.png"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_item1];
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"关注成功" andInterval:0.8];
    }
    else
    {
        [_item1 setImage:[UIImage imageNamed:@"Dark_Management_Add.png"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_item1];
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"取消关注成功" andInterval:0.8];
    }
    
}

- (void)openOrClosedLeftList
{
    AppDelegate *tmpAppDelete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (tmpAppDelete.LeftSlideVC.closed)
    {
        [tmpAppDelete.LeftSlideVC openLeftView];
        
    } else
    {
        [tmpAppDelete.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // NSLog(@"viewWillDisappear");
    AppDelegate * tmpAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tmpAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"viewWillAppear");
    AppDelegate * tmpAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tmpAppDelegate.LeftSlideVC setPanEnabled:YES];
}



- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];

}

- (void)addMJRefreshHeader
{
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadThisPageData)];
    NSArray * imageArr = @[[UIImage imageNamed:@"Browser_Reload.png"],[UIImage imageNamed:@"Browser_Reload.png"]];
    [header setImages:imageArr duration:1 forState:MJRefreshStateRefreshing];
    [header setImages:@[[UIImage imageNamed:@"Browser_Reload.png"]] duration:1 forState:MJRefreshStateWillRefresh];
    [header setImages:@[[UIImage imageNamed:@"Browser_Reload.png"]] duration:1 forState:MJRefreshStatePulling];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [header setTitle:@"释放进行刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新完成,没有更多数据" forState:MJRefreshStateNoMoreData];
    self.tableView.header = header;
}

- (void)addMjRefreshFooter
{
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    NSArray * imageArr = @[[UIImage imageNamed:@"Browser_Reload.png"],[UIImage imageNamed:@"Browser_Reload.png"]];
    [footer setImages:imageArr duration:1 forState:MJRefreshStateRefreshing];
    _tableView.footer = footer;
}

#pragma mark -- 刷新本页数据
- (void)loadThisPageData
{
    if (!self.dataArr) {
        self.dataArr = [NSMutableArray array];
    }else{
        [self.dataArr removeAllObjects];
    }
    
    if (!self.advArr) {
        self.advArr = [NSMutableArray array];
    }else{
        [self.advArr removeAllObjects];
    }
    
    _page = 1;
    [self setMyUrl];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * imgStr = dict[@"image"];
        NSString * descriptioStr = dict[@"description"];
       
        _sModel = [[ScrollModel alloc] init];
        _sModel.img = imgStr;
        _sModel.name = descriptioStr;
        
        [_advArr addObject:_sModel];
        
        
        NSArray * arra2 = dict[@"stories"];
        for (int i = 0; i < arra2.count; i++) {
            NSDictionary * dataDict = arra2[i];
            NSString * idString = dataDict[@"id"];
            NSString * urlString = [NSString stringWithFormat:URL_FIRSTPAGE_DETAIL,idString];
            
            [AFHttpRequest GET:urlString andSuccess:^(NSData *data) {
                NSDictionary * cDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                cellModel * cModel = [[cellModel alloc] init];
                cModel.title = cDict[@"title"];
                cModel.share_url = cDict[@"share_url"];
                cModel.thumbnail = dataDict[@"images"][0];
                [_dataArr addObject:cModel];
              
//                if (i == 0) {
//                    _sModel.article_id = cDict[@"share_url"];
//                    [_advArr addObject:_sModel];
//                }
                
                
                [_tableView reloadData];
                
            } andFailed:^(NSString *failedReason) {
                
                [ELNAlerTool showAlertMassgeWithController:self andMessage:@"数据请求失败" andInterval:0.5];
            }];
        }
        
        [self createRecommView];
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"数据刷新完成" andInterval:0.2];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"数据请求失败" andInterval:0.5];
    }];
    
    
}

#pragma mark -- 上拉加载数据
- (void)loadMoreData
{
    
    
    [AFHttpRequest GET:self.url andSuccess:^(NSData *data) {
     
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * arra2 = dict[@"stories"];
        for (int i = 0; i < arra2.count; i++) {
            NSDictionary * dataDict = arra2[i];
            NSString * idString = dataDict[@"id"];
            NSString * urlString = [NSString stringWithFormat:URL_FIRSTPAGE_DETAIL,idString];
            
            [AFHttpRequest GET:urlString andSuccess:^(NSData *data) {
                NSDictionary * cDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                cellModel * cModel = [[cellModel alloc] init];
                cModel.title = cDict[@"title"];
                cModel.share_url = cDict[@"share_url"];
                cModel.thumbnail = dataDict[@"images"][0];
                [_dataArr addObject:cModel];
                
                [_tableView reloadData];
                
            } andFailed:^(NSString *failedReason) {
                
                [ELNAlerTool showAlertMassgeWithController:self andMessage:@"数据请求失败" andInterval:0.5];
            }];
        }
       // [_tableView reloadData];
        [_tableView.footer endRefreshing];
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"数据刷新完成" andInterval:0.2];
     
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@",failedReason);
    }];
}

//滚动视图
- (void)createRecommView
{
    AdvertScrollerView * scV = [[AdvertScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 144) andDataSource:_advArr];
    scV.delegate = self;
    _tableView.tableHeaderView = scV;
    
}

//adverScorllView的代理方法
- (void)tapPicIndexID:(NSString *)artID
{
    WebViewController * webController = [[WebViewController alloc] init];
    webController.idStr = artID;
    [self presentViewController:webController animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArr.count <= 0) {
        return 0;
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString * cellID = @"cellID";
      TableViewCell * cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (_dataArr.count <= 0) {
        return cell;
    }
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cellModel * model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArr <= 0) {
        return 0;
    }
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    cellModel * model = _dataArr[indexPath.row];
    WebViewController * next = [[WebViewController alloc] init];
    next.idStr = model.share_url;
    next.titleK = model.title;
    next.thumbnail = model.thumbnail;
    
    //next.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:next animated:YES completion:nil];
}

//网址
- (void)setMyUrl
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
