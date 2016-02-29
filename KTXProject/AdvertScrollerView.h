//
//  AdvertScrollerView.h
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol returnBaseVCDelegate <NSObject>

- (void)tapPicIndexID:(NSString *)artID;

@end

@interface AdvertScrollerView : UIView

@property (nonatomic,assign) id<returnBaseVCDelegate>delegate;
@property (nonatomic, strong) UIScrollView * adcScrollView;
@property (nonatomic, strong) NSMutableArray * dataArr;

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)array;

@end
