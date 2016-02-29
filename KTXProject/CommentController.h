//
//  CommentController.h
//  KTXProject
//
//  Created by qianfeng on 16/2/21.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentController : UIViewController

- (IBAction)backBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString * idStr;

@end
