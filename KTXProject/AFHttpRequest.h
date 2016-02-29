//
//  AFHttpRequest.h
//  KitchenProject
//
//  Created by qianfeng on 16/1/25.
//  Copyright © 2016年 普阳. All rights reserved.
//
#import "AFNetworking.h"
#import <Foundation/Foundation.h>
//声明block
typedef void (^SuccessBlock)(NSData * data);
typedef void (^FailedBlock)(NSString * failedReason);

@interface AFHttpRequest : NSObject

@property (copy, nonatomic) SuccessBlock sblock;
@property (copy, nonatomic) FailedBlock fblock;

@property (nonatomic, strong) AFHTTPRequestOperationManager * manager;

//声明加载网络数据方法
+ (void)GET:(NSString *)url andSuccess:(SuccessBlock)success andFailed:(FailedBlock)failed;

+ (void)POST:(NSString *)url andParams:(NSDictionary *)param andSuccess:(SuccessBlock)success andFailed:(FailedBlock)failed;

@end
