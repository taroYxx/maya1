//
//  MYnoticedetailViewController.m
//  maya1
//
//  Created by Taro on 15/8/10.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYnoticedetailViewController.h"
#import "AFNetworking.h"

@interface MYnoticedetailViewController ()

@end

@implementation MYnoticedetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *firstline = [[UILabel alloc] initWithFrame:CGRectMake(260, 100, 100, 50)];
    firstline.layer.borderColor = [[UIColor grayColor]CGColor];
    firstline.layer.borderWidth = 2;
    [firstline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *firstlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 250, 50)];
    firstlag.layer.borderColor = [[UIColor grayColor]CGColor];
    firstlag.layer.borderWidth = 2;
    firstlag.text = @"data";
    firstlag.adjustsFontSizeToFitWidth = YES;
    [firstlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:firstline];
    [self.view addSubview:firstlag];
    
    UILabel *secondline = [[UILabel alloc] initWithFrame:CGRectMake(260, 150, 100, 50)];
    secondline.layer.borderColor = [[UIColor grayColor]CGColor];
    secondline.layer.borderWidth = 2;
    [secondline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *secondlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 250, 50)];
    secondlag.layer.borderColor = [[UIColor grayColor]CGColor];
    secondlag.layer.borderWidth = 2;
    secondlag.text = @"id ";
    [secondlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:secondline];
    [self.view addSubview:secondlag];
    
    UILabel *thirdline = [[UILabel alloc] initWithFrame:CGRectMake(260, 200, 100, 50)];
    thirdline.layer.borderColor = [[UIColor grayColor]CGColor];
    thirdline.layer.borderWidth = 2;
    [thirdline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *thirdlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 250, 50)];
    thirdlag.layer.borderColor = [[UIColor grayColor]CGColor];
    thirdlag.layer.borderWidth = 2;
    thirdlag.text = @"idwarning";
    [thirdlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:thirdline];
    [self.view addSubview:thirdlag];
    
    UILabel *fouthline = [[UILabel alloc] initWithFrame:CGRectMake(260,250, 100, 50)];
    fouthline.layer.borderColor = [[UIColor grayColor]CGColor];
    fouthline.layer.borderWidth = 2;
    [fouthline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *fouthlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 250, 50)];
    fouthlag.layer.borderColor = [[UIColor grayColor]CGColor];
    fouthlag.layer.borderWidth = 2;
    fouthlag.text = @"level";
    [self.view addSubview:fouthline];
    [self.view addSubview:fouthlag];
    [fouthlag setTextAlignment:  NSTextAlignmentCenter];
    
    UILabel *fifthline = [[UILabel alloc] initWithFrame:CGRectMake(260, 300, 100, 50)];
    fifthline.layer.borderColor = [[UIColor grayColor]CGColor];
    fifthline.layer.borderWidth = 2;
    [fifthline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *fifthlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 250, 50)];
    fifthlag.layer.borderColor = [[UIColor grayColor]CGColor];
    fifthlag.layer.borderWidth = 2;
    fifthlag.text = @"license";
    [fifthlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:fifthline];
    [self.view addSubview:fifthlag];
    
    UILabel *sixline = [[UILabel alloc] initWithFrame:CGRectMake(260, 350, 100, 50)];
    sixline.layer.borderColor = [[UIColor grayColor]CGColor];
    sixline.layer.borderWidth = 2;
    [sixline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *sixlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 350, 250, 50)];
    sixlag.layer.borderColor = [[UIColor grayColor]CGColor];
    sixlag.layer.borderWidth = 2;
    sixlag.text = @"receivedUser";
    [sixlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:sixline];
    [self.view addSubview:sixlag];
    
    
//    NSLog(@"%@--%@--%@--%@--%@--%@",_data,_idwarning,_idcar,)
    firstline.text = _data;
    secondline.text = [NSString stringWithFormat:@"%@",_idcar];
    thirdline.text = [NSString stringWithFormat:@"%@",_idwarning];
    fouthline.text = [NSString stringWithFormat:@"%@",_level];
    fifthline.text = _license;
    sixline.text = _receivedUser;
    
    
    UIButton *carrun = [[UIButton alloc] initWithFrame:CGRectMake(100, 450, 175, 50)];
    [carrun setTitle:@"read" forState:UIControlStateNormal];
    carrun.backgroundColor = [UIColor blackColor];
    [carrun addTarget:self action:@selector(readedNotice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carrun];
    
}


- (void)readedNotice{
//    NSLog(@"sss");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idwarning": _idwarning
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/warning/readwarning.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                                             NSLog(@"HTTP Response Body: %@", responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
    [self.navigationController popViewControllerAnimated:YES];
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
