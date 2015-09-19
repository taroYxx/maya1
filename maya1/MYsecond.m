//
//  MYsecond.m
//  maya1
//
//  Created by Taro on 15/8/12.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYsecond.h"

@implementation MYsecond
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)resultWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];}
@end
