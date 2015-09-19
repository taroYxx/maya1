//
//  MYStatueViewController.m
//  maya1
//
//  Created by Taro on 15/8/6.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYStatueViewController.h"
#import "AFNetworking.h"
#import "MYRunCarViewController.h"
#import "MYtrackCarViewController.h"
#import "MYcarstopViewController.h"
#import "MYCarDocViewController.h"
#import "MYaddToGroupViewController.h"

@interface MYStatueViewController ()


@end

@implementation MYStatueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.title = @"status";
    self.view.backgroundColor = [UIColor whiteColor];

    
    UILabel *firstline = [[UILabel alloc] initWithFrame:CGRectMake(260, 100, 100, 50)];
    firstline.layer.borderColor = [[UIColor grayColor]CGColor];
    firstline.layer.borderWidth = 2;
    [firstline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *firstlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 250, 50)];
    firstlag.layer.borderColor = [[UIColor grayColor]CGColor];
    firstlag.layer.borderWidth = 2;
    firstlag.text = @"fuel consumption on average";
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
    secondlag.text = @"Speed";
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
    thirdlag.text = @"status";
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
    [self.view addSubview:fouthline];
    [self.view addSubview:fouthlag];
    [fouthlag setTextAlignment:  NSTextAlignmentCenter];
    
    UILabel *fifthline = [[UILabel alloc] initWithFrame:CGRectMake(260, 300, 100, 50)];
    fifthline.layer.borderColor = [[UIColor grayColor]CGColor];
    fifthline.layer.borderWidth = 2;
    [firstline setTextAlignment:  NSTextAlignmentCenter];
    UILabel *fifthlag =  [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 250, 50)];
    fifthlag.layer.borderColor = [[UIColor grayColor]CGColor];
    fifthlag.layer.borderWidth = 2;
    [firstlag setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:fifthline];
    [self.view addSubview:fifthlag];
    
    
    
    UIButton *carrun = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 375/2, 50)];
    [carrun setTitle:@"Driving Recode" forState:UIControlStateNormal];
    carrun.backgroundColor = [UIColor grayColor];
    [carrun addTarget:self action:@selector(carrun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carrun];
    
    UIButton *carpark = [[UIButton alloc] initWithFrame:CGRectMake(375/2, 400, 375/2, 50)];
    carpark.backgroundColor = [UIColor redColor];
    [carpark setTitle:@"Park Recode" forState:UIControlStateNormal];
    [carpark addTarget:self action:@selector(park) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carpark];
    
    UIButton *trace = [[UIButton alloc] initWithFrame:CGRectMake(0, 450, 375/2, 50)];
    trace.backgroundColor = [UIColor blueColor];
    [trace setTitle:@"Vehicle Tracking" forState:UIControlStateNormal];
    [trace addTarget:self action:@selector(trackcar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trace];
    
    UIButton *doc = [[UIButton alloc] initWithFrame:CGRectMake(375/2, 450, 375/2, 50)];
    doc.backgroundColor = [UIColor greenColor];
    [doc setTitle:@"Vehicle Information" forState:UIControlStateNormal];
    [doc addTarget:self action:@selector(cardoc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doc];
    
    UIButton *group = [[UIButton alloc] initWithFrame:CGRectMake(375/4, 500, 375/2, 50)];
    group.backgroundColor = [UIColor blackColor];
    [group setTitle:@"add car to group" forState:UIControlStateNormal];
    [group addTarget:self action:@selector(addcartogroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:group];
    
    [self getDataFrom:^(NSMutableDictionary *array) {
        
 
        firstline.text = [NSString stringWithFormat:@"%@",array[@"fuelconsumptiononaverage"]];
        NSLog(@"arrty%@",array);
        secondline.text = [NSString stringWithFormat:@"%@",array[@"speed"]];
        thirdline.text = [NSString stringWithFormat:@"%@",array[@"status"]];
     
    
    }];
    
     NSLog(@"2222---%@",_carid);
    
    

}



- (void)carrun{

    MYRunCarViewController *run = [[MYRunCarViewController alloc] init];
    run.carid = _carid;
    NSLog(@"runn%@",run.carid);
    [self.navigationController pushViewController:run animated:YES];

    
}
- (void)park{
    MYcarstopViewController *stop = [[MYcarstopViewController alloc] init];
    stop.carid = _carid;
    [self.navigationController pushViewController:stop animated:YES];

}

- (void)trackcar{
    MYtrackCarViewController *track = [[MYtrackCarViewController alloc] init];
    track.trackNum = _carid;
    [self.navigationController pushViewController:track animated:YES];
}


- (void)cardoc{
    MYCarDocViewController *doc = [[MYCarDocViewController alloc] init];
    doc.carid = _carid;
    [self.navigationController pushViewController:doc animated:YES];
    
    
}

- (void)addcartogroup{
    MYaddToGroupViewController *group = [[MYaddToGroupViewController alloc] init];
    group.idcar = _carid;
    group.license = _license;
    [self.navigationController pushViewController:group animated:YES];
                               

}



-(void)getDataFrom:(void(^)( NSMutableDictionary  * array))success{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                        @"idcar": _carid
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/instant.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
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
