//
//  MYnotice.m
//  maya1
//
//  Created by Taro on 15/8/10.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYnotice.h"

@implementation MYnotice


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)noticeGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
