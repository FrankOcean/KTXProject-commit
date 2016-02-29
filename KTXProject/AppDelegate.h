//
//  AppDelegate.h
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) LeftSlideViewController * LeftSlideVC;
@property (nonatomic, strong) UINavigationController *mainNavigationController;

@end

