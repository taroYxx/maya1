//
//  MYStatueViewController.h
//  maya1
//
//  Created by Taro on 15/8/6.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYStatueViewController : UIViewController

@property (nonatomic , assign) NSString *carid;
@property (nonatomic , strong) NSString *license;
-(void)getDataFrom:(void(^)(NSMutableDictionary * array))success;

@end
