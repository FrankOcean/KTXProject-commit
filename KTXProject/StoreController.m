//
//  StoreController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/20.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "StoreController.h"
#import "TableViewCell.h"
#import "WebViewController.h"
#import "FMDatabase.h"
#import "UIImageView+WebCache.h"

#define PATH   [NSString stringWithFormat:@"%@/Documents/Store.db",NSHomeDirectory()]

//static NSMutableArray * _dataArr = nil;

@interface StoreController ()<UITableViewDataSource,UITableViewDelegate>
{
    FMDatabase * _db;

    NSMutableArray * _dataArr;
    
    UILabel * _label;

}

@end

@implementation StoreController

- (instancetype)init
{
    if (self = [super init]) {
        
        _dataArr = [[NSMutableArray alloc]init];
        _db = [[FMDatabase alloc] initWithPath:PATH];
        [_db open];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storeVC.delegate = self;
    _storeVC.dataSource = self;
    
    [self registTableViewCell];
    
    [self setDataArr];
    
    [self setNavigationItem];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTableViewEvent:)];
}

- (void)editTableViewEvent:(UIBarButtonItem *)rightButtonItem
{
    if (_storeVC.editing == NO) {
        
        [_storeVC setEditing:YES animated:YES];
        rightButtonItem.title = @"完成";
    }
    else
    {
        [_storeVC setEditing:NO animated:YES];
        rightButtonItem.title = @"编辑";
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //从数据库中删除单个数据元
    cellModel * model = _dataArr[indexPath.row];
    NSString * sqlDelete = @"delete from Store where title=?";
    [_db executeUpdate:sqlDelete,model.title];
    //从数组中删除
    [_dataArr removeObjectAtIndex:indexPath.row];
    [_storeVC deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [_storeVC reloadData];
}

#pragma mark -- delegate
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    cellModel * tempModel = _dataArr[sourceIndexPath.row];
    
    if (sourceIndexPath.row < destinationIndexPath.row)
    {
        for (NSInteger i = sourceIndexPath.row; i < destinationIndexPath.row; i++) {
            cellModel * next = _dataArr[i + 1];
            [_dataArr replaceObjectAtIndex:i withObject:next];
        }
        [_dataArr replaceObjectAtIndex:destinationIndexPath.row withObject:tempModel];
    }
    else
    {
        for (NSInteger i = sourceIndexPath.row; i > destinationIndexPath.row; i--) {
            cellModel * last = _dataArr[i - 1];
            [_dataArr replaceObjectAtIndex:i withObject:last];
        }
        [_dataArr replaceObjectAtIndex:destinationIndexPath.row withObject:tempModel];
    }
}

//从数据库中取出数据 存入数组中
- (void)setDataArr
{
    NSString * selectSql = @"select * from Store";
    FMResultSet * resultSet = [_db executeQuery:selectSql];
    while ([resultSet next]) {
        cellModel * model = [[cellModel alloc] init];
        model.title = [resultSet stringForColumn:@"title"];
        model.thumbnail = [resultSet stringForColumn:@"thumbnail"];
        model.share_url = [resultSet stringForColumn:@"share_url"];
        [_dataArr addObject:model];
       
    }
    [_storeVC reloadData];
}

- (void)registTableViewCell
{
    UINib * nib = [UINib nibWithNibName:@"StoreCell" bundle:nil];
    [_storeVC registerNib:nib forCellReuseIdentifier:@"tableViewCell2"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell2"];
    cell.model = _dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * webController = [[WebViewController alloc] init];
    cellModel * model = _dataArr[indexPath.row];
    webController.idStr = model.share_url;
    [self presentViewController:webController animated:NO completion:nil];
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
