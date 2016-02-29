//
//  StoreCell.m
//  KTXProject
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

- (void)setModel:(cellModel *)model
{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    _Lb.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
