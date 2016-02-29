//
//  Factory.m
//  LimitFree-爱限免案例
//
//  Created by qianfeng on 16/1/19.
//  Copyright (c) 2016年 CSM. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+ (UIViewController *)creatControllerWithName:(NSString *)name{
    Class class = NSClassFromString(name);
    return [[class alloc] init];
}


//创建控制器带背景颜色
+ (UIViewController *)creatControllerWithName:(NSString *)name andBackgroudColor:(UIColor *)backgroudColor{
    UIViewController *ctrView = [self creatControllerWithName:name];
    ctrView.view.backgroundColor = [UIColor whiteColor];
    return ctrView;
}


//导航控制器 创建芬兰的导航控制器
+ (UINavigationController *)creatNavigationControllerWithRootViewController:(NSString *)name andTitle:(NSString*)title andNormalImage:(NSString *)normalImage andSelectedImage:(NSString *)selcetdImage{
    //name : 导航控制器的跟控制器名
    //title 芬兰控制器对应的item的title 根控制器UINavigationItem的title
    //normalImage
    //selcetdImage
    
    //1.chua
    UIViewController *rootView = [self creatControllerWithName:name];
    rootView.navigationItem.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootView];
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:normalImage] selectedImage:[UIImage imageNamed:selcetdImage]];
    
    return nav;
}

@end
