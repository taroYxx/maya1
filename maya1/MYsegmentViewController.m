//
//  MYsegmentViewController.m
//  maya1
//
//  Created by Taro on 15/8/8.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYsegmentViewController.h"

@interface MYsegmentViewController ()

@end

@implementation MYsegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [segment insertSegmentWithTitle:@"department" atIndex:0 animated:NO];
    [segment insertSegmentWithTitle:@"group" atIndex:1 animated:NO];
    [segment addTarget:self action:@selector(segmentDidChange:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segment;
}
- (void)segmentDidChange:(id)sender{
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segment = sender;
        if (0 == segment.selectedSegmentIndex) {
       
            UITableView *depart = [[UITableView alloc] init];
            depart.frame = CGRectMake(0, self.navigationItem.titleView.frame.size.height, 375, self.view.frame.size.height);
//            depart.backgroundColor = [UIColor yellowColor];
            [self.view addSubview:depart];
            
        }else{
            
//                        MYGroupViewController *group = [[MYGroupViewController alloc] init];
                        UITableView *gruop = [[UITableView alloc] init];
            gruop.frame = CGRectMake(0, self.navigationItem.titleView.frame.size.height, 375, self.view.frame.size.height);
                        gruop.backgroundColor = [UIColor yellowColor];
                        [self.view addSubview:gruop];
        }
    }
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
