//
//  MYGroupName.h
//  maya1
//
//  Created by Taro on 15/8/12.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYGroupName : NSObject
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSNumber *id;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)CarsGroupWithDic:(NSDictionary *)dic;
@end
