//
//  WebViewController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "WebViewController.h"
#import "StoreController.h"
#import "ELNAlerTool.h"
#import "Reachability.h"
#import "MBProgressHUD+MJ.h"
#import "cellModel.h"
#import "AFHttpRequest.h"
#import "FMDatabase.h"
#import "CommentController.h"
#import "UMSocial.h"

#define SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define PATH   [NSString stringWithFormat:@"%@/Documents/Store.db",NSHomeDirectory()]

static NSMutableArray * _mutArray = nil;
static FMDatabase * _dataBase = nil;
@interface WebViewController ()<UIWebViewDelegate>
{
    NSMutableArray * _mutArray;
    cellModel * _cModel;
    BOOL  _isCollected;    // 是否已收藏
    FMDatabase * _dataBase; // 创建数据库
    NSString * _sqlCreate; // 创建表
}

@end

@implementation WebViewController

- (instancetype)init
{
    if (self = [super init]) {
        if (_mutArray == nil) {
            _mutArray = [[NSMutableArray alloc] init];
        }
        if (_dataBase == nil) {
            _dataBase = [FMDatabase databaseWithPath:PATH];
            [_dataBase open];
        }
        _cModel = [[cellModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [self setWeBView];
  
}


- (void)setWeBView
{
    NSURL * url = [NSURL URLWithString:_idStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_WBView loadRequest:request];
    _WBView.delegate = self;
    _WBView.backgroundColor = [UIColor clearColor];
    //webView禁止弹簧效果
    _WBView.scrollView.bounces = NO;
    _WBView.scrollView.showsHorizontalScrollIndicator = NO;
    _WBView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view bringSubviewToFront:_btnView];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
}


//动态获取webView的高度并改变
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    CGFloat height = [[self.WBView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    self.WBView.frame = CGRectMake(self.WBView.frame.origin.x,self.WBView.frame.origin.y, SCREEN_W, height);
//
//}



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

- (IBAction)commentBtnClick:(id)sender {
    
    CommentController * commmentCtr = [[CommentController alloc] init];
    commmentCtr.idStr = _idStr;
    [self presentViewController:commmentCtr animated:YES completion:nil];
    
}

- (IBAction)dismissBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//分享
- (IBAction)shareBtnClick:(id)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54b5dd62fd98c5b69c000d71" shareText:_idStr shareImage: nil shareToSnsNames:@[UMShareToRenren,UMShareToSina,UMShareToQQ] delegate:nil];
    
}

//收藏页面
- (IBAction)storeBtnClick:(id)sender
{

    UIButton * btn = (UIButton *)sender;
    
    _cModel.title = self.titleK;
    _cModel.thumbnail = self.thumbnail;
    _cModel.share_url = self.idStr;
    
    _sqlCreate = @"create table if not exists Store(title text primary key, thumbnail text, share_url text)";
    [_dataBase executeUpdate:_sqlCreate];
    NSString * sqlInsert = @"insert into Store values(?,?,?)";
    BOOL isOK = [_dataBase executeUpdate:sqlInsert,self.titleK,self.thumbnail,self.idStr];
    
    if (isOK) {
        
        _storeBtn.userInteractionEnabled = NO;
    
         [ELNAlerTool showAlertMassgeWithController:self andMessage:@"收藏成功" andInterval:0.8];
        
    }
    else
    {
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"已收藏无须重复收藏" andInterval:0.8];
    }
    
  
    [btn setBackgroundImage:[UIImage imageNamed:@"Dark_Menu_Icon_Collect"] forState:UIControlStateNormal];
}

@end
