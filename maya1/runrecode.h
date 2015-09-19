//
//  runrecode.h
//  maya1
//
//  Created by Taro on 15/8/17.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface runrecode : NSObject
@property (nonatomic , strong) NSString *endcoordinate;
@property (nonatomic , strong) NSString *startcoordinate;
@property (nonatomic , strong) NSString *id;
@property (nonatomic , strong) NSString *endtime;
@property (nonatomic , strong) NSString *startime;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)carRecodeWithDic:(NSDictionary *)dic;
@end


