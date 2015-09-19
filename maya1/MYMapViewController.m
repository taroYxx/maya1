//
//  MYMapViewController.m
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYMapViewController.h"
#import "AFNetworking.h"
#import "MYAnnotation.h"
#import "MYAnnotationView.h"

#import "CarData.h"
#import "MYdetailbutton.h"
#import "MYStatueViewController.h"
#import "MYloginViewController.h"

@interface MYMapViewController ()<MKMapViewDelegate>
@property (nonatomic , strong) NSArray *data;
@property (nonatomic , strong) NSArray *temp;
@property (nonatomic , strong) MYdetailbutton *pushtodetail;
@property (nonatomic , assign) NSString *post;
@property (nonatomic , strong) NSString *license;


-(void)getDataFrom:(void(^)(NSMutableArray * array))success;
@end


@implementation MYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MKMapView *mapview = [[MKMapView alloc] init];
    mapview.frame = [UIScreen mainScreen].bounds;
    mapview.delegate = self ;
    mapview.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:mapview];
//请打开定位服务通知。
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Log off" style:UIBarButtonItemStylePlain target:self action:@selector(logoff)];
    
    self.navigationItem.rightBarButtonItem = edit;
    
    [self getDataFrom:^(NSMutableArray *array) {
        _temp = array;
        [self data];
        CarData *car = [[CarData alloc] init];
        for (int i = 0; i<_data.count; i++) {
            car = _data[i];
        
            NSArray *loc = [car.coordinate componentsSeparatedByString:@","];
            
            double x = [loc[0] doubleValue];
            double y = [loc[1] doubleValue];
            MYAnnotation *anno = [[MYAnnotation alloc] init];
            anno.coordinate = CLLocationCoordinate2DMake(y, x);
           
            anno.title = [NSString stringWithFormat:@"%@",car.license];
            _license = car.license;
            
            anno.subtitle = [NSString stringWithFormat:@"%@",car.id];

            [mapview addAnnotation:anno];
        
            
        }
        

        
    }];
    
        

    
   

}

- (void)logoff{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MYloginViewController *login = [[MYloginViewController alloc] init];
    window.rootViewController = login;
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *home = NSHomeDirectory();
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@",docPath);
    NSString *filePath = [docPath stringByAppendingPathComponent:@"data.plist"];
    [filemanager removeItemAtPath:filePath error:nil];

    
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    MKCoordinateSpan span = {1.0,1.0};
   
    MKCoordinateRegion region = {CLLocationCoordinate2DMake(30, 120),span};
    [mapView setRegion:region animated:YES];
//    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];

}

- (NSArray *)data{
    
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        CarData *data =[CarData carGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _data = arrayModels;
    
    return _data;
    
    
}

-(void)getDataFrom:(void(^)(NSMutableArray  * array))success{
        
        
        
        AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
        [mgr GET:@"http://120.26.83.51:8080/maya/demo/nestmainview.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableArray *array = responseObject[@"data"][@"cars"];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (success) {
                    success(array);
                }
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
        
    }


- (MKAnnotationView *)mapView:(nonnull MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    static NSString *ID = @"myAnnoView";
    
    MYAnnotationView *myAnnoView = (MYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (myAnnoView == nil) {
        myAnnoView = [[MYAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        myAnnoView.image = [UIImage imageNamed:@"car3"];
        myAnnoView.canShowCallout = YES;
        MYdetailbutton *pushtodetail = [MYdetailbutton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"DetailButton"];
        pushtodetail.license = annotation.title;
        pushtodetail.buttonName = annotation.subtitle;
//        NSLog(@"%@",annotation.title);
        pushtodetail.frame = CGRectMake(20, 20, 20 , 20);
        [pushtodetail setBackgroundImage:image forState:UIControlStateNormal];
        [pushtodetail addTarget:self action:@selector(pushToCar:) forControlEvents:UIControlEventTouchUpInside];
        myAnnoView.rightCalloutAccessoryView = pushtodetail;
    }
    
    //    MyAnnotation *anno = (MyAnnotation *)annotation;
    //    myAnnoView.image = [ UIImage imageNamed:anno.icon];
    return myAnnoView;
    
}



- (void)pushToCar:(MYdetailbutton *)button
{


    _pushtodetail = button;
    

    MYStatueViewController *status = [[MYStatueViewController alloc] init];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:_pushtodetail.buttonName];
    NSLog(@"222%@",_pushtodetail.buttonName);
    status.carid = numTemp;
    
    status.license = _pushtodetail.license;
 

    [self.navigationController pushViewController:status animated:YES];

}




@end
