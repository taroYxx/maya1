//
//  MYDepartment.m
//  maya1
//
//  Created by Taro on 15/7/27.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYDepartment.h"

@implementation MYDepartment


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)departmentGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (MYDepartment*)sharedata{
    static MYDepartment *department = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        department = [MYDepartment new];
        
    });
    
    return department;
}
@end


