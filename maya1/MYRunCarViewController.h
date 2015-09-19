//
//  MYRunCarViewController.h
//  maya1
//
//  Created by Taro on 15/8/6.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYRunCarViewController : UIViewController
@property (nonatomic , strong) NSString *carid;
-(void)OnTapDone:(id) sender;
- (void)dateChanged:(id)sender;
@end
