//
//  MYchilddepartment.m
//  maya1
//
//  Created by Taro on 15/8/1.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYchilddepartment.h"

@implementation MYchilddepartment


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)ChildDepartmentGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (MYchilddepartment*)sharedata{
    static MYchilddepartment *department = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
         department = [MYchilddepartment new];
        
    });
    
    return department;
}
@end
