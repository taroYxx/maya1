//
//  MYSearchBar.m
//  maya1
//
//  Created by Taro on 15/7/22.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYSearchBar.h"

@implementation MYSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [ super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15 ];
        self.placeholder = @"请输入搜索条件";
//        self.background = [UIImage imageNamed:@"car1"];
        UIImageView *searchIcon = [[UIImageView alloc] init];
//        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        CGRect frame = self.frame;
        frame.size.width = 30.0;
        frame.size.height = 30.0;
        searchIcon.contentMode = UIViewContentModeCenter; //居中
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        
    }
    return self;
}


+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
