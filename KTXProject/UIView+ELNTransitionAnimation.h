//
//  UIView+ELNTransitionAnimation.h
//  CoreAnimation
//
//  Created by Elean on 15/10/23.
//  Copyright (c) 2015年 Elean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (ELNTransitionAnimation)
typedef enum{

    ELNTransitionAnimationTypeCameraIris,
    ELNTransitionAnimationTypeCube,
    ELNTransitionAnimationTypeFade,
    ELNTransitionAnimationTypeMoveIn,
    ELNTransitionAnimationTypeOglFilp,
    ELNTransitionAnimationTypePageCurl,
    ELNTransitionAnimationTypePageUnCurl,
    ELNTransitionAnimationTypePush,
    ELNTransitionAnimationTypeReveal,
    ELNTransitionAnimationTypeRippleEffect,
    ELNTransitionAnimationTypeSuckEffect
    
}ELNTransitionAnimationType;

typedef enum{
    
   ELNTransitionAnimationTowardTypeFromLeft,
   ELNTransitionAnimationTowardTypeFromRight,
   ELNTransitionAnimationTowardTypeFromTop,
   ELNTransitionAnimationTowardTypeFromBottom
    
}ELNTransitionAnimationTowardType;

- (void)setTransformAnimation:(ELNTransitionAnimationType)animation andDuration:(NSTimeInterval)duration andToward:(ELNTransitionAnimationTowardType)toward;

@end
