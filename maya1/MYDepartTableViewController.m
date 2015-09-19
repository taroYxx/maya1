//
//  MYDepartTableViewController.m
//  maya1
//
//  Created by Taro on 15/7/21.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYDepartTableViewController.h"
#import "AFNetworking.h"
#import "MYDepartment.h"
#import "MYSecondTableViewController.h"
#import "MJRefresh.h"
#import "MYtotalViewController.h"


@interface MYDepartTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic , strong) NSMutableArray *temp;
@property (nonatomic , strong) NSMutableArray *datagroups;
@property (nonatomic , strong) NSMutableArray *childtemp;
@property (nonatomic , strong) NSMutableArray *childdatagroups;
@property (nonatomic , strong) NSString *iddepartment;
//@property (nonatomic , strong) NSArray *firstcars;
//@property (nonatomic , strong) NSArray *childdepartmentinfo;


@end

@implementation MYDepartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [ MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.header beginRefreshing];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    add.frame = CGRectMake(0, 0, 30, 30);
    
    [add setTitle:@"Add" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addDepartment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addcar = [[UIBarButtonItem alloc] initWithCustomView:add];
    self.navigationItem.rightBarButtonItem = addcar;

//    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    [segment insertSegmentWithTitle:@"department" atIndex:0 animated:NO];
//    [segment insertSegmentWithTitle:@"group" atIndex:1 animated:NO];
//    [segment addTarget:self action:@selector(segmentDidChange:) forControlEvents:UIControlEventValueChanged];
   
//    self.navigationItem.titleView = segment;
    [self getDataFrom:^(NSMutableArray *array) {
//        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _temp = array;
        
        
        [self datagroups];
       
        [self.tableView reloadData];
    }];
}


-(void) addDepartment{

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
                                             @"coordinateY": jingdu
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


- (NSArray *)childdatagroups{
    
    NSArray *arrayDict = _childtemp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYDepartment *data =[MYDepartment departmentGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _childdatagroups = arrayModels;
    
    return _childdatagroups;
    
    
}




-(void)getDataFrom:(void(^)( NSMutableArray  * array))success{
    
    
    
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    [mgr GET:@"http://120.26.83.51:8080/maya/demo/nestmainview.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *array = responseObject[@"data"][@"departments"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (success) {
                success(array);
            }
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
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
    
    MYDepartment *department = _datagroups[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",department.name];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",department.iddepartment];
    _iddepartment = department.iddepartment;
    cell.imageView.image = [UIImage imageNamed:@"depart1"];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(325, 10, 50, 30);
    [btn3 setTitle:@"stats" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(gettotaldata) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn3];

    return cell;
}
- (void)gettotaldata{
    MYtotalViewController *total = [[MYtotalViewController alloc] init];
    total.iddepartment = _iddepartment;
    total.posttype = @2;
    [self.navigationController pushViewController:total animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MYSecondTableViewController *second = [[MYSecondTableViewController alloc] init];
    MYDepartment *depart = _datagroups[indexPath.row];
    second.cars = depart.cars;
    second.iddepartment = depart.iddepartment;
//    second.childdepartmentsinfo = depart.childdepartmentsinfo;
    second.childdepartmentsinfo = depart.childdepartmentsinfo;

    [self.navigationController pushViewController:second animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
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
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"delet success" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
            //            [self.tableView];
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

@end
