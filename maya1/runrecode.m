//
//  runrecode.m
//  maya1
//
//  Created by Taro on 15/8/17.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "runrecode.h"

@implementation runrecode
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)carRecodeWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
@end
