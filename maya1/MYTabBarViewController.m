//
//  MYTabBarViewController.m
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYTabBarViewController.h"
#import "MYCarTableViewController.h"
#import "MYDepartTableViewController.h"
#import "MYMapViewController.h"
#import "MYnoticeTableViewController.h"
#import "MYGroupTableViewController.h"
//#import "MYsegmentViewController.h"


@interface MYTabBarViewController ()

@end

@implementation MYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MYMapViewController *map = [[MYMapViewController alloc]init];
    [self addChildVc:map title:@"map" image:@"map1" selectedImage:@"map1"];
    
    MYCarTableViewController *car = [[MYCarTableViewController alloc] init];
    [self addChildVc:car title:@"car" image:@"car1" selectedImage:@"car1"];
    
//    MYsegmentViewController *segment = [[MYsegmentViewController alloc] init];
//    [self addChildVc:segment title:@"depart" image:@"depart1" selectedImage:@"depart1"];
    MYDepartTableViewController *depart = [[MYDepartTableViewController alloc]init];
    [self addChildVc:depart title:@"department" image:@"depart1" selectedImage:@"depart1"];
    
    MYGroupTableViewController *group = [[MYGroupTableViewController alloc] init];
    [self addChildVc:group title:@"group" image:@"group" selectedImage:@"group"];
    
    
    
    MYnoticeTableViewController *notice = [[ MYnoticeTableViewController alloc]init];
    [self addChildVc:notice title:@"notice" image:@"notice" selectedImage:@"notice"];

}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字和图片
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
   
    [self addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
