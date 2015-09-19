//
//  MYRunDetailViewController.m
//  maya1
//
//  Created by Taro on 15/8/17.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYRunDetailViewController.h"
#import <MapKit/MapKit.h>
#import "MYAnnotation.h"
#import "MYAnnotationView.h"

@interface MYRunDetailViewController ()<MKMapViewDelegate,MKOverlay>
@property (nonatomic , strong) MKMapView *mapview;
@property (nonatomic , strong) MKPolyline *routeLine;
@property (nonatomic , strong) MKPolylineView *routeLineView;

@end

@implementation MYRunDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapview = [[MKMapView alloc] init];
    self.mapview.frame = self.view.frame;
    self.mapview.delegate = self;
    [self.view addSubview:self.mapview];
    // Do any additional setup after loading the view.
    NSLog(@"success %@----%@",_endcoordinate,_startcoordinate);
    NSArray *loc = [_startcoordinate componentsSeparatedByString:@","];
    double x = [loc[0] doubleValue];
    double y = [loc[1] doubleValue];
    MYAnnotation *annotation = [[MYAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(y, x);
    //            annotation.title = _stime[i];
    annotation.icon = @"start";
    [self.mapview addAnnotation:annotation];
    NSArray *loc1 = [_endcoordinate componentsSeparatedByString:@","];
    
    double a = [loc1[0] doubleValue];
    double b = [loc1[1] doubleValue];
    
    MYAnnotation *stop = [[MYAnnotation alloc] init];
    
    stop.coordinate = CLLocationCoordinate2DMake(b, a);
    stop.icon = @"end";
    [self.mapview addAnnotation: stop];
    
    CLLocation *location0 = [[CLLocation alloc] initWithLatitude:y longitude:x];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:b longitude:a];
    NSArray *array = [NSArray arrayWithObjects:location0, location1, nil];
    [self drawLineWithLocationArray:array];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    MKCoordinateSpan span = {1.0,1.0};
    
    MKCoordinateRegion region = {CLLocationCoordinate2DMake(30,120),span};
    [mapView setRegion:region animated:YES];
    
    
}


- (MKAnnotationView *)mapView:(nonnull MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    static NSString *ID = @"myAnnoView";
    
    MYAnnotationView *myAnnoView = (MYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (myAnnoView == nil) {
        myAnnoView = [[MYAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        //        myAnnoView.image = [UIImage imageNamed:@"stop"];
        myAnnoView.canShowCallout = YES;
        
        //        myAnnoView.animatesDrop = YES;
        
        
        
    }
    MYAnnotation *anno = (MYAnnotation *)annotation;
    
    myAnnoView.image = [UIImage imageNamed:anno.icon];
    
    
    return myAnnoView;
    
}

//画线
- (void)drawLineWithLocationArray:(NSArray *)locationArray
{
    NSInteger pointCount = [locationArray count];
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < pointCount; ++i) {
        CLLocation *location = [locationArray objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
    }
    
    self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    [self.mapview setVisibleMapRect:[self.routeLine boundingMapRect]];
    [self.mapview addOverlay:self.routeLine];
    
    free(coordinateArray);
    coordinateArray = NULL;
}
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay == self.routeLine) {
        if(nil == self.routeLineView) {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 5;
        }
        return self.routeLineView;
    }
    return nil;
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
