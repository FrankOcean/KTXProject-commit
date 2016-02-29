//
//  CenterViewController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
// 1.0版本

#import "CenterViewController.h"
#import "cellModel.h"
#import "UIImageView+WebCache.h"
#import "TableViewCell.h"
#import "AFHttpRequest.h"
#import "FirstModel.h"
#import "LeftViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"
#import "NotiController.h"
#import "MJRefresh.h"
#import "ELNAlerTool.h"
#import "FirstModel.h"

#define SCREEN_H  [UIScreen mainScreen].bounds.size.height
#define SCREEN_W  [UIScreen mainScreen].bounds.size.width

#define URL_FIRST @"http://news-at.zhihu.com/api/4/stories/latest"
//#define URL_FIRST @"http://news-at.zhihu.com/api/4/theme/12"
#define URL_FIRSTPAGE_DETAIL @"http://news-at.zhihu.com/api/4/story/%@"
#define URL_YESTERDAY @"http://news-at.zhihu.com/api/4/stories/before/%@"
#define URL_SCROLLVIEW @"http://news-at.zhihu.com/api/4/stories/latest"
#define COUNT 5
#define vBackBarButtonItemName @"backArrow.png"

@interface CenterViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIPageControl * _pageControl;
    //cell信息数据元数组
    NSMutableArray * _cellArray;
    //
    NSString * _dateYString;
    
}

@end

@implementation CenterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBarHidden = YES;
    _cellArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [self setScrollView];
    [self setPageControl];
    [self setTimer];
    
    _tv.delegate = self;
    _tv.dataSource = self;
    [self registTableViewCell];
    [self loadTableViewCellRequest];
    [self loadAdRequest];
    [self setBarItemBtn];
    
    [self addMJReFreshHeader];
    [self addMJRefreshFootrer];
    //在xib中 出现留白....
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark -- 抽屉效果的相关设置
- (void)setBarItemBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn setBackgroundImage:[UIImage imageNamed:@"Fav_Filter_ALL_HL.jpg"] forState:UIControlStateNormal];
    //[btn setImage:[UIImage imageNamed:@"Fav_Filter_ALL"] forState:UIControlStateNormal];
    //[btn setTitle:@"TEST" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openOrClosedLeftList) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *_item1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _item1.frame = CGRectMake(0, 0, 24, 24);
    //[btn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [_item1 setImage:[UIImage imageNamed:@"Dark_Message_Empty.png"] forState:UIControlStateNormal];
    //[_item1 setTitle:@"TEST" forState:UIControlStateNormal];
    [_item1 addTarget:self action:@selector(setSetterView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_item1];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 24)];
    view.backgroundColor = [UIColor clearColor];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, 100, 24)];
    
    _label.text = @"首页";
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor blueColor];
    
    [view addSubview:btn];
    [view addSubview:_label];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)setSetterView
{
    NotiController * noti = [[NotiController alloc] init];
    
    [self.navigationController pushViewController:noti animated:YES];
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
   // NSLog(@"viewWillAppear");
    AppDelegate * tmpAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tmpAppDelegate.LeftSlideVC setPanEnabled:YES];
}


- (void)setScrollView
{
    _scrolView.backgroundColor = [UIColor cyanColor];
    _scrolView.delegate = self;
    _scrolView.pagingEnabled = YES;
    _scrolView.contentSize = CGSizeMake(SCREEN_W * (COUNT + 2), _scrolView.frame.size.height);
    _scrolView.showsHorizontalScrollIndicator = NO;
    _scrolView.showsVerticalScrollIndicator = NO;
    _scrolView.bounces = NO;
    
}
- (void)setPageControl{
   
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(- 60, 100, SCREEN_W, 40)];
    
    //_pageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _pageControl.numberOfPages = COUNT;
    
    [self.view addSubview:_pageControl];
    
}

- (void)setImageView{
    
    NSMutableArray * images = [NSMutableArray array];
    
    for (int i = 0; i < COUNT; i++) {
        NSString * name = [NSString stringWithFormat:@"weather_%d.png", i+1];
        UIImage * image = [UIImage imageNamed:name];
        [images addObject:image];
    }
    
    NSString * name1 = [NSString stringWithFormat:@"weather_%d",COUNT];
    UIImage * image1 = [UIImage imageNamed:name1];
    [images insertObject:image1 atIndex:0];
    
    NSString * name2 = [NSString stringWithFormat:@"weather_%d",1];
    UIImage * image2 = [UIImage imageNamed:name2];
    [images addObject:image2];
    
    for (int i = 0 ; i < images.count ; i++) {
        UIImage * image = images[i];
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(SCREEN_W * i, 0, self.scrolView.frame.size.width, self.scrolView.frame.size.height);
        [self.scrolView addSubview:imageView];
    }
}


//首页scrollview图片数据
- (void)loadAdRequest
{
    [AFHttpRequest GET:URL_SCROLLVIEW andSuccess:^(NSData *data) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray * images = [NSMutableArray array];
        
        NSArray * array = dict[@"top_stories"];
        
        for (int i = 0; i < array.count; i++) {
            
            NSDictionary * dataDict = array[i];
            [images addObject:dataDict[@"image"]];
            
        }
        
        NSString * name1 = images[0];
        
        [images insertObject:name1 atIndex:0];
        
        NSString * name2 = [images lastObject];
        
        [images addObject:name2];
        
        for (int i = 0; i < images.count; i++) {
            UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_W, 0, SCREEN_W, 144)];
            [imgV sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:[UIImage imageNamed:@"Account_Avatar.png"]];
            [_scrolView addSubview:imgV];
            
        }
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@",failedReason);
    }];
}


- (void)setTimer{
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    
}

#pragma mark -- timer1 事件
- (void)changePage{
    
    static int page = 0;
    page ++;
    
    _pageControl.currentPage ++;
    
    if (page == COUNT) {
        self.scrolView.contentOffset = CGPointMake(SCREEN_W , 0);
        _pageControl.currentPage = 0;
        page = 0;
    }else{
        
        [self.scrolView setContentOffset:CGPointMake(SCREEN_W * (_pageControl.currentPage+1), 0) animated:YES];
        
    }
    
}


#pragma mark -- scrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = _scrolView.contentOffset.x/SCREEN_W;
    if(page >= COUNT+1){
        
        _scrolView.contentOffset = CGPointMake(SCREEN_W, 0);
        page = 1;
    }
    else if(page == 0){
        
        _scrolView.contentOffset = CGPointMake(SCREEN_W*COUNT, 0);
        page = COUNT;
        
    }
    
    _pageControl.currentPage = page - 1 ;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell1"];
    cell.model = _cellArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * wbV = [[WebViewController alloc] init];
    
    cellModel * model = _cellArray[indexPath.row];
    wbV.idStr = model.share_url;
    wbV.thumbnail = model.thumbnail;
    wbV.titleK = model.title;
    
    //wbV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:wbV animated:YES completion:nil];
    
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



//首页数据
- (void)registTableViewCell
{
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [_tv registerNib:nib forCellReuseIdentifier:@"tableViewCell1"];
}

- (void)addMJReFreshHeader
{
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTableViewCellRequest)];
    NSArray * imageArr = @[[UIImage imageNamed:@"Browser_Reload.png"],[UIImage imageNamed:@"Browser_Reload.png"]];
    [header setImages:imageArr duration:0.7 forState:MJRefreshStateRefreshing];
    [header setImages:@[[UIImage imageNamed:@"Browser_Reload.png"]] duration:0.8 forState:MJRefreshStateWillRefresh];
    [header setImages:@[[UIImage imageNamed:@"Browser_Reload.png"]] duration:0.8 forState:MJRefreshStatePulling];
    [header setTitle:@"Browser_Reload.png" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"Browser_Reload.png" forState:MJRefreshStateRefreshing];
    [header setTitle:@"Browser_Reload.png" forState:MJRefreshStatePulling];
    [header setTitle:@"Browser_Reload.png" forState:MJRefreshStateNoMoreData];
    self.tv.header = header;
    
}

- (void)loadTableViewCellRequest
{
    
    //主页的接口
    NSString * strUrl = [NSString stringWithFormat:URL_FIRST];
    [AFHttpRequest GET:strUrl andSuccess:^(NSData *data) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dateYString = dict[@"date"];
        
        NSArray * array = dict[@"stories"];
        for (int i = 0; i < array.count; i++) {
          
            NSDictionary * dataDict = array[i];
            NSString * idString = dataDict[@"id"];
            NSString * urlString = [NSString stringWithFormat:URL_FIRSTPAGE_DETAIL,idString];
            
            [AFHttpRequest GET:urlString andSuccess:^(NSData *data) {
                
                NSDictionary * cDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                cellModel * cModel = [[cellModel alloc] init];
                cModel.title = cDict[@"title"];
                cModel.share_url = cDict[@"share_url"];
                cModel.thumbnail = cDict[@"image"];
                [_cellArray addObject:cModel];
                
                [_tv reloadData];
                
            } andFailed:^(NSString *failedReason) {
                NSLog(@"%@",failedReason);
            }];
          
        }
        
        [_tv.header endRefreshing];
        
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@",failedReason);
    }];
}




- (void)addMJRefreshFootrer
{
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    NSArray * imageArr = @[[UIImage imageNamed:@"Browser_Reload.png"],[UIImage imageNamed:@"Browser_Reload.png"]];
    [footer setImages:imageArr duration:1 forState:MJRefreshStateRefreshing];
    
    self.tv.footer = footer;
}

- (void)loadMoreData
{
    
    NSString * strUrl = [NSString stringWithFormat:URL_YESTERDAY,_dateYString];
   
    [AFHttpRequest GET:strUrl andSuccess:^(NSData *data) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        _dateYString = dict[@"date"];
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
                [_cellArray addObject:cModel];
                
                [_tv reloadData];
                
            } andFailed:^(NSString *failedReason) {
                
                [ELNAlerTool showAlertMassgeWithController:self andMessage:@"数据请求失败" andInterval:0.5];
            }];
        }
     
        [_tv.footer endRefreshing];
  
    } andFailed:^(NSString *failedReason) {
        NSLog(@"%@",failedReason);
    }];

}

@end
