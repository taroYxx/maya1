//
//  MYchilddepartment.h
//  maya1
//
//  Created by Taro on 15/8/1.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYchilddepartment : NSObject



@property (nonatomic , strong) NSArray *cars;
@property (nonatomic , strong) NSArray *childdepartmentsinfo;
@property (nonatomic , strong) NSString *coordinate;
@property (nonatomic , strong) NSString *iddepartment;
@property (nonatomic , strong) NSString *name;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)ChildDepartmentGroupWithDic:(NSDictionary *)dic;

@end
