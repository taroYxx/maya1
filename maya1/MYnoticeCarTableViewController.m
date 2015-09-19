//
//  MYnoticeCarTableViewController.m
//  maya1
//
//  Created by Taro on 15/8/10.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYnoticeCarTableViewController.h"
#import "AFNetworking.h"
#import "MYnotice.h"
#import "MYnoticedetailViewController.h"
#import "MJRefresh.h"

@interface MYnoticeCarTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray *datagroups;
@property (nonatomic , strong) NSArray *temp;
@end

@implementation MYnoticeCarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [ MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.header beginRefreshing];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getDataFrom:^(NSMutableArray *array) {
        _temp = array;
        [self datagroups];
        NSLog(@"%@",_datagroups);
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDataFrom:(void(^)( NSMutableArray  * array))success{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"level": @1
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/warning/pullwarning.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
        NSLog(@"HTTP Response Body: %@", responseObject);
                 NSMutableArray *array = responseObject[@"data"];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if (success) {
                        success(array);
                    }
                }];

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
 
    
    
}

- (NSArray *)datagroups{
    
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYnotice *data =[MYnotice noticeGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _datagroups = arrayModels;
    
    return _datagroups;
    
    
}


#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _datagroups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    MYnotice *notice = _datagroups[indexPath.row];
    cell.textLabel.text =notice.data;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",notice.idcar];
    
    //    cell.detailTextLabel.text = cardata.license;
    //    cell.imageView.image = [UIImage imageNamed:@"car1"];
    //
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MYnoticedetailViewController *detail = [[MYnoticedetailViewController alloc] init];
    MYnotice *notice = _datagroups[indexPath.row];
    detail.data = notice.data;
    detail.idcar = notice.idcar;
    detail.idwarning = notice.idwarning;
    detail.level = notice.level;
    detail.license = notice.license;
    detail.receivedUser = notice.receivedUser;
       [self.navigationController pushViewController:detail animated:YES];
}

- (void)loadNewData
{
    [self getDataFrom:^(NSMutableArray *array) {
        _temp = array;
        [self datagroups];
        NSLog(@"%@",_datagroups);
        [self.tableView reloadData];
    }];
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
