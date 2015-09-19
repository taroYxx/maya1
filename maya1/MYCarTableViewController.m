//
//  MYCarTableViewController.m
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//
#import "MYCarTableViewController.h"

#import "MYSearchBar.h"
#import "AFNetworking.h"
#import "CarData.h"
#import <Foundation/Foundation.h>
#import "MYSearchTableViewController.h"
#import "MYStatueViewController.h"
#import "MJRefresh.h"




@interface MYCarTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIAlertViewDelegate>


@property (nonatomic , strong) NSMutableArray *temp;
@property (nonatomic , strong) NSMutableArray *datagroups;
@property (nonatomic , strong) UIAlertView *addtable;

@end

@implementation MYCarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.tableView.header = [ MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [self loadNewData];
   }];
    [self.tableView.header beginRefreshing];
//    MYSearchBar *searchBar = [MYSearchBar searchBar];
//    CGRect frame = searchBar.frame;
//    frame.size.height = 30;
//    frame.size.width = 300;
//    frame.origin.y = self.navigationController.navigationBar.frame.size.height + 20;
//    searchBar.frame = frame;
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.showsCancelButton = NO;
    searchBar.barStyle=UIBarStyleDefault;
    searchBar.placeholder=@"Enter the car number";
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
  
    self.navigationItem.titleView = searchBar;
//    MYSearchTableViewController *searchview = [[MYSearchTableViewController alloc] init];
//    UISearchController *searchcontrol = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:searchview];
//    [searchcontrol setDelegate:self];
    
    // 右上角添加车辆按钮。
    UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    add.frame = CGRectMake(0, 0, 30, 30);
    
    [add setTitle:@"Add" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addcars) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addcar = [[UIBarButtonItem alloc] initWithCustomView:add];
    self.navigationItem.rightBarButtonItem = addcar;

//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getDataFrom:^(NSMutableArray *array) {
        _temp = array;
        
        [self datagroups];
      [self.tableView reloadData];
            }];
}

-(void) addcars{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Car" message:@"Imput car's imformation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *iddeapartment = alertController.textFields.firstObject;
        UITextField *nickname = alertController.textFields[1];
        UITextField *annuallnspection = alertController.textFields[2];
        UITextField *brand = alertController.textFields[3];
        UITextField *insurancestart = alertController.textFields[4];
        UITextField *insuranceend = alertController.textFields[5];
        UITextField *driver = alertController.textFields[6];
        UITextField *license = alertController.textFields[7];
        UITextField *mainertanceperiod = alertController.textFields[8];
        UITextField *type = alertController.textFields[9];
        UITextField *purchasetime = alertController.textFields[10];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber = [f numberFromString:iddeapartment.text];
        // JSON Body
        NSDictionary* bodyObject = @{
                                     @"data": @{
                                             @"insuranceEnd": insuranceend.text,
                                             @"driver": driver.text,
                                             @"license": license.text,
                                             @"type": type.text,
                                             @"purchaseTime": purchasetime.text,
                                             @"mainentancePeriod": mainertanceperiod.text,
                                             @"annualInspection": annuallnspection.text,
                                             @"brand": brand.text,
                                             @"insuranceStart": insurancestart.text,
                                             @"iddepartment": myNumber,
                                             @"nickName": nickname.text
                                             }
                                     };
        
        NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/addcar.do" parameters:bodyObject error:NULL];
        
        // Fetch Request
        AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {

                                                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                 NSLog(@"HTTP Request failed: %@", error);
                                                                             }];
        
        [manager.operationQueue addOperation:operation];
        [self loadNewData];

        

      
    
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"iddepartment";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"nickname";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"annuallnspection";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"brand";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"insurancestart";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"insuranceEnd";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"driver";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"license";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"mainerntancePeriod";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"type";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"purchaseTime";
    }];
 
 
    
    [self presentViewController:alertController animated:YES completion:nil];
 
    
}

    






-(void)getDataFrom:(void(^)( NSMutableArray  * array))success{
    
    

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





- (NSArray *)datagroups{
  
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        CarData *data =[CarData carGroupWithDic:dict];

        [ arrayModels addObject:data];
    }
    _datagroups = arrayModels;

  return _datagroups;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datagroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    CarData *cardata = _datagroups[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",cardata.id];
//    cell.detailTextLabel.text = cardata.license;
    cell.textLabel.text = cardata.license;
    cell.detailTextLabel.text = cardata.driver;
    cell.imageView.image = [UIImage imageNamed:@"car1"];
//
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarData *cardata = _datagroups[indexPath.row];
    
//    MYDetailViewController *detail = [[MYDetailViewController alloc] init];
//   
//    detail.carId = cardata.id;
//     [self.navigationController pushViewController:detail animated:YES];
    MYStatueViewController *carstatue = [[MYStatueViewController alloc] init];
    carstatue.carid = cardata.id;
    carstatue.license = cardata.license;
    [self.navigationController pushViewController:carstatue animated:YES];
    
}

//删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    CarData *cardata = _datagroups[indexPath.row];
    // Create manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcar": cardata.id
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/deletecar.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
//   NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
//    NSLog(@"HTTP Response Body: %@", operation);
     
        if ([operation.response statusCode] == 200) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"delet success" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
            [self loadNewData];
            
        }
        else{
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"there are some problem." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
            
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP Request failed: %@", error);
    }];

        [manager.operationQueue addOperation:operation];
    
}

- (void)loadNewData
{
    [self getDataFrom:^(NSMutableArray *array) {
        _temp = array;
        
        [self datagroups];
        [self.tableView reloadData];
    }];
   
    [self.tableView.header endRefreshing];
}
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [self.tableView.header endRefreshing];
//    });
   
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    MYStatueViewController *detail = [[MYStatueViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    detail.carid = searchBar.text;
    NSLog(@"开始搜索");
}

@end
