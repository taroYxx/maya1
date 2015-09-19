//
//  MYaddToGroupViewController.m
//  maya1
//
//  Created by Taro on 15/8/12.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYaddToGroupViewController.h"
#import "AFNetworking.h"
#import "MYGroupName.h"
#import "MYGroupTableViewController.h"

@interface MYaddToGroupViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (strong, nonatomic) UIPickerView *selectPicker;
//@property (nonatomic ,strong) NSArray *selectarray;
@property (nonatomic ,strong) UILabel *content;
@property (nonatomic , strong) NSArray *temp;
@property (nonatomic , strong) NSArray *datagroups;
@property (nonatomic , strong) NSNumber *idgroup;

@end

@implementation MYaddToGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    _selectarray = [NSArray arrayWithObjects:@"aa",@"bb",@"cc", nil];
    
        self.selectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 75, 375, 300)];
    self.selectPicker.backgroundColor = [UIColor whiteColor];
    self.selectPicker.delegate = self;
    self.selectPicker.dataSource = self;
    [self.view addSubview:self.selectPicker];
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(175/2, 350, 200, 50)];
//    name.backgroundColor = [UIColor blueColor];
    name.text = [NSString stringWithFormat:@"Add     %@     to ",_license];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setTextColor:[UIColor orangeColor]];
    [self.view addSubview:name];
    
    UIButton *add = [[UIButton alloc] initWithFrame:CGRectMake(175/2, 450, 200, 50)];
    [add setTitle:@"OK" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addcartogroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    self.content = [[UILabel alloc] initWithFrame:CGRectMake(175/2, 400, 200, 50)];
    [self.content setTextAlignment:  NSTextAlignmentCenter];
    [self.view addSubview:self.content];
    [self getDataFrom:^(NSMutableArray *array) {
        NSLog(@"%@",array[0][@"name"]);
        _temp = array;
        [ self datagroups];
    
       
        [self.selectPicker reloadAllComponents];
    }];
    
}

-(void)getDataFrom:(void(^)( NSMutableArray  * array))success{
    
    
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc]init];
    [mgr GET:@"http://120.26.83.51:8080/maya/demo/virtualgroup/getallvirtualgroups.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    NSArray *arrayDict = _temp;
    NSMutableArray *arrayModels = [NSMutableArray array];
    for (NSDictionary *dict in arrayDict) {
        MYGroupName *data =[MYGroupName CarsGroupWithDic:dict];
        [ arrayModels addObject:data];
    }
    _datagroups = arrayModels;
    
    return _datagroups;
    
    
}


-(void)addcartogroup{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // JSON Body
    NSDictionary* bodyObject = @{
                                 @"data": @{
                                         @"idcars": @[
                                                 _idcar
                                                 ],
                                         @"idgroup": _idgroup
                                         }
                                 };
    
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://120.26.83.51:8080/maya/demo/carinfo/addtovirtualgroup.do" parameters:bodyObject error:NULL];
    
    // Fetch Request
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
        if(responseObject){
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil   message:@"success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertView show];
            [self.navigationController popToRootViewControllerAnimated:YES];
                                                                                 
                                                                             }
                                                                             
                                                                             NSLog(@"HTTP Response Body: %@", responseObject);
                                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"The car is already in the group or there are Network problem "    message:@"please select another car or wait try again" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                                                             [alertView show];

                                                                             NSLog(@"HTTP Request failed: %@", error);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    return _datagroups.count;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    MYGroupName *group = _datagroups[row];
    return group.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    MYGroupName *group = _datagroups[row];
    self.content.text = group.name;
    _idgroup = group.id;
    
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
