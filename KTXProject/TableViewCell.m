//
//  TableViewCell.m
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TableViewCell

- (void)setModel:(cellModel *)model
{
    self.nameLb.text = model.title;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
