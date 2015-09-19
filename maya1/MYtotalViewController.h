//
//  MYtotalViewController.h
//  maya1
//
//  Created by Taro on 15/8/13.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYtotalViewController : UIViewController
@property (nonatomic , strong) NSString *iddepartment;
@property (nonatomic , strong) UITextField *picktime;
@property (nonatomic,retain) UIToolbar * accessoryView;
@property (nonatomic,retain) UIDatePicker *customInput;
@property (nonatomic , strong) NSNumber *posttype;

@end
