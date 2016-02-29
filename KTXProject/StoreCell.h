//
//  StoreCell.h
//  KTXProject
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cellModel.h"
#import "UIImageView+WebCache.h"

@interface StoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Lb;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (nonatomic, strong) cellModel * model;
@end
