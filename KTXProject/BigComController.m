//
//  BigComController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "BigComController.h"
#define URL_BIGCOMPANY @"http://news-at.zhihu.com/api/4/theme/5"

@interface BigComController ()

@end

@implementation BigComController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商业世界";
    // Do any additional setup after loading the view.
    [self setMyUrl];
    [self loadThisPageData];
}

- (void)setMyUrl
{
    self.url = [NSString stringWithFormat:URL_BIGCOMPANY];
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
