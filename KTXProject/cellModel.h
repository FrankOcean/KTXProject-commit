//
//  cellModel.h
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cellModel : NSObject

@property (nonatomic, copy) NSString * thumbnail;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * share_url;
@property (nonatomic, copy) NSString * date;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
