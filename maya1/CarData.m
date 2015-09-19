//
//  CarData.m
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "CarData.h"

@implementation CarData

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary: dic];
    }
    return self;
}
+ (instancetype)carGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (CarData*)sharedata{
    static CarData *cardata = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        cardata = [CarData new];
        
    });
   
    return cardata;
}


 



@end
