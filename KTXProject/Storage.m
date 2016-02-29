//
//  Storage.m
//  LimitFree-爱限免案例
//
//  Created by qianfeng on 16/1/19.
//  Copyright (c) 2016年 CSM. All rights reserved.
//

#import "Storage.h"
#define GUIDANCE_KEY @"LIMITE_FREE_GUIDANCE"
@implementation Storage

+ (BOOL)setGuidancevalue:(BOOL)value{
    NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
    [userDf setBool:value forKey:GUIDANCE_KEY];
    
    return [userDf synchronize];
}


+ (BOOL)getGuidancevalue{
    NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
    return [userDf boolForKey:GUIDANCE_KEY];
}

@end
