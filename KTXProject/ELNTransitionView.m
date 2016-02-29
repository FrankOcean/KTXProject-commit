//
//  ELNTransitionView.m
//  CoreAnimation
//
//  Created by Elean on 15/10/23.
//  Copyright (c) 2015年 Elean. All rights reserved.
//

#import "ELNTransitionView.h"

@implementation ELNTransitionView
{
    ELNTransitionAnimationType _animation;
    NSTimeInterval _duration;
    ELNTransitionAnimationTowardType _toward;
    
}
- (instancetype)initWithFrame:(CGRect)frame andTransformAnimation:(ELNTransitionAnimationType)animation andDuration:(NSTimeInterval)duration andToward:(ELNTransitionAnimationTowardType)toward
{
    self = [super initWithFrame:frame];
    if (self) {
        _animation = animation;
        _duration = duration;
        _toward = toward;
        
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self setTransformAnimation:_animation andDuration:_duration andToward:_toward];
    
     [self bringSubviewToFront: self.subviews[0]];
}


@end
