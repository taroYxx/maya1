//
//  MYcarstopViewController.h
//  maya1
//
//  Created by Taro on 15/8/7.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYcarstopViewController : UIViewController
@property (nonatomic , strong) NSString *carid;
@property (nonatomic , strong) UITextField *starttime;
@property (nonatomic , strong) UITextField *endtime;
@property (nonatomic,retain) UIToolbar * accessoryView;
@property (nonatomic,retain) UIDatePicker *customInput;

@property (nonatomic , strong) NSMutableArray *coordinate;
@property (nonatomic , strong) NSMutableArray *STime;
@property (nonatomic , strong) NSMutableArray *ETime;
-(void)OnTapDone:(id) sender;
- (void)dateChanged:(id)sender;@end
