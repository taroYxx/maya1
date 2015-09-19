//
//  MYDepartment.h
//  maya1
//
//  Created by Taro on 15/7/27.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYDepartment : NSObject

@property (nonatomic , strong) NSArray *cars;
@property (nonatomic , strong) NSArray *childdepartmentsinfo;
@property (nonatomic , strong) NSString *coordinate;
@property (nonatomic , strong) NSString *iddepartment;
@property (nonatomic , strong) NSString *name;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)departmentGroupWithDic:(NSDictionary *)dic;
@end
