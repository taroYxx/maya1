//
//  MYGroupTableViewController.m
//  maya1
//
//  Created by Taro on 15/8/8.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYGroupTableViewController.h"
#import "AFNetworking.h"
#import "MYGroupSecondTableViewController.h"
#import "MYgroup.h"
#import "MJRefresh.h"
#import "MYtotalViewController.h"

@interface MYGroupTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) NSMutableArray *groupname;
@property (nonatomic , strong) NSMutableArray *postdata;
@property (nonatomic , strong) NSMutableArray *datagroups;
@property (nonatomic , strong) NSString *thisGroupID;
@property (nonatomic , strong) NSString *pickgroupname;
@end

@implementation MYGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [ MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.header beginRefreshing];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    add.frame = CGRectMake(0, 0, 30, 30);
    
    [add setTitle:@"Add" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addgroup) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addcar = [[UIBarButtonItem alloc] initWithCustomView:add];
    self.navigationItem.rightBarButtonItem = addcar;
    
    [self getDataFrom:^(NSMutableArray *array) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i<array.count; i++) {
            temp[i] = array[i][@"name"];
        }
        _postdata = array;
        _groupname = temp;
        [self datagroups];
        [self.tableView reloadData];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addgroup{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Group" message:@"Imput Group's imformation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
           UITextField *name = alertController.textFields.firstObject;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // JSON Body
        NSDictionary* bodyObject = @{
                                     @"data": @{
                                             @"name": name.text
                                             }
                                     };
        
        NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/virtualgroup/addvirtualgroup.do" parameters:bodyObject error:NULL];
        
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
    
    [self presentViewController:alertController animated:YES completion:nil];
    [self loadNewData];
    
}

-(void)getDataFrom:(void(^)( NSMutableArray  * array))success{
    
    
    
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    [mgr GET:@"http://120.26.83.51:8080/maya/demo/virtualgroup/getcars.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *array = responseObject[@"data"];
        
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
    
    NSArray *arrayDict = _postdata;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYgroup *data =[MYgroup MYGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _datagroups = arrayModels;
    
    return _datagroups;
    
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _groupname.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
//    MYDepartment *department = _datagroups[indexPath.row];
    MYgroup *group = _datagroups[indexPath.row];
//    cell.textLabel.text = _groupname[indexPath.row];
    cell.textLabel.text = group.name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",group.idvirtualgroup];
    _thisGroupID =  group.idvirtualgroup;
    
    cell.imageView.image = [UIImage imageNamed:@"group"];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(325, 10, 50, 30);
    [btn3 setTitle:@"stats" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(gettotaldata) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn3];
    
    return cell;
}

- (void)gettotaldata{
    MYtotalViewController *total = [[MYtotalViewController alloc] init];
    total.iddepartment = _thisGroupID;
    total.posttype = @3;
    [self.navigationController pushViewController:total animated:YES];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MYgroup *group = _datagroups[indexPath.row];
    MYGroupSecondTableViewController *second = [[MYGroupSecondTableViewController alloc] init];
    second.pickgroupName = group.name;
    second.datagroup = group.childvirtualgroup;
    second.idgroup = group.idvirtualgroup;
    second.cars = group.cars;
    
    [self.navigationController pushViewController:second animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    MYgroup *group = _datagroups[indexPath.row];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idvirtualgroup": group.idvirtualgroup
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/virtualgroup/deletevirtualgroup.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"delet success" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
            [self loadNewData];
            
        }
        else{
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"there are some problem." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];}
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"HTTP Request failed: %@", error);
     }];
    
    [manager.operationQueue addOperation:operation];

    
}
- (void)loadNewData
{
    [self getDataFrom:^(NSMutableArray *array) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i = 0; i<array.count; i++) {
            temp[i] = array[i][@"name"];
        }
        _postdata = array;
        _groupname = temp;
        [self datagroups];
        [self.tableView reloadData];
    }];

    
    [self.tableView.header endRefreshing];
}

@end
