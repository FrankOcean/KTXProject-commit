//
//  CommentController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/21.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "CommentController.h"
#import "AFHttpRequest.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"

#define URL_SHORTCOMMENT @"http://news-at.zhihu.com/api/4/story/%@/short-comments"
#define URL_LONGCOMMENT @"http://news-at.zhihu.com/api/4/story/%@/long-comments"

@interface CommentController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _SDataArray;
    NSMutableArray * _LDataArray;
    NSMutableArray * _SSDataArray;
}

@end

@implementation CommentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _SDataArray = [NSMutableArray array];
    _LDataArray = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self loadData];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)loadData
{
    NSArray * arr = [_idStr componentsSeparatedByString:@"/"];
    NSString * urlStr = [arr lastObject];
    
    NSString * longCommentStr = [NSString stringWithFormat:URL_LONGCOMMENT,urlStr];
    NSString * shortCommentStr = [NSString stringWithFormat:URL_SHORTCOMMENT,urlStr];
    //长评
    [AFHttpRequest GET:longCommentStr andSuccess:^(NSData *data) {
       
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dict[@"comments"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary * sDict = array[i];
            CommentModel * model = [[CommentModel alloc] init];
            model.author = sDict[@"author"];
            model.avatar = sDict[@"avatar"];
            model.content = sDict[@"content"];
            model.time = sDict[@"time"];
            model.likes = sDict[@"likes"];
            [_LDataArray addObject:model];
        }
        
        [_tableView reloadData];
        
    } andFailed:^(NSString *failedReason) {
        
        NSLog(@"%@",failedReason);
    }];
    
    //短评
    [AFHttpRequest GET:shortCommentStr andSuccess:^(NSData *data) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dict[@"comments"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary * sDict = array[i];
            CommentModel * model = [[CommentModel alloc] init];
            model.author = sDict[@"author"];
            model.avatar = sDict[@"avatar"];
            model.content = sDict[@"content"];
            model.time = sDict[@"time"];
            model.likes = sDict[@"likes"];
            [_SDataArray addObject:model];
        }
        
        [_tableView reloadData];

    } andFailed:^(NSString *failedReason) {
        
        NSLog(@"%@",failedReason);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _LDataArray.count;
    }
    else
    {
        return _SDataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    
    CGFloat contentWidth = _tableView.frame.size.width;
    UIFont * font = [UIFont systemFontOfSize:13];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0) {
        
        CommentModel * model = _LDataArray[indexPath.row];
        cell.textLabel.text = model.content;
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = model.author;
        CGSize size = [model.content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        CGRect rect = [cell.textLabel textRectForBounds:cell.textLabel.frame limitedToNumberOfLines:0];
        rect.size = CGSizeMake(contentWidth, size.height + 40);
        cell.textLabel.frame = rect;
        cell.textLabel.font = font;
        //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        return cell;
    }
    else
    {
        CommentModel * model = _SDataArray[indexPath.row];
        cell.textLabel.text = model.content;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = model.author;
        CGSize size = [model.content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        
        CGRect rect = [cell.textLabel textRectForBounds:cell.textLabel.frame limitedToNumberOfLines:0];
        rect.size = CGSizeMake(contentWidth, size.height + 40);
        cell.textLabel.frame = rect;
        cell.textLabel.font = font;
       // [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
        return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 列寬
    CGFloat contentWidth = self.tableView.frame.size.width;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:15];
    
    
    if (indexPath.section == 0) {
        
        CommentModel * model = _LDataArray[indexPath.row];
       
        NSString *content = model.content;
        
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height + 40;
    }
    else
    {
        CommentModel * model = _SDataArray[indexPath.row];
       
        NSString *content = model.content;
        
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height + 40;
    }
  
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 48)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, 25)];
        label.text = @"深度长评";
        [view addSubview:label];
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 48)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, 25)];
        label.text = @"短评";
        [view addSubview:label];
        return view;
    }
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSArray *array = @[@"长评", @"短评"];
    
    return array;
    
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

- (IBAction)backBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
