//
//  MYcarstopViewController.m
//  maya1
//
//  Created by Taro on 15/8/7.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYcarstopViewController.h"
#import "MYAnnotation.h"
#import "MYAnnotationView.h"
#import <MapKit/MapKit.h>
#import "AFNetworking.h"

@interface MYcarstopViewController ()<MKMapViewDelegate>
@property (nonatomic , strong) MKMapView *map;

@end

@implementation MYcarstopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = true;
    self.map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 45, 375,375)];
    self.map.delegate = self;
    self.map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    [self.view addSubview:self.map];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *start = [[UILabel alloc] initWithFrame:CGRectMake(50, 450, 100, 30)];
    start.text = @"start time";
    [self.view addSubview:start];
    self.starttime = [[UITextField alloc] initWithFrame:CGRectMake(150, 450, 200, 30)];
    self.starttime.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.starttime];
    self.navigationItem.title = @"Park Recodee";
    UILabel *end = [[UILabel alloc] initWithFrame:CGRectMake(50, 500, 100, 30)];
    end.text = @"end time";
    [self.view addSubview:end];
    self.endtime = [[UITextField alloc] initWithFrame:CGRectMake(150, 500, 200, 30)];
    self.endtime.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.endtime];
    
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
    
    UIButton *run = [[UIButton alloc] initWithFrame:CGRectMake(275/2, 550, 100, 40)];
    run.backgroundColor = [UIColor blackColor];
    [run addTarget:self action:@selector(parkrecode) forControlEvents:UIControlEventTouchUpInside];
    [run setTitle:@"OK" forState:UIControlStateNormal];
    [self.view addSubview:run];

    
}


- (void)inputDataToServe:(void(^)(NSMutableArray  * array))success{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcar": self.carid,
                                         @"starttime": self.starttime.text,
                                         @"endtime": self.endtime.text
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/stoprecord.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"HTTP Response Body: %@", responseObject);
        NSMutableArray *coor = responseObject[@"data"];
        
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

- (void)parkrecode{
 
    [self inputDataToServe:^(NSMutableArray *array) {
        
        //            NSLog(@"array= %@",array);
        //            NSLog(@"zongshu %lu",array.count);
        NSMutableArray *stopStarttime = [[NSMutableArray alloc] init];
        NSMutableArray *stopEndtime = [[NSMutableArray alloc] init];
        NSMutableArray *stopCoordinate = [[NSMutableArray alloc] init];
        
        if (array.count)
        {
            
            
            for (int i = 0; i<array.count; i++) {
                stopStarttime[i] = array[i][@"starttime"];
                stopEndtime[i] = array[i][@"endtime"];
                stopCoordinate[i] = array[i][@"coordinate"];
                
                
                
                
            }
            

            
            _coordinate = stopCoordinate;
            _ETime = stopEndtime;
            _STime = stopStarttime;
            
            for (int i= 0; i<_coordinate.count; i++) {
                NSArray *loc = [_coordinate[i] componentsSeparatedByString:@","];
                
                double x = [loc[0] doubleValue];
                double y = [loc[1] doubleValue];
                MYAnnotation *annotation = [[MYAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(y, x);
                NSString *sta = [self timechangerfrom:_STime[i]];
                NSString *ennnnd = [self timechangerfrom:_ETime[i]];
                
                
                annotation.title = [NSString stringWithFormat:@"%@----%@",sta,ennnnd];
                
                
                [self.map addAnnotation:annotation];
         
            }
        }
        else{
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"system information" message:@"There is no record in this time " delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alertView show];
            
        }
        
    }];

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
- (MKAnnotationView *)mapView:(nonnull MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    static NSString *ID = @"myAnnoView";
    
    MYAnnotationView *myAnnoView = (MYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (myAnnoView == nil) {
        myAnnoView = [[MYAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        myAnnoView.image = [UIImage imageNamed:@"stop"];
        myAnnoView.canShowCallout = YES;
        //        myAnnoView.animatesDrop = YES;
        
        
        
    }
    
    
    return myAnnoView;
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    MKCoordinateSpan span = {1.0,1.0};
    
    MKCoordinateRegion region = {CLLocationCoordinate2DMake(30,120),span};
    [mapView setRegion:region animated:YES];
    
    
}

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


@end
