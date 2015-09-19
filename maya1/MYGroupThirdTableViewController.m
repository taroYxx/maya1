//
//  MYGroupThirdTableViewController.m
//  maya1
//
//  Created by Taro on 15/8/8.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYGroupThirdTableViewController.h"
#import "MYGroupCar.h"
#import "MYStatueViewController.h"
#import "AFNetworking.h"
#import "MYtotalViewController.h"
#import "MYGroupAddCarViewController.h"
@interface MYGroupThirdTableViewController ()
@property (nonatomic ,strong) NSArray *result;
@property (nonatomic ,strong) NSString *pickcarID;
@end

@implementation MYGroupThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self datagroups];
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"car" style:UIBarButtonItemStylePlain target:self action:@selector(addcartogroup)];
    
    self.navigationItem.rightBarButtonItem = edit;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addcartogroup{
    MYGroupAddCarViewController *addcar = [[MYGroupAddCarViewController alloc] init];
    addcar.pickGroupName = _groupname;
    addcar.idgroup = _idvirtualgroup;
    [self.navigationController pushViewController:addcar animated:YES];
    
}

- (NSArray *)datagroups{
    
    NSArray *arrayDict = _carsid;
    NSLog(@"22222%@",_carsid);
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYGroupCar *data =[MYGroupCar resultWithDic:dict];
        [ arrayModels addObject:data];
    }
    _result = arrayModels;
    
    return _result;
    
    
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _carsid.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //    MYDepartment *department = _datagroups[indexPath.row];
    MYGroupCar *groupcar = _result[indexPath.row];
    cell.textLabel.text = groupcar.license;
    _pickcarID = groupcar.idcar;
//    cell.detailTextLabel.text = [ NSString stringWithFormat:@"%@",groupcar.idcar];
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
    MYGroupCar *groupcar = _result[indexPath.row];
    MYStatueViewController *status = [[MYStatueViewController alloc] init];
    status.carid = groupcar.idcar;
    status.license = groupcar.license;
    
    [self.navigationController pushViewController:status animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    MYGroupCar *group = _result[indexPath.row];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcars": @[
                                                 group.idcar
                                                 ],
                                         @"idgroup":_idvirtualgroup
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/rmfromvirtualgroup.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             if ([operation.response statusCode] == 200) {
                                                                                 UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"delet success" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                                                                 [alertView show];
                                                                                 [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                 
                                                                                 
                                                                             }
                                                                             NSLog(@"HTTP Response Body: %@", responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
    
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
