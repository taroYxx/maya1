//
//  MYCars.m
//  maya1
//
//  Created by Taro on 15/8/1.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYCars.h"

@implementation MYCars


- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)CarsGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (MYCars*)sharedata{
    static MYCars *department = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        department = [MYCars new];
        
    });
    
    return department;
}

@end
