//
//  UIView+ELNTransitionAnimation.m
//  CoreAnimation
//
//  Created by Elean on 15/10/23.
//  Copyright (c) 2015年 Elean. All rights reserved.
//

#import "UIView+ELNTransitionAnimation.h"

@implementation UIView (ELNTransitionAnimation)
- (void)setTransformAnimation:(ELNTransitionAnimationType)animation andDuration:(NSTimeInterval)duration andToward:(ELNTransitionAnimationTowardType)toward{

    NSArray * array = @[@"cameraIris", @"cube", @"fade", @"moveIn", @"oglFlip", @"pageCurl", @"pageUnCurl", @"push", @"reveal", @"rippleEffect", @"suckEffect"];

    
    NSArray * towards = @[@"fromLeft", @"fromRight", @"fromTop", @"fromBottom"];
    
    //creat a CATransition object
    CATransition * transiton = [CATransition animation];
    
    //set time
    transiton.duration = duration;
    NSLog(@"%@",array[animation]);
    
    //set animation style
    transiton.type = array[animation];
    
    //set direction
    transiton.subtype = towards[toward];
    
    //add to layer
    [self.layer addAnimation:transiton forKey:nil];
    
}
@end
