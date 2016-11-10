//
//  LoginViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/8/26.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "PasswordTableViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberMeSwitch;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    if(self.rememberMeSwitch.on){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *email = [defaults objectForKey:@"emailTextField"];
        NSString *password = [defaults objectForKey:@"passwordTextField"];
        [_emailTextField setText: email];
        [_passwordTextField setText: password];
        
    }else if(!self.rememberMeSwitch.on){
        
        [_passwordTextField setText:@""];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (IBAction)Login:(id)sender {
    
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/user/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    //NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.emailTextField.text,@"email",self.passwordTextField.text,@"password", nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.emailTextField.text forKey:@"email"];
    [params setObject:self.passwordTextField.text forKey:@"password"];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    
    request.HTTPBody = jsonData;
    NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 如果请求成功，则解析数据。
        //判断是否成功
        if(error)
        {
            NSLog(@"error1=======%@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loginerror];
            });
        }
        else
        {
        // 如果请求成功，则解析数据。
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *array = [dict objectForKey:@"user"];
        NSDictionary *jwt = [dict objectForKey:@"jwt"];
        NSArray *Strr = [array objectForKey:@"apikey"];
        NSLog(@"____>%@",Strr);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:Strr forKey:@"Loginapikey"];
        [defaults setObject:array forKey:@"User"];
        [defaults setObject:jwt forKey:@"jwt"];
            
        [defaults setObject:self.emailTextField.text forKey:@"emailTextField"];
        [defaults setObject:self.passwordTextField.text forKey:@"passwordTextField"];
            
        [defaults synchronize];
        NSLog(@"===>%@",dict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self Login];
        });
            }
    }];
    
    [dataTask resume];
        
}
-(void)Login{
    if (self.emailTextField.text.length == 0 | self.passwordTextField.text.length == 0) {
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Log In"message:@"Email address and password must not be empty!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
        
    }else if (self.emailTextField.text.length != 0 | self.passwordTextField.text.length != 0 ) {
        
        //取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *array = [defaults objectForKey:@"User"];
        NSLog(@"array->%@",array);
        NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
        
        NSString *Sigkey = [defaults objectForKey:@"Sigapikey"];
        NSLog(@"Sigapikey ->%@,,,Loginapikey->%@",Sigkey,loginkey);
        
        if ([Sigkey isEqualToString: loginkey] | (loginkey != nil) && array != nil) {
            NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/user/device"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
            [request setTimeoutInterval:10.0];
            [request setHTTPMethod:@"GET"];
            [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *Sting = [defaults objectForKey:@"jwt"];
            NSString *Sting2 = @"Bearer ";
            NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
            [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];

            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error)
                {
                    NSLog(@"error1=======%@", error.localizedDescription);
                }
                else
                {
                    // 如果请求成功，则解析数据。
                   NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    //NSLog(@"dict->%@",dict);
                    NSMutableArray  *muarrayID=[[NSMutableArray alloc]init];
                    
                    NSMutableArray *muarrayname = [[NSMutableArray alloc]init];
                    for (int i = 0; i < dict.count; i++) {
                        NSDictionary * devid = [dict objectAtIndex:i];
                        NSString *ID = [devid objectForKey:@"deviceid"];
                        [muarrayID addObject:ID];
                        
                        NSString *name = [devid objectForKey:@"name"];
                        
                        NSString *type = [devid objectForKey:@"type"];
                        
                        NSMutableDictionary *mudic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:type,@"Type",name,@"name", nil];
                        //NSLog(@"nudic==>%@",mudic);
                        [muarrayname addObject:mudic];
                    }
                    NSLog(@"ID..>%@...>%ld条",muarrayID,(unsigned long)muarrayID.count);
                    //NSLog(@"name%@",muarrayname);
                    [defaults setObject:muarrayname forKey:@"LoginDevicenames"];
                    //[defaults setObject:dict forKey:@"LoginDeviceids"];
                    //NSLog(@"dict>>%@",dict);
                    [defaults setObject:muarrayID forKey:@"devlist"];
                    [defaults synchronize];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self home];
                    });
                }
            }];
            [dataTask resume];
            
        }else{
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *Strr = [defaults objectForKey:@"Loginapikey"];
            NSLog(@"Loginapikey->%@",Strr);
            
            UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Log In"message:@"Wrong user name or password, please enter your registered account!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
-(void)home{
    //将我们的storyBoard实例化，“Home”为StoryBoard的名称
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    //将第二个控制器实例化，"LoginViewController"为我们设置的控制器的ID
    HomeViewController *HomeSreenView = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    //跳转事件
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:HomeSreenView];//将普通视图添加到NavigationController
    [self presentViewController:nv animated:YES completion:nil];

}
- (IBAction)Switch:(id)sender {
    if (self.rememberMeSwitch.on) {
        NSLog(@"保存密码");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *email = [defaults objectForKey:@"emailTextField"];
        NSString *password = [defaults objectForKey:@"passwordTextField"];
        NSLog(@"email->%@\n password->%@",email,password);
        
    }else if(!self.rememberMeSwitch.on){
        NSLog(@"不保存密码");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [_passwordTextField setText:@""];
        [defaults setObject:_passwordTextField.text forKey:@"passwordTextField"];
        [defaults synchronize];
        NSLog(@"password->%@",_passwordTextField.text);
    }
}
-(void)loginerror{
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Login"message:@"Network the request timed out!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"LoginCell"forIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    if(self.rememberMeSwitch.on){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *email = [defaults objectForKey:@"emailTextField"];
        NSString *password = [defaults objectForKey:@"passwordTextField"];
        
        if (indexPath.row == 0) {
            _emailTextField.text  = email;
        }
        if (indexPath.row == 1) {
            _passwordTextField.text  = password;
            //[self.passwordTextField addSubview:self.passwordTextField];
        }
        
    }

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
