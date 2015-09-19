//
//  AppDelegate.m
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "AppDelegate.h"
#import "MYTabBarViewController.h"
#import "MYloginViewController.h"
#import <Foundation/Foundation.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] init];
    self.window = window;
    
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMainBord) name:HXDChangeMainNotification object:nil];
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [doc stringByAppendingPathComponent:@"account"];
//    NSString *string =
    NSString *home = NSHomeDirectory();
    NSString *path = [home stringByAppendingPathComponent:@"Documents"];
    NSString *filepath = [path stringByAppendingPathComponent:@"data.plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filepath];


    
    if (!data) {
        MYloginViewController *login = [[MYloginViewController alloc] init];
        self.window.rootViewController = login;
       
        
    }
    else
    {
        MYTabBarViewController *tab = [[MYTabBarViewController alloc] init];
        self.window.rootViewController = tab;
    
    }



//    self.window.rootViewController = [[MYloginViewController alloc] init];
    
//    [self changeMainBord];
   
    
        
    return YES;
}

//-(void)changeMainBord{
//    if ([UserDefaults valueForKey:mNo111]) {
//        MYloginViewController *login = [[MYloginViewController alloc] init];
//        self.window.rootViewController = login;
//        NSLog(@"11");
//       
//    }
//    else
//    {
//        MYTabBarViewController *tab = [[MYTabBarViewController alloc] init];
//        self.window.rootViewController = tab;
//        NSLog(@"222");
//    }
//    
//}



@end
