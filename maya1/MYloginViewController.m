//
//  MYloginViewController.m
//  maya1
//
//  Created by Taro on 15/7/23.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import "MYloginViewController.h"
#import "MYTabBarViewController.h"

@interface MYloginViewController ()<UITextFieldDelegate >

@property (nonatomic , weak) UITextField * usernameText;
@property (nonatomic , weak) UITextField * passwordText ;

@end

@implementation MYloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%f  %f",self.view.frame.size.height,self.view.frame.size.width);
    UIView *base = [[UIView alloc] init];
    base.frame = CGRectMake(20, 100, 335, 155);
    base.backgroundColor = [UIColor yellowColor];
    UILabel *a = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 100, 35)];
    a.text = @"USERNAME";
    [base addSubview:a];
    UILabel *b = [[UILabel alloc] initWithFrame:CGRectMake(5, 95, 100, 35)];
    b.text = @"PASSWORD";
    [base addSubview:b];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(110, 30, 200, 35)];
    username.backgroundColor = [UIColor whiteColor];
    username.borderStyle = UITextBorderStyleRoundedRect;
    username.placeholder = @"please input accout";
    username.delegate = self;
    username.clearButtonMode = UITextFieldViewModeNever;
    self.usernameText = username;
    [base addSubview:username];
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(110, 95, 200, 35)];
    password.backgroundColor = [UIColor whiteColor];
    password.delegate = self;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.placeholder = @"please input password";
    password.clearButtonMode = UITextFieldViewModeNever;
    password.secureTextEntry = YES;
    
    
    self.passwordText = password;
    [base addSubview:password];
    [self.view addSubview:base];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 180, 35)];
//    btn.backgroundColor = [UIColor redColor];
    UIImage *image = [UIImage imageNamed:@"button"];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setTitle:@"LOGIN" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)login:(UIButton *)btn
{
    
    NSString *urlString = @"http://120.26.83.51:8080/maya/demo/user/login";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. 可变的请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    
    // 2.1 指定http的访问方法，服务器短才知道如何访问
    request.HTTPMethod = @"POST";
    
    // 2.2 指定数据体，数据体的内容可以从firebug里面直接拷贝
    // username=zhangsan&password=zhang
    NSString *username = self.usernameText.text;
    NSString *pwd = self.passwordText.text;
    NSString *bobyStr = [NSString stringWithFormat:@"j_username=%@&j_password=%@", username, pwd];
        request.HTTPBody = [bobyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    // 3. 连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
//         NSLog(@"%lu",data.length);
    
         NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//转换数据格式

        NSString *result = content[@"status"];
         if ([result isEqualToString:@"success"]) {
             

             NSString *home = NSHomeDirectory();
             NSArray *message = @[@"登入成功"];
             NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
             NSLog(@"%@",docPath);
             NSString *filePath = [docPath stringByAppendingPathComponent:@"data.plist"];
             [message writeToFile:filePath atomically:YES];
             
          
             

             UIWindow *window = [UIApplication sharedApplication].keyWindow;
             MYTabBarViewController *tab = [[MYTabBarViewController alloc] init];
             window.rootViewController = tab;
     
             
         }
         else
         {
             
             UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"系统信息" message:@"用户名或密码错误，请重新输入！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
             [alertView show];
             
         }
         
         //        NSLog(@"111%@",[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies);
         
     }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
