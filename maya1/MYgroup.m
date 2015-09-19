//
//  MYgroup.m
//  maya1
//
//  Created by Taro on 15/8/8.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYgroup.h"

@implementation MYgroup
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)MYGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
@end
