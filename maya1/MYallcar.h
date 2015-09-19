//
//  MYallcar.h
//  maya1
//
//  Created by Taro on 15/8/18.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYallcar : NSObject

@property (nonatomic , strong) NSString *coordinate;
@property (nonatomic , strong) NSString *driver;
@property (nonatomic , strong) NSString *license;
@property (nonatomic , strong) NSString *speed;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSString *id;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)CarsGroupWithDic:(NSDictionary *)dic;

@end
