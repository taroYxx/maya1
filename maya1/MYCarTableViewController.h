//
//  MYCarTableViewController.h
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCarTableViewController : UITableViewController

-(void)getDataFrom:(void(^)(NSMutableArray * array))success;

@end
