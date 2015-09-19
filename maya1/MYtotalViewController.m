//
//  MYtotalViewController.m
//  maya1
//
//  Created by Taro on 15/8/13.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYtotalViewController.h"
#import "AFNetworking.h"
@interface MYtotalViewController ()
@property (nonatomic , strong) NSString *totalfueluse;
@property (nonatomic , strong) NSString *totalmileage;

@property (nonatomic , strong) UITextField *eightline;
@property (nonatomic , strong) UITextField *nineline;
@property (nonatomic , strong) UITextField *tenline;
@property (nonatomic , strong) UITextField *elevenline;
@property (nonatomic , strong) UITextField *twelveline;

@end

@implementation MYtotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(30, 50,350, 30)];
    tip.text = @"Please enter the month you need to query.";
    [self.view addSubview:tip];
    
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 30)];
    [title setText:@"Time"];
    [title setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:title];
    
    self.picktime = [[UITextField alloc] initWithFrame:CGRectMake(110, 100, 250, 30)];
    self.picktime.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.picktime];
    {// datepicker
        self.accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        UIButton* btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDone.frame = CGRectMake(self.accessoryView.frame.size.width-70, 0, 60, 30);
        [btnDone setBackgroundColor:[UIColor blueColor]];
        [btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnDone.titleLabel setTextColor:[UIColor whiteColor]];
        [self.accessoryView addSubview:btnDone];
        [btnDone addTarget:self action:@selector(OnTapDone:) forControlEvents:UIControlEventTouchUpInside];
        
        self.customInput = [[UIDatePicker alloc] init];
        self.customInput.datePickerMode = UIDatePickerModeDate;
        [self.customInput addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    
    
    self.picktime.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.picktime.layer.borderWidth = 1.0;
    self.picktime.layer.borderColor = [UIColor colorWithWhite:209.0 / 255.0 alpha:1.0].CGColor;
    self.picktime.backgroundColor = [UIColor whiteColor];
    self.picktime.inputAccessoryView = self.accessoryView;
    self.picktime.inputView = self.customInput;
//    self.picktime.placeholder = @"Please enter a month to query";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"ok" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getdata) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 150, 175, 30);
    [self.view addSubview:btn];
    
    
    
    _eightline = [[UITextField alloc] initWithFrame:CGRectMake(230, 280, 130, 40)];
    _eightline.layer.borderColor = [[UIColor grayColor]CGColor];
    _eightline.layer.borderWidth = 2;
    _eightline.adjustsFontSizeToFitWidth = YES;
    [_eightline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *eightlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 220, 40)];
    eightlag.layer.borderColor = [[UIColor grayColor]CGColor];
    eightlag.layer.borderWidth = 2;
    eightlag.text = @"totalFuelUse";
    [eightlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_eightline];
    [self.view addSubview:eightlag];
    [eightlag setTextAlignment:  NSTextAlignmentCenter];
    
    _nineline = [[UITextField alloc] initWithFrame:CGRectMake(230, 320, 130, 40)];
    _nineline.layer.borderColor = [[UIColor grayColor]CGColor];
    _nineline.layer.borderWidth = 2;
    [_nineline setTextAlignment:  NSTextAlignmentCenter];
    _nineline.adjustsFontSizeToFitWidth = YES;
    UILabel *ninelag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 220, 40)];
    ninelag.layer.borderColor = [[UIColor grayColor]CGColor];
    ninelag.layer.borderWidth = 2;
    ninelag.text = @"totalMileage";
    [ninelag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_nineline];
    [self.view addSubview:ninelag];
    [ninelag setTextAlignment:  NSTextAlignmentCenter];
    
    _tenline = [[UITextField alloc] initWithFrame:CGRectMake(230, 360, 130, 40)];
    _tenline.layer.borderColor = [[UIColor grayColor]CGColor];
    _tenline.layer.borderWidth = 2;
    [_tenline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *tenlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 220, 40)];
    tenlag.layer.borderColor = [[UIColor grayColor]CGColor];
    tenlag.layer.borderWidth = 2;
//    tenlag.text = @"Nick Name";
    [tenlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_tenline];
    [self.view addSubview:tenlag];
    [tenlag setTextAlignment:  NSTextAlignmentCenter];
    
    _elevenline = [[UITextField alloc] initWithFrame:CGRectMake(230, 400, 130, 40)];
    _elevenline.layer.borderColor = [[UIColor grayColor]CGColor];
    _elevenline.layer.borderWidth = 2;
    [_elevenline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *elevenlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 400, 220, 40)];
    elevenlag.layer.borderColor = [[UIColor grayColor]CGColor];
    elevenlag.layer.borderWidth = 2;
//    elevenlag.text = @"purchase-Time";
    _elevenline.adjustsFontSizeToFitWidth = YES;
    [elevenlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_elevenline];
    [self.view addSubview:elevenlag];
    [elevenlag setTextAlignment:  NSTextAlignmentCenter];
    
    _twelveline = [[UITextField alloc] initWithFrame:CGRectMake(230, 440, 130, 40)];
    _twelveline.layer.borderColor = [[UIColor grayColor]CGColor];
    _twelveline.layer.borderWidth = 2;
    [_twelveline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *twelvelag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 440, 220, 40)];
    twelvelag.layer.borderColor = [[UIColor grayColor]CGColor];
    twelvelag.layer.borderWidth = 2;
//    twelvelag.text = @"type";
    [twelvelag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_twelveline];
    [self.view addSubview:twelvelag];
    [twelvelag setTextAlignment:  NSTextAlignmentCenter];
    
}

- (void)getdata{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"type": _posttype,
                                         @"id": @[
                                                 _iddepartment
                                                 ],
                                         @"date": self.picktime.text
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://www.rebornzero.com:8080/maya/demo/statistics.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                       
                        NSLog(@"HTTP Response Body: %@", responseObject[@"data"]);
      
        _totalfueluse = responseObject[@"data"][0][@"totalFuelUse"];
        _totalmileage = responseObject[@"data"][0][@"totalMileage"];
     
        self.eightline.text = [NSString stringWithFormat:@"%@", _totalfueluse];
        self.nineline.text = [NSString stringWithFormat:@"%@", _totalmileage];
//        UILabel *result = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 335, 50)];
//        result.text = [NSString stringWithFormat:@"total fuel use: %@    total mileage:  %@",_totalfueluse,_totalmileage];
//        [result setTextAlignment:NSTextAlignmentCenter];
//        [self.view addSubview:result];
 
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
        
}


-(void)OnTapDone:(id) sender{
    [self.picktime resignFirstResponder];
//    if ( [self.starttime isFirstResponder] ) {
//        [self.starttime resignFirstResponder];
//    } else if ( [self.endtime isFirstResponder] ) {
//        [self.endtime resignFirstResponder];
//    }
    
}

-(void)dateChanged:(id) sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    self.picktime.text = [NSString stringWithFormat:@"%@",[df stringFromDate:picker.date]];
//    if ( [self.starttime isFirstResponder] ) {
//        self.starttime.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];
//    } else if ( [self.endtime isFirstResponder] ) {
//        self.endtime.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];
//    }
    
    
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
