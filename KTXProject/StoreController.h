//
//  StoreController.h
//  KTXProject
//
//  Created by qianfeng on 16/2/20.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cellModel.h"
#import "StoreCell.h"

@interface StoreController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *storeVC;

@property (nonatomic, copy) NSString * storeUrl;

@property (nonatomic, strong) cellModel * cModel;

@end
