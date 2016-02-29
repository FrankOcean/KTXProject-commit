//
//  CommentModel.h
//  KTXProject
//
//  Created by qianfeng on 16/2/21.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * likes;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * content;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
