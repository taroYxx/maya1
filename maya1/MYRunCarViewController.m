//
//  MYRunCarViewController.m
//  maya1
//
//  Created by Taro on 15/8/6.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYRunCarViewController.h"
#import <MapKit/MapKit.h>
#import "AFNetworking.h"
#import "MYAnnotation.h"
#import "MYAnnotationView.h"
#import "runrecode.h"
#import "MYRunDetailViewController.h"

@interface MYRunCarViewController ()<MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITextField *starttime;
@property (nonatomic , strong) UITextField *endtime;
@property (nonatomic,retain) UIToolbar * accessoryView;
@property (nonatomic,retain) UIDatePicker *customInput;
@property (nonatomic , strong) NSMutableArray *startCoordinate;
@property (nonatomic , strong) NSMutableArray *endCoordinate;
@property (nonatomic , strong) NSMutableArray *runEnd;
@property (nonatomic , strong) NSMutableArray *runStart;
@property (nonatomic , strong) NSMutableArray *stime;
@property (nonatomic , strong) NSMutableArray *etime;
@property (nonatomic , strong) MKMapView *map;


@property (nonatomic , strong) UITableView *runlist;

@property (nonatomic , strong) NSArray *temp;
@property (nonatomic , strong) NSArray *datagroups;

- (void)inputDataToServe:(void(^)(NSMutableArray  * array))success;
@end

@implementation MYRunCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = true;
    // Do any additional setup after loading the view.
    self.map = [[MKMapView alloc] init];
    self.navigationItem.title = @"Driving Recodee";
    self.view.backgroundColor = [UIColor whiteColor];
    self.map.delegate = self;
    self.map.frame = CGRectMake(0, 45, 375,375);
//    [self.view addSubview:self.map];
//    self.tabBarController.tabBar.hidden = YES;
   self.runlist = [[UITableView alloc] init];
   self.runlist.frame = CGRectMake(0, 45, 375, 375);
    [self.view addSubview:self.runlist];
    self.runlist.delegate = self;
    self.runlist.dataSource = self;

//    NSString *str=@"1442160000000";//时间戳
//    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSLog(@"date:%@",[detaildate description]);
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
//    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    UILabel *start = [[UILabel alloc] initWithFrame:CGRectMake(50, 450, 100, 30)];
    start.text = @"start time";
    [self.view addSubview:start];
    self.starttime = [[UITextField alloc] initWithFrame:CGRectMake(150, 450, 200, 30)];
    self.starttime.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.starttime];
    
    UILabel *end = [[UILabel alloc] initWithFrame:CGRectMake(50, 500, 100, 30)];
    end.text = @"end time";
    [self.view addSubview:end];
    self.endtime = [[UITextField alloc] initWithFrame:CGRectMake(150, 500, 200, 30)];
    self.endtime.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.endtime];
    
    UIButton *run = [[UIButton alloc] initWithFrame:CGRectMake(275/2, 550, 100, 40)];
    run.backgroundColor = [UIColor blackColor];
    [run addTarget:self action:@selector(runrecode) forControlEvents:UIControlEventTouchUpInside];
    [run setTitle:@"OK" forState:UIControlStateNormal];
    [self.view addSubview:run];
    
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
 
 
    self.starttime.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.starttime.layer.borderWidth = 1.0;
    self.starttime.layer.borderColor = [UIColor colorWithWhite:209.0 / 255.0 alpha:1.0].CGColor;
    self.starttime.backgroundColor = [UIColor whiteColor];
    self.starttime.inputAccessoryView = self.accessoryView;
    self.starttime.inputView = self.customInput;
    

    self.endtime.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.endtime.layer.borderWidth = 1.0;
    self.endtime.layer.borderColor = [UIColor colorWithWhite:209.0 / 255.0 alpha:1.0].CGColor;
    self.endtime.backgroundColor = [UIColor whiteColor];
    self.endtime.inputAccessoryView = self.accessoryView;
    self.endtime.inputView = self.customInput;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _temp.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    runrecode *list = _datagroups[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@",list.startime];
    NSString *str= [string substringToIndex:10];//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *start = [dateFormatter stringFromDate: detaildate];
    
    NSString *string1 = [NSString stringWithFormat:@"%@",list.endtime];
    NSString *str1= [string1 substringToIndex:10];//时间戳
    NSTimeInterval time1=[str1 doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
   
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *end = [dateFormatter stringFromDate: detaildate1];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",start,end];
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    runrecode *list = _datagroups[indexPath.row];
    
    MYRunDetailViewController *detail = [[MYRunDetailViewController alloc] init];
    detail.startcoordinate = list.startcoordinate;
    detail.endcoordinate = list.endcoordinate;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)runrecode{

    [self inputDataToServe:^(NSMutableArray *array) {
        
        NSLog(@"%@",array);
        _temp = array;
        [self datagroups];
        NSLog(@"%@",_datagroups);
        [_runlist reloadData];
        NSMutableArray *end = [[NSMutableArray alloc] init];
        NSMutableArray *start = [[NSMutableArray alloc] init];
        NSMutableArray *Stime = [[NSMutableArray alloc] init];
        NSMutableArray *Etime = [[NSMutableArray alloc] init];
        
        if (array.count)
        {
            
            NSLog(@"%@",array[0][@"endcoordinate"]);
            NSLog(@"%lu",array.count);
       
            for (int i = 0; i<array.count; i++) {
                end[i] = array[i][@"endcoordinate"];
                start[i] = array[i][@"startcoordinate"];
                Stime[i] = array[i][@"startime"];
                Etime[i] = array[i][@"endtime"];
                
                
            }
            _etime = Etime;
            _stime = Stime;
            _endCoordinate = end;
            _startCoordinate = start;
            
//          NSLog(@"%@--%@--%@--%@",_startCoordinate,_endCoordinate,_etime,_stime);
          
        }
        else{
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"system information" message:@"There is no record in this time " delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alertView show];
            
        }
        
    }];
    
    
    
}

- (NSArray *)datagroups{
    
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        runrecode *data =[runrecode carRecodeWithDic:dict];
        [ arrayModels addObject:data];
    }
    _datagroups = arrayModels;
    
    return _datagroups;
    
    
}




-(void)OnTapDone:(id) sender{
    if ( [self.starttime isFirstResponder] ) {
        [self.starttime resignFirstResponder];
    } else if ( [self.endtime isFirstResponder] ) {
        [self.endtime resignFirstResponder];
    }
    
}

-(void)dateChanged:(id) sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if ( [self.starttime isFirstResponder] ) {
        self.starttime.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];
    } else if ( [self.endtime isFirstResponder] ) {
        self.endtime.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];
    }
    
    
}

- (void)inputDataToServe:(void(^)(NSMutableArray  * array))success{
//     NSLog(@"%@---%@",self.starttime.text,self.endtime.text);
    // My API (POST http://120.26.83.51:8080/maya/demo/runrecord/list.do)
    
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcar": self.carid,
                                         @"starttime": self.starttime.text,
                                         @"endtime": self.endtime.text
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/runrecord/list.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
    NSLog(@"HTTP Response Body: %@", responseObject);
        NSMutableArray *coor = responseObject[@"data"];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (success) {
                success(coor);
            }
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];

    
    
}



@end
