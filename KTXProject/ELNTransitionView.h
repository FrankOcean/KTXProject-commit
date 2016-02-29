//
//  ELNTransitionView.h
//  CoreAnimation
//
//  Created by Elean on 15/10/23.
//  Copyright (c) 2015年 Elean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ELNTransitionAnimation.h"
@interface ELNTransitionView : UIView
- (instancetype)initWithFrame:(CGRect)frame andTransformAnimation:(ELNTransitionAnimationType)animation andDuration:(NSTimeInterval)duration andToward:(ELNTransitionAnimationTowardType)toward;


@end
