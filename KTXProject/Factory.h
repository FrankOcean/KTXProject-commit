//
//  Factory.h
//  LimitFree-爱限免案例
//
//  Created by qianfeng on 16/1/19.
//  Copyright (c) 2016年 CSM. All rights reserved.
//

//通过类名创建控制器
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Factory : NSObject
//类名创建普通控制器

+ (UIViewController *)creatControllerWithName:(NSString *)name;

+ (UIViewController *)creatControllerWithName:(NSString *)name andBackgroudColor:(UIColor *)backgroudColor;
//导航
+ (UINavigationController *)creatNavigationControllerWithRootViewController:(NSString *)name andTitle:(NSString*)title andNormalImage:(NSString *)normalImage andSelectedImage:(NSString *)selcetdImage;
@end
