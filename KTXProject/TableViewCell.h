//
//  TableViewCell.h
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cellModel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (nonatomic, strong) cellModel * model;
@end
