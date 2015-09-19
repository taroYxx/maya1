//
//  MYSecondTableViewController.m
//  maya1
//
//  Created by Taro on 15/7/31.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYSecondTableViewController.h"
#import "MYDepartment.h"
#import "MYCars.h"
#import "MYThirdDepartmentTableViewController.h"
#import "MYCasOfsecondViewController.h"
#import "MYStatueViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MYDepartTableViewController.h"
#import "MYtotalViewController.h"
@interface MYSecondTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) NSArray *temp;
@property (nonatomic , strong) NSMutableArray *datagroups;
@property (nonatomic , strong) NSArray *carstemp;
@property (nonatomic , strong) NSMutableArray *carsdatagroups;
@property (nonatomic , strong) NSString *pickdepartmentID;
@property (nonatomic , strong) NSString *pickcarID;


@end

@implementation MYSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [ MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.header beginRefreshing];
    UIButton *depart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    depart.frame = CGRectMake(0, 0, 50, 30);
    
    [depart setTitle:@"depart" forState:UIControlStateNormal];
    [depart addTarget:self action:@selector(addChildDepartment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addDepart = [[UIBarButtonItem alloc] initWithCustomView:depart];
    
    UIButton *cars = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cars.frame = CGRectMake(0, 0, 50, 30);
    
    [cars setTitle:@"car" forState:UIControlStateNormal];
    [cars addTarget:self action:@selector(addChildCar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addcar = [[UIBarButtonItem alloc] initWithCustomView:cars];
    self.navigationItem.rightBarButtonItems = @[addDepart,addcar];
    
    
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _temp = _childdepartmentsinfo;
    [self datagroups];
    _carstemp = _cars;
    [self carsdata];

    
   
    
}

- (void)addChildCar{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Car" message:@"Imput car's imformation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        UITextField *iddeapartment = alertController.textFields.firstObject;
        UITextField *nickname = alertController.textFields.firstObject;
        UITextField *annuallnspection = alertController.textFields[1];
        UITextField *brand = alertController.textFields[2];
        UITextField *insurancestart = alertController.textFields[3];
        UITextField *insuranceend = alertController.textFields[4];
        UITextField *driver = alertController.textFields[5];
        UITextField *license = alertController.textFields[6];
        UITextField *mainertanceperiod = alertController.textFields[7];
        UITextField *type = alertController.textFields[8];
        UITextField *purchasetime = alertController.textFields[9];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
//        [f setNumberStyle:NSNumberFormatterDecimalStyle];
//        NSNumber * myNumber = [f numberFromString:iddeapartment.text];
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
                                             @"iddepartment": _iddepartment,
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
    
    
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"iddepartment";
//    }];
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

- (void)addChildDepartment{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Department" message:@"Imput department's imformation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *name = alertController.textFields.firstObject;
        UITextField *latitude = alertController.textFields[1];
        UITextField *longitude = alertController.textFields[2];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * weidu = [f numberFromString:latitude.text];
        NSNumberFormatter * e = [[NSNumberFormatter alloc] init];
        [e setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * jingdu = [e numberFromString:longitude.text];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求是json格式
        manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置回应是json格式
        
        NSDictionary* bodyObject = @{
                                     @"data": @{
                                             @"name": name.text,
                                             @"coordinateX": weidu,
                                             @"coordinateY": jingdu,
                                             @"parentdepartment": _iddepartment
                                             }
                                     };
        NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/department/adddepartment.do" parameters:bodyObject error:NULL];
        
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
        
        
    }];
    
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"latitude";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"longitude";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
    

    
}


- (NSArray *)carsdata{
    NSArray *arrayDict = _carstemp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYCars *data =[MYCars CarsGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _carsdatagroups = arrayModels;
    
    return _carsdatagroups;
}

- (NSArray *)datagroups{
    
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYDepartment *data =[MYDepartment departmentGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _datagroups = arrayModels;
    
    return _datagroups;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _cars.count;
    }else{
        return _childdepartmentsinfo.count;
    }
 
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

  
    
    
    
    if (indexPath.section == 0) {

        MYCars *cars = _carsdatagroups[indexPath.row];

        cell.textLabel.text = cars.license;
        _pickcarID = cars.id;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",cars.id];
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn4.frame = CGRectMake(325, 10, 50, 30);
        [btn4 setTitle:@"stats" forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(carToTotal) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn4];
        
//        [self.navigationController pushViewController:status animated:YES];
        
    }else{
        MYDepartment *depart = _datagroups[indexPath.row];
        
        cell.textLabel.text = depart.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",depart.iddepartment];
        _pickdepartmentID = depart.iddepartment;
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn3.frame = CGRectMake(325, 10, 50, 30);
        [btn3 setTitle:@"stats" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(gettotaldata) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn3];
    }
   
    
//    MYDepartment *department = _datagroups[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",department.name];
//    
//    cell.imageView.image = [UIImage imageNamed:@"depart1"];

    
    return cell;
}

- (void)carToTotal{
    MYtotalViewController *total = [[MYtotalViewController alloc] init];
    total.iddepartment = _pickcarID;
    total.posttype = @1;
    [self.navigationController pushViewController:total animated:YES];
}

- (void)gettotaldata{
    MYtotalViewController *total = [[MYtotalViewController alloc] init];
    total.iddepartment = _pickdepartmentID;
    total.posttype = @2;
    [self.navigationController pushViewController:total animated:YES];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"CAR ";
    }else{
        return @" Child-department";
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
    MYThirdDepartmentTableViewController *Third = [[MYThirdDepartmentTableViewController alloc] init];
    MYDepartment *depart = _datagroups[indexPath.row];
  
        
        Third.departmentID = depart.iddepartment;
        Third.thirdcars = depart.cars;
        
    [self.navigationController pushViewController:Third animated:YES];
    
    }
    
    
    
    else {
        MYCars *cars = _carsdatagroups[indexPath.row];
        MYStatueViewController *status = [[MYStatueViewController alloc] init];
//        MYCasOfsecondViewController *carsOfSecond = [[MYCasOfsecondViewController alloc] init];
//        carsOfSecond.carsID = cars.id;
        status.carid = cars.id;
        status.license = cars.license;
        [self.navigationController pushViewController:status animated:YES];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MYCars *cars = _carsdatagroups[indexPath.row];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // JSON Body
        NSDictionary* bodyObject = @{
                                     @"data": @{
                                             @"idcar": cars.id
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
                                                                                     //            [self.tableView];
            [self loadNewData];
            [self.navigationController popViewControllerAnimated:YES];
                                                                                     
                                                                                 }
            else{
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"there are some problem." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                        [alertView show];
                                                                                     
                                                                                 }
                                                                                 
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP Request failed: %@", error);
                                                                             }];
        
        [manager.operationQueue addOperation:operation];
        

    }else
    {
        MYDepartment *depart = _datagroups[indexPath.row];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // JSON Body
        NSDictionary* bodyObject = @{
                                     @"data": @{
                                             @"iddepartment": depart.iddepartment
                                             }
                                     };
        
        NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/department/deletedepartment.do" parameters:bodyObject error:NULL];
        
        // Fetch Request
        AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([operation.response statusCode] == 200) {
     UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"delet success" delegate:nil cancelButtonTitle:@"ok"otherButtonTitles:nil];
                [alertView show];
            [self loadNewData];
            MYDepartTableViewController *first = [[MYDepartTableViewController alloc] init];
            [self.navigationController popToViewController:first animated:YES];
            
                    
                                                                                     
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
}

- (void)loadNewData
{

    [self datagroups];
    _carstemp = _cars;
    [self carsdata];
    [self.tableView reloadData];
   
    
    [self.tableView.header endRefreshing];
}



@end
