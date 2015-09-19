//
//  MYGroupSecondTableViewController.m
//  maya1
//
//  Created by Taro on 15/8/8.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYGroupSecondTableViewController.h"
#import "MYchildvirtualgroup.h"
#import "MYGroupThirdTableViewController.h"
#import "AFNetworking.h"
#import "MYsecond.h"
#import "MYStatueViewController.h"
#import "MYtotalViewController.h"
#import "MYGroupAddCarViewController.h"
@interface MYGroupSecondTableViewController ()
@property (nonatomic , strong)NSArray *result;
@property (nonatomic , strong)NSArray *resultcar;
@property (nonatomic , strong)NSString *thisGroupID;
@property (nonatomic , strong) NSString *pickcarID;


//@property (strong, nonatomic) UIPickerView *selectPicker;
@end

@implementation MYGroupSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.view addSubview:self.selectPicker];
    
    UIButton *cars = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cars.frame = CGRectMake(0, 0, 50, 30);
    
    [cars setTitle:@"car" forState:UIControlStateNormal];
    [cars addTarget:self action:@selector(addChildCar) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addcar = [[UIBarButtonItem alloc] initWithCustomView:cars];
    UIButton *group = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    group.frame = CGRectMake(0, 0, 50, 30);
    [group setTitle:@"group" forState:UIControlStateNormal];
    [group addTarget:self action:@selector(addgroup) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addgroup = [[UIBarButtonItem alloc] initWithCustomView:group];
    
    
    self.navigationItem.rightBarButtonItems = @[addcar,addgroup];
    
    
    
    
    self.navigationItem.rightBarButtonItem = addcar;
    
    [self datagroups];
    [self getcars];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addChildCar{
    MYGroupAddCarViewController *addcar = [[MYGroupAddCarViewController alloc] init];
    addcar.pickGroupName = _pickgroupName;
    addcar.idgroup = _idgroup;
    [self.navigationController pushViewController:addcar animated:YES];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Car" message:@"Please select a car." preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        UITextField *name = alertController.textFields.firstObject;
//        name.inputView = self.selectPicker;
//    }];
//    
//    [alertController addAction:cancelAction];
//    
//    [alertController addAction:okAction];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"name";
//    }];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
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
                                             @"name": name.text,
                                             @"parentvirtualgroup": _idgroup
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
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}

- (NSArray *)datagroups{
    
    NSArray *arrayDict = _datagroup;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYchildvirtualgroup *data =[MYchildvirtualgroup MYchildvirtualgroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _result = arrayModels;
    
    return _result;
    
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
      return _result.count;
    }else{
        return _cars.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
 
    
    if (indexPath.section == 0) {
    MYchildvirtualgroup *group = _result[indexPath.row];
       
    cell.textLabel.text = group.name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",group.idvirtualgroup];
    cell.imageView.image = [UIImage imageNamed:@"group"];
        _thisGroupID = group.idvirtualgroup;
//        _pickgroupName = group.name;
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn3.frame = CGRectMake(325, 10, 50, 30);
        [btn3 setTitle:@"stats" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(gettotaldata) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn3];
    }
    else{
        
        MYsecond *carofgroup = _resultcar[indexPath.row];
     
        cell.textLabel.text = carofgroup.license;
        _pickcarID = carofgroup.idcar;
//        cell.detailTextLabel.text = carofgroup.idcar;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",carofgroup.idcar];
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn4.frame = CGRectMake(325, 10, 50, 30);
        [btn4 setTitle:@"stats" forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(carToTotal) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn4];

        
    }
    
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
    total.iddepartment = _thisGroupID;
    total.posttype = @3;
    [self.navigationController pushViewController:total animated:YES];
}



- (NSArray *)getcars{
    
    NSArray *arrayDict = _cars;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYsecond *data =[MYsecond resultWithDic:dict];
        [ arrayModels addObject:data];
    }
    _resultcar = arrayModels;
    
    return _resultcar;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    MYchildvirtualgroup *group = _result[indexPath.row];
    MYGroupThirdTableViewController *third = [[MYGroupThirdTableViewController alloc] init];
    
    third.carsid = group.cars;
    third.idvirtualgroup = group.idvirtualgroup;
        third.groupname = group.name;
    [self.navigationController pushViewController:third animated:YES];
    }else{
        MYStatueViewController *status = [[MYStatueViewController alloc] init];
        MYsecond *carofgroup = _resultcar[indexPath.row];
        status.carid = carofgroup.idcar;
        status.license = carofgroup.license;
        [self.navigationController pushViewController:status animated:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

    MYchildvirtualgroup *group = _result[indexPath.row];
    
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
                   [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                
                                                                                 
                                                                             }
            else{
   UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"there are some problem." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];}
                                                                             
                                                                             
                                                                             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    }
    else{
        MYsecond *secondcar = _resultcar[indexPath.row];
      
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // JSON Body
        NSDictionary* bodyObject = @{
                                     @"data": @{
                                             @"idcars": @[
                                                     secondcar.idcar
                                                     ],
                                             @"idgroup":_idgroup
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
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Group Name ";
    }else{
        return @" Cars";
    }
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
