//
//  AdvertScrollerView.m
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "AdvertScrollerView.h"
#import "ScrollModel.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "NSString+URLEncoding.h"
#import "cellModel.h"

#define SCREEN_W  [UIScreen mainScreen].bounds.size.width

@implementation AdvertScrollerView

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithArray:array];
        self.adcScrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.adcScrollView.bounces = NO;
        self.adcScrollView.pagingEnabled = YES;
        self.adcScrollView.showsHorizontalScrollIndicator = NO;
        self.adcScrollView.contentSize = CGSizeMake(_dataArr.count * SCREEN_W, frame.size.height);
        [self addSubview:self.adcScrollView];
        
        for (int i = 0; i < self.dataArr.count; i++) {
            ScrollModel * model = array[i];
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * i, 0, SCREEN_W, frame.size.height)];
            NSString * url = [model.img URLDecodedString];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Account_Avatar@2x.png"]];
            [self.adcScrollView addSubview:imageView];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, SCREEN_W, 20)];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.text = model.name;
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.font = [UIFont systemFontOfSize:15];
            [imageView addSubview:nameLabel];
            imageView.userInteractionEnabled = NO;  //BaseViewController 图片没有点击事件
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
            imageView.tag = 100 + i;
            [imageView addGestureRecognizer:tap];
        }
        
    }
    return self;
}

- (void)tapEvent:(UIGestureRecognizer *)tap
{
    UIImageView * imageView = (UIImageView *)tap.view;
    ScrollModel * model = _dataArr[imageView.tag - 100];
    [self.delegate tapPicIndexID:model.article_id];
    
}


@end
