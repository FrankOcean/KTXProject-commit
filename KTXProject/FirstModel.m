//
//  FirstModel.m
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"idStr"}];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
