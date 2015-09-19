//
//  MYsecond.h
//  maya1
//
//  Created by Taro on 15/8/12.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYsecond : NSObject
@property (nonatomic , strong) NSString *idcar;
@property (nonatomic , strong) NSString *license;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)resultWithDic:(NSDictionary *)dic;
@end
