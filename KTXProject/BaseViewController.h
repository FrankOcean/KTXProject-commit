//
//  BaseViewController.h
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "cellModel.h"

typedef void (^modelBlock)(cellModel * model);

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * advArr;
@property (nonatomic, copy) NSString * url;
@property (nonatomic,assign) NSUInteger page;

- (void)setMyUrl;
- (void)loadThisPageData;
- (void)loadMoreData;

@property (nonatomic, copy) modelBlock block;

@end
