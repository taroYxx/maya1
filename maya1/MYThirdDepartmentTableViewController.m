//
//  MYThirdDepartmentTableViewController.m
//  maya1
//
//  Created by Taro on 15/8/1.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYThirdDepartmentTableViewController.h"
#import "MYCars.h"
#import "MYStatueViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MYtotalViewController.h"

@interface MYThirdDepartmentTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSArray *temp;
@property (nonatomic , strong) NSMutableArray *datagroups;
@property (nonatomic , strong) NSString *pickcarID;

@end

@implementation MYThirdDepartmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [ MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.header beginRefreshing];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _temp = _thirdcars;
    [self datagroups];
   
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)datagroups{
    
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
       MYCars *data =[MYCars CarsGroupWithDic:dict];
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _datagroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    MYCars *cars = _datagroups[indexPath.row];
    cell.textLabel.text =cars.license;
    _pickcarID = cars.id;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",cars.id];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn4.frame = CGRectMake(325, 10, 50, 30);
    [btn4 setTitle:@"stats" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(carToTotal) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn4];
    return cell;
    
}

- (void)carToTotal{
    MYtotalViewController *total = [[MYtotalViewController alloc] init];
    total.iddepartment = _pickcarID;
    total.posttype = @1;
    [self.navigationController pushViewController:total animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYStatueViewController *status = [[MYStatueViewController alloc] init];
    //        MYCasOfsecondViewController *carsOfSecond = [[MYCasOfsecondViewController alloc] init];
    //        carsOfSecond.carsID = cars.id;
     MYCars *cars = _datagroups[indexPath.row];
    status.carid = cars.id;
    status.license = cars.license;
    [self.navigationController pushViewController:status animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    MYCars *cars = _datagroups[indexPath.row];
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
            
           [self loadNewData];
    [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                 
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
    _temp = _thirdcars;
    [self datagroups];
    [self.tableView reloadData];
 
    
    [self.tableView.header endRefreshing];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
