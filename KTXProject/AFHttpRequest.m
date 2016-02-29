//
//  AFHttpRequest.m
//  KitchenProject
//
//  Created by qianfeng on 16/1/25.
//  Copyright © 2016年 普阳. All rights reserved.
//

#import "AFHttpRequest.h"

@implementation AFHttpRequest

+ (void)GET:(NSString *)url andSuccess:(SuccessBlock)success andFailed:(FailedBlock)failed
{
    AFHttpRequest * request = [[AFHttpRequest alloc] init];
    
    request.sblock = success;
    request.fblock = failed;
    
    request.manager = [AFHTTPRequestOperationManager manager];
    request.manager.responseSerializer = [AFHTTPResponseSerializer serializer];//关闭自动解析数据格式的功能
    [request.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        request.sblock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        request.fblock(error.localizedDescription);
    }];
    
}

+ (void)POST:(NSString *)url andParams:(NSDictionary *)param andSuccess:(SuccessBlock)success andFailed:(FailedBlock)failed
{
    AFHttpRequest * request = [[AFHttpRequest alloc] init];
    
    request.sblock = success;
    request.fblock = failed;
    
    request.manager = [AFHTTPRequestOperationManager manager];
    request.manager.responseSerializer = [AFHTTPResponseSerializer serializer];//关闭自动解析数据格式的功能
    [request.manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        request.sblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        request.fblock(error.localizedDescription);
    }];

    
}

@end
