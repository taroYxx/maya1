//
//  MYgroup.h
//  maya1
//
//  Created by Taro on 15/8/8.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYgroup : NSObject
@property (nonatomic , strong)NSArray *cars;
@property (nonatomic , strong)NSArray *childvirtualgroup;
@property (nonatomic , strong)NSString *idvirtualgroup;
@property (nonatomic , strong)NSString *name;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)MYGroupWithDic:(NSDictionary *)dic;
@end
