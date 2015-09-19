//
//  MYCars.h
//  maya1
//
//  Created by Taro on 15/8/1.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYCars : NSObject
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *license;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)CarsGroupWithDic:(NSDictionary *)dic;

@end
