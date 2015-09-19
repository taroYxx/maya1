//
//  MYtrackCarViewController.m
//  maya1
//
//  Created by Taro on 15/7/30.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYtrackCarViewController.h"
#import <MapKit/MapKit.h>
#import "AFNetworking.h"
#import "MYAnnotation.h"
#import "MYAnnotationView.h"

@interface MYtrackCarViewController ()<MKMapViewDelegate>
- (void)getDataFromServe:(void(^)(NSMutableDictionary * array))success;
@property (nonatomic , strong) NSString *coordinate;
@property (nonatomic , strong) NSString *license;
@property (nonatomic , strong) NSString *nickname;
@property (nonatomic , strong) NSString *speed;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) MKMapView *mapview;
@property (nonatomic , strong) NSTimer *time;


@end

@implementation MYtrackCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = true;
     self.navigationItem.title = @"track";
     
    _mapview = [[MKMapView alloc] init];

    _mapview.frame = [UIScreen mainScreen].bounds;
    _mapview.delegate = self;
   _mapview.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:_mapview];
    
    [self addAnnotationToMap];

    _time = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(addAnnotationToMap) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop mainRunLoop ];
    [runloop addTimer:_time forMode:NSRunLoopCommonModes];
//     [NSThread detachNewThreadSelector:@selector(startTimer) toTarget:self withObject:nil];
//
    
    
    // Do any additional setup after loading the view.
}

//
//-(void)startTimer{
//    _time = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(addAnnotationToMap) userInfo:nil repeats:YES];
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop ];
//    [runloop addTimer:_time forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop]run];
//
//    
//    
//}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated ];
    [_time invalidate];
}


- (void)addAnnotationToMap{
    
    
    [self getDataFromServe:^(NSMutableDictionary *array) {
        NSDictionary *dic = array;
     
       _coordinate = dic[@"coordinate"];
       _license = dic[@"license"];
       _nickname = dic[@"nickname"];
       _speed = dic[@"speed"];
       _status = dic[@"status"];
        
        MYAnnotation *anno = [[MYAnnotation alloc] init];
        NSArray *loc = [_coordinate componentsSeparatedByString:@","];
        
        double x = [loc[0] doubleValue];
        double y = [loc[1] doubleValue];
        anno.coordinate = CLLocationCoordinate2DMake(y, x);
        NSString *title = [NSString stringWithFormat:@"license:%@ speed:%@",_license,_speed];
        anno.title = title;
        anno.subtitle = [NSString stringWithFormat:@"nickname: %@",_nickname];
        NSLog(@"(%f,%f)",x,y);
        [_mapview addAnnotation:anno];
        NSLog(@"添加一个大头针");
     
       
      
//        [_mapview removeAnnotation:anno];
        
     
        
        
    }];
    
}






- (void)getDataFromServe:(void(^)(NSMutableDictionary *array))success{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcar": _trackNum
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/tracing.do" parameters:bodyObject error:NULL];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSMutableDictionary *result = responseObject[@"data"];
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             if (success) {
                 success(result);
             }
             
         }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
}

- (MKAnnotationView *)mapView:(nonnull MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;

    static NSString *ID = @"myAnnoView";
    
    MYAnnotationView *myAnnoView = (MYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (myAnnoView == nil) {
        myAnnoView = [[MYAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        myAnnoView.image = [UIImage imageNamed:@"track"];
        myAnnoView.canShowCallout = YES;
        //        myAnnoView.animatesDrop = YES;
//        NSLog(@"加载自己大头针模型");
//          NSLog(@"删除一个大头针");
        
        
        
    }
    
    
    return myAnnoView;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateSpan span = {0.1,0.1};
    NSArray *loc = [_coordinate componentsSeparatedByString:@","];
    
    double x = [loc[0] doubleValue];
    double y = [loc[1] doubleValue];
    MKCoordinateRegion region = {CLLocationCoordinate2DMake(y, x),span};
    [mapView setRegion:region animated:YES];

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
