//
//  MYCarDocViewController.m
//  maya1
//
//  Created by Taro on 15/8/7.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYCarDocViewController.h"
#import "AFNetworking.h"

@interface MYCarDocViewController ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *firstline;
@property (nonatomic , strong) UITextField *secondline;
@property (nonatomic , strong) UITextField *thirdline;
@property (nonatomic , strong) UITextField *fouthline;
@property (nonatomic , strong) UITextField *fifthline;
@property (nonatomic , strong) UITextField *sixthline;
@property (nonatomic , strong) UITextField *seventhline;
@property (nonatomic , strong) UITextField *eightline;
@property (nonatomic , strong) UITextField *nineline;
@property (nonatomic , strong) UITextField *tenline;
@property (nonatomic , strong) UITextField *elevenline;
@property (nonatomic , strong) UITextField *twelveline;

@property (nonatomic , strong) UIButton *ensure;

@end

@implementation MYCarDocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = true;
    self.navigationItem.title = @"Car Doc";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _firstline = [[UITextField alloc] initWithFrame:CGRectMake(230, 100, 130, 40)];
    _firstline.layer.borderColor = [[UIColor grayColor]CGColor];
    _firstline.layer.borderWidth = 2;
    _firstline.adjustsFontSizeToFitWidth = YES;
    [_firstline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *firstlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 220, 40)];
    firstlag.layer.borderColor = [[UIColor grayColor]CGColor];
    firstlag.layer.borderWidth = 2;
    firstlag.text = @"annual Inspection";
    firstlag.adjustsFontSizeToFitWidth = YES;
    [firstlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_firstline];
    [self.view addSubview:firstlag];
    
    _secondline = [[UITextField alloc] initWithFrame:CGRectMake(230, 140, 130, 40)];
    _secondline.layer.borderColor = [[UIColor grayColor]CGColor];
    _secondline.layer.borderWidth = 2;
    [_secondline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *secondlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 220, 40)];
    secondlag.layer.borderColor = [[UIColor grayColor]CGColor];
    secondlag.layer.borderWidth = 2;
    secondlag.text = @"brand";
    [secondlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_secondline];
    [self.view addSubview:secondlag];
    
    _thirdline = [[UITextField alloc] initWithFrame:CGRectMake(230, 180, 130, 40)];
    _thirdline.layer.borderColor = [[UIColor grayColor]CGColor];
    _thirdline.layer.borderWidth = 2;
    _thirdline.adjustsFontSizeToFitWidth = YES;
    [_thirdline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *thirdlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 220, 40)];
    thirdlag.layer.borderColor = [[UIColor grayColor]CGColor];
    thirdlag.layer.borderWidth = 2;
    thirdlag.text = @"department";
    [thirdlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_thirdline];
    [self.view addSubview:thirdlag];
    
    _fouthline = [[UITextField alloc] initWithFrame:CGRectMake(230,220, 130, 40)];
    _fouthline.layer.borderColor = [[UIColor grayColor]CGColor];
    _fouthline.layer.borderWidth = 2;
    [_fouthline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *fouthlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 220, 40)];
    fouthlag.layer.borderColor = [[UIColor grayColor]CGColor];
    fouthlag.layer.borderWidth = 2;
    fouthlag.text =@"driver";
    [self.view addSubview:_fouthline];
    [self.view addSubview:fouthlag];
    [fouthlag setTextAlignment:  NSTextAlignmentCenter];
    
    _fifthline = [[UITextField alloc] initWithFrame:CGRectMake(230, 260, 130, 40)];
    _fifthline.layer.borderColor = [[UIColor grayColor]CGColor];
    _fifthline.layer.borderWidth = 2;
    _fifthline.adjustsFontSizeToFitWidth = YES;
    [_fifthline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *fifthlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 220, 40)];
    fifthlag.layer.borderColor = [[UIColor grayColor]CGColor];
    fifthlag.layer.borderWidth = 2;
    fifthlag.text = @"department-ID";
    [firstlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_fifthline];
    [self.view addSubview:fifthlag];
    [fifthlag setTextAlignment:  NSTextAlignmentCenter];
    
    _sixthline = [[UITextField alloc] initWithFrame:CGRectMake(230, 300, 130, 40)];
    _sixthline.layer.borderColor = [[UIColor grayColor]CGColor];
    _sixthline.layer.borderWidth = 2;
    _sixthline.adjustsFontSizeToFitWidth = YES;
    [_sixthline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *sixthlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 220, 40)];
    sixthlag.layer.borderColor = [[UIColor grayColor]CGColor];
    sixthlag.layer.borderWidth = 2;
    sixthlag.text = @"insurance-End";
    [sixthlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_sixthline];
    [self.view addSubview:sixthlag];
    [sixthlag setTextAlignment:  NSTextAlignmentCenter];
    
    _seventhline = [[UITextField alloc] initWithFrame:CGRectMake(230, 340, 130, 40)];
    _seventhline.layer.borderColor = [[UIColor grayColor]CGColor];
   _seventhline.layer.borderWidth = 2;
    _seventhline.adjustsFontSizeToFitWidth = YES;
    [_seventhline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *seventhlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 220, 40)];
    seventhlag.layer.borderColor = [[UIColor grayColor]CGColor];
    seventhlag.layer.borderWidth = 2;
    seventhlag.text = @"insurance-Start";
    [seventhlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_seventhline];
    [self.view addSubview:seventhlag];
    [seventhlag setTextAlignment:  NSTextAlignmentCenter];
    
    _eightline = [[UITextField alloc] initWithFrame:CGRectMake(230, 380, 130, 40)];
    _eightline.layer.borderColor = [[UIColor grayColor]CGColor];
    _eightline.layer.borderWidth = 2;
    _eightline.adjustsFontSizeToFitWidth = YES;
    [_eightline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *eightlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 380, 220, 40)];
    eightlag.layer.borderColor = [[UIColor grayColor]CGColor];
    eightlag.layer.borderWidth = 2;
    eightlag.text = @"license";
    [eightlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_eightline];
    [self.view addSubview:eightlag];
    [eightlag setTextAlignment:  NSTextAlignmentCenter];
    
    _nineline = [[UITextField alloc] initWithFrame:CGRectMake(230, 420, 130, 40)];
    _nineline.layer.borderColor = [[UIColor grayColor]CGColor];
    _nineline.layer.borderWidth = 2;
    [_nineline setTextAlignment:  NSTextAlignmentCenter];
    _nineline.adjustsFontSizeToFitWidth = YES;
    UILabel *ninelag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 420, 220, 40)];
    ninelag.layer.borderColor = [[UIColor grayColor]CGColor];
    ninelag.layer.borderWidth = 2;
    ninelag.text = @"mainentance Period";
    [ninelag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_nineline];
    [self.view addSubview:ninelag];
    [ninelag setTextAlignment:  NSTextAlignmentCenter];
    
    _tenline = [[UITextField alloc] initWithFrame:CGRectMake(230, 460, 130, 40)];
    _tenline.layer.borderColor = [[UIColor grayColor]CGColor];
    _tenline.layer.borderWidth = 2;
    [_tenline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *tenlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 460, 220, 40)];
    tenlag.layer.borderColor = [[UIColor grayColor]CGColor];
    tenlag.layer.borderWidth = 2;
    tenlag.text = @"Nick Name";
    [tenlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_tenline];
    [self.view addSubview:tenlag];
    [tenlag setTextAlignment:  NSTextAlignmentCenter];
    
    _elevenline = [[UITextField alloc] initWithFrame:CGRectMake(230, 500, 130, 40)];
    _elevenline.layer.borderColor = [[UIColor grayColor]CGColor];
    _elevenline.layer.borderWidth = 2;
    [_elevenline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *elevenlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 500, 220, 40)];
    elevenlag.layer.borderColor = [[UIColor grayColor]CGColor];
    elevenlag.layer.borderWidth = 2;
    elevenlag.text = @"purchase-Time";
    _elevenline.adjustsFontSizeToFitWidth = YES;
    [elevenlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_elevenline];
    [self.view addSubview:elevenlag];
    [elevenlag setTextAlignment:  NSTextAlignmentCenter];
    
    _twelveline = [[UITextField alloc] initWithFrame:CGRectMake(230, 540, 130, 40)];
    _twelveline.layer.borderColor = [[UIColor grayColor]CGColor];
    _twelveline.layer.borderWidth = 2;
    [_twelveline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *twelvelag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 540, 220, 40)];
    twelvelag.layer.borderColor = [[UIColor grayColor]CGColor];
    twelvelag.layer.borderWidth = 2;
    twelvelag.text = @"type";
    [twelvelag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:_twelveline];
    [self.view addSubview:twelvelag];
    [twelvelag setTextAlignment:  NSTextAlignmentCenter];
    
//    UIButton *edit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    edit.frame = CGRectMake(0, 0, 30, 30);
//    
////    [edit setTitle:@"Edit" forState:UIControlStateNormal];
//    [edit addTarget:self action:@selector(editdata:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editdata:)];
   
    self.navigationItem.rightBarButtonItem = edit;

    
    self.ensure = [[UIButton alloc]initWithFrame:CGRectMake(272/2, 590, 100, 30)];
    self.ensure.backgroundColor = [UIColor blackColor];
    [self.ensure setTitle:@"OK" forState:UIControlStateNormal];
    [self.ensure addTarget:self action:@selector(postdata) forControlEvents:UIControlEventTouchUpInside];
    self.ensure.hidden = YES;
    [self.view addSubview:self.ensure];
    
    
    
    [self getData:^(NSMutableDictionary *array) {
         _firstline.text = [self timechangerfrom:array[@"annualInspection"]];
//         _firstline.text =[NSString stringWithFormat:@"%@",array[@"annualInspection"]];
         _secondline.text =[NSString stringWithFormat:@"%@",array[@"brand"]];
         _thirdline.text =[NSString stringWithFormat:@"%@",array[@"department"]];
         _fouthline.text =[NSString stringWithFormat:@"%@",array[@"driver"]];
         _fifthline.text =[NSString stringWithFormat:@"%@",array[@"iddepartment"]];
//         _sixthline.text =[NSString stringWithFormat:@"%@",array[@"insuranceEnd"]];
        _sixthline.text = [self timechangerfrom:array[@"insuranceEnd"]];
//         _seventhline.text =[NSString stringWithFormat:@"%@",array[@"insuranceStart"]];
        _seventhline.text = [self timechangerfrom:array[@"insuranceStart"]];
         _eightline.text =[NSString stringWithFormat:@"%@",array[@"license"]];
//         _nineline.text =[NSString stringWithFormat:@"%@",array[@"mainentancePeriod"]];
        _nineline.text = [self timechangerfrom:array[@"mainentancePeriod"]];
         _tenline.text =[NSString stringWithFormat:@"%@",array[@"nickName"]];
//         _elevenline.text =[NSString stringWithFormat:@"%@",array[@"purchaseTime"]];
        _elevenline.text = [self timechangerfrom:array[@"purchaseTime"]];
         _twelveline.text =[NSString stringWithFormat:@"%@",array[@"type"]];
        
        
    }];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    

    [_firstline setEnabled:NO];
    [_secondline setEnabled:NO];
    [_thirdline setEnabled:NO];
    [_fouthline setEnabled:NO];
    [_fifthline setEnabled:NO];
    [_sixthline setEnabled:NO];
    [_seventhline setEnabled:NO];
    [_eightline setEnabled:NO];
    [_nineline setEnabled:NO];
    [_tenline setEnabled:NO];
    [_elevenline setEnabled:NO];
    [_twelveline setEnabled:NO];
  
    
}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return NO;
//}

- (NSString *)timechangerfrom:(NSString *)timestamp{
    NSString *tempp = [NSString stringWithFormat:@"%@",timestamp];
    NSString *str=[tempp substringToIndex:10];//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1   //点击空白隐藏键盘
{
    
    [self.view endEditing:YES];
    
}
- (void)editdata:(UIBarButtonItem *)item{
   
    if (self.firstline.enabled) {
        self.firstline.enabled = NO;
        self.secondline.enabled = NO;
        self.thirdline.enabled = NO;
        self.fouthline.enabled = NO;
        self.fifthline.enabled = NO;
        self.sixthline.enabled = NO;
        self.seventhline.enabled = NO;
        self.eightline.enabled = NO;
        self.nineline.enabled = NO;
        self.tenline.enabled = NO;
        self.elevenline.enabled = NO;
        self.twelveline.enabled = NO;
        [self.view endEditing:YES];
        self.ensure.hidden = YES;
        item.title = @"edit";
    }else{
    self.firstline.enabled = YES;
        self.secondline.enabled = YES;
        self.thirdline.enabled = YES;
        self.fouthline.enabled = YES;
        self.fifthline.enabled = YES;
        self.sixthline.enabled = YES;
        self.seventhline.enabled = YES;
        self.eightline.enabled = YES;
        self.nineline.enabled = YES;
        self.tenline.enabled = YES;
        self.elevenline.enabled = YES;
        self.twelveline.enabled = YES;
        self.ensure.hidden = NO;
        item.title = @"cancel";}
}
     
- (void)postdata{
  
    NSNumberFormatter * g = [[NSNumberFormatter alloc] init];
    [g setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * second = [g numberFromString:_fifthline.text];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"insuranceEnd": _sixthline.text,
                                         @"purchaseTime": _elevenline.text,
                                         @"idcar": _carid,
                                         @"annualInspection": _firstline.text,
                                         @"brand": _secondline.text,
                                         @"license": _eightline.text,
                                         @"type": _twelveline.text,
                                         @"iddepartment": second,
                                         @"nickName": _tenline.text,
                                         @"mainentancePeriod": _nineline.text,
                                         @"insuranceStart": _seventhline.text,
                                         @"driver": _fouthline.text
//                                         @"insuranceEnd": @"2014-1-1",
//                                         @"purchaseTime": @"2009-1-1",
//                                         @"idcar": @587,
//                                         @"annualInspection": @"2016-1-10",
//                                         @"brand": @"bmw",
//                                         @"license": @"sdaw12",
//                                         @"type": @"bx314",
//                                         @"iddepartment": @12,
//                                         @"nickName": @"apple",
//                                         @"mainentancePeriod": @"2016-1-10",
//                                         @"insuranceStart": @"2010-1-1",
//                                         @"driver": @"sss"

                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/updatecar.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             NSLog(@"%@",responseObject);
                                                                             if (responseObject[@"status"]) {
                                                                                 NSLog(@"success");
                                                                                 UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"information" message:@"success!" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
                                                                                 [alertView show];
                                                                                 [self.navigationController popViewControllerAnimated:YES];
                                                                                 [self getData:^(NSMutableDictionary *array) {
                                                                                     _firstline.text =[NSString stringWithFormat:@"%@",array[@"annualInspection"]];
                                                                                     _secondline.text =[NSString stringWithFormat:@"%@",array[@"brand"]];
                                                                                     _thirdline.text =[NSString stringWithFormat:@"%@",array[@"department"]];
                                                                                     _fouthline.text =[NSString stringWithFormat:@"%@",array[@"driver"]];
                                                                                     _fifthline.text =[NSString stringWithFormat:@"%@",array[@"iddepartment"]];
                                                                                     _sixthline.text =[NSString stringWithFormat:@"%@",array[@"insuranceEnd"]];
                                                                                     _seventhline.text =[NSString stringWithFormat:@"%@",array[@"insuranceStart"]];
                                                                                     _eightline.text =[NSString stringWithFormat:@"%@",array[@"license"]];
                                                                                     _nineline.text =[NSString stringWithFormat:@"%@",array[@"mainentancePeriod"]];
                                                                                     _tenline.text =[NSString stringWithFormat:@"%@",array[@"nickName"]];
                                                                                     _elevenline.text =[NSString stringWithFormat:@"%@",array[@"purchaseTime"]];
                                                                                     _twelveline.text =[NSString stringWithFormat:@"%@",array[@"type"]];
                                                                                     
                                                                                     
                                                                                 }];
                                                                                 
                                                                             }
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];

     }

- (void)getData:(void(^)(NSMutableDictionary * array))success{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcar": _carid
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/getcarinfo.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"HTTP Response Body: %@", responseObject);
       NSMutableDictionary *coor = responseObject[@"data"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (success) {
                success(coor);
            }
            
        }];
    }
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
    
}

@end
