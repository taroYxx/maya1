//
//  MYnotice.h
//  maya1
//
//  Created by Taro on 15/8/10.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYnotice : NSObject
@property (nonatomic , strong) NSString *data;
@property (nonatomic , strong) NSString *idcar;
@property (nonatomic , strong) NSString *idwarning;
@property (nonatomic , strong) NSString *level;
@property (nonatomic , strong) NSString *license;
@property (nonatomic , strong) NSString *receivedUser;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)noticeGroupWithDic:(NSDictionary *)dic;
@end
