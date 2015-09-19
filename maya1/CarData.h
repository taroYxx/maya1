//
//  CarData.h
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarData : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *license;
@property (nonatomic, copy) NSString *speed;
@property (nonatomic, copy) NSString *coordinate;
@property (nonatomic, copy) NSString *driver;
@property (nonatomic, copy) NSNumber *status;



- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)carGroupWithDic:(NSDictionary *)dic;

+ (CarData*)sharedata;
@end
