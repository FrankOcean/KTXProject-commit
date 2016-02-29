//
//  LeftViewController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "LeftViewController.h"
#import "PsyController.h"
#import "AppDelegate.h"
#import "CenterViewController.h"
#import "VideoController.h"
#import "IntroController.h"
#import "NoDullController.h"
#import "ThemeController.h"
#import "BigComController.h"
#import "MoneyController.h"
#import "InternetController.h"
#import "GameController.h"
#import "MusicController.h"
#import "AnimationController.h"
#import "PEController.h"
#import "StoreController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArr;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * arr = @[@"首页",@"心理学",@"电影",@"娱乐",@"商业世界",@"用户推荐",@"设计",@"财经",@"互联网",@"游戏",@"音乐",@"动漫",@"体育"];
    _dataArr = [NSMutableArray arrayWithArray:arr];
    
    [self setTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTableView
{
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageV];
    
    UITableView  * tableView = [[UITableView alloc] init];
    self.tv = tableView;
    //tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * str = @"Identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = nil;
    
    if (indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"home_tab_home.png"];
        cell.textLabel.text = _dataArr[indexPath.row];
        cell.textLabel.textColor = [UIColor blueColor];
    
    }
   
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //非继承自UIViewController以下.....
//    if (indexPath.row == 1) {
//        PsyController * psyController = [[PsyController alloc] initWithNibName:@"BaseViewController" bundle:nil];
//        [self presentViewController:psyController animated:YES completion:nil];
//    }
    // NSArray * arr = @[@"首页",@"心理学",@"电影",@"娱乐",@"商业世界",@"用户推荐",@"设计",@"财经",@"互联网",@"游戏",@"音乐",@"动漫",@"体育"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate * tmpAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPath.row == 0) {
       
        CenterViewController * centerController = [[CenterViewController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];
        [tmpAppDelegate.mainNavigationController pushViewController:centerController animated:NO];
    }
    else if (indexPath.row == 1)
    {
        PsyController * psyController = [[PsyController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 2)
    {
        VideoController * psyController = [[VideoController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 3)
    {
        NoDullController * psyController = [[NoDullController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 4)
    {
        BigComController * psyController = [[BigComController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 5)
    {
        IntroController * psyController = [[IntroController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 6)
    {
        ThemeController * psyController = [[ThemeController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 7)
    {
        MoneyController * psyController = [[MoneyController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 8)
    {
        InternetController * psyController = [[InternetController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 9)
    {
        GameController * psyController = [[GameController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 10)
    {
        MusicController * psyController = [[MusicController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 11)
    {
        AnimationController * psyController = [[AnimationController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
    else if (indexPath.row == 12)
    {
        PEController * psyController = [[PEController alloc] init];
        [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
        [tmpAppDelegate.mainNavigationController pushViewController:psyController animated:NO];
    }
        
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //应为180
    return 140;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tv.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_tv.bounds.size.width - 20 - 50, 80, 50, 50)];
    [btn setTitle:@"收藏" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
   // btn.backgroundColor = [UIColor redColor];
    
    btn.userInteractionEnabled = YES;
    
    [view addSubview:btn];
    
    UIImageView * imgeV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 80, 50, 50)];
    
    imgeV.layer.cornerRadius = 25;
    imgeV.clipsToBounds = YES;
    
    UIImage * image = [UIImage imageNamed:@"Account_Avatar"];
    
    [imgeV setImage:image];
    
    [view addSubview:imgeV];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(95, 80, _tv.bounds.size.width - 140 - 50 , 50)];
    
    label.text = @"FrankOcean";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    [view addSubview:label];
    
    return view;
    
    
}


- (void)btnClick:(UIButton *)btn
{
    
    StoreController * storeVC = [[StoreController alloc]init];
    
    AppDelegate * tmpAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tmpAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    
    [tmpAppDelegate.mainNavigationController pushViewController:storeVC animated:NO];
    
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
