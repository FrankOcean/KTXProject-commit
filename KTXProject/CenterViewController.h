//
//  CenterViewController.h
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;
@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (nonatomic,strong) UILabel * label;


@end
