//
//  FirstModel.h
//  KTXProject
//
//  Created by qianfeng on 16/2/17.
//  Copyright © 2016年 PY. All rights reserved.
//

#import "JSONModel.h"

@interface FirstModel : NSObject

@property (nonatomic, copy) NSString * idStr;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * editImgV;
@property (nonatomic, copy) NSString * name;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
