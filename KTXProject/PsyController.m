//
//  PsyController.m
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "PsyController.h"
#define  URL_PSY @"http://news-at.zhihu.com/api/4/theme/13"

@interface PsyController ()

@end

@implementation PsyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"心理学";
    [self setMyUrl];
    [self loadThisPageData];
    
    // Do any additional setup after loading the view.
}

- (void)setMyUrl
{
    self.url = [NSString stringWithFormat:URL_PSY];
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
