//
//  SignUpViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/8/26.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//


#import "SignUpViewController.h"
#import "NSString+Validation.h"
#import "LoginViewController.h"


@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property BOOL emailValidates;
@property BOOL passwordValidates;
@property NSIndexPath *editingTextFieldIndexPath;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.tableView.estimatedRowHeight = 66.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.emailValidates = NO;
    self.passwordValidates = NO;

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL rowValidates = NO;
    
    switch (indexPath.row) {
        case 0:
            rowValidates = self.emailValidates;
            break;
        case 1:
            rowValidates = self.passwordValidates;
            break;
               default:
            break;
    }
    return rowValidates ? 44.0 : 66.0;
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.emailTextField) {
        self.editingTextFieldIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    } else if (textField == self.passwordTextField) {
        self.editingTextFieldIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    } else {
        return;
    }

}


#pragma mark - segue related methods


- (IBAction)NEXT:(UIButton *)sender {
    
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/user/register"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:self.emailTextField.text forKey:@"email"];
    [params setObject:self.passwordTextField.text forKey:@"password"];
    [params setObject:@"The user response token provided by the reCAPTCHA to the user." forKey:@"response"];
    
    //NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"168@qq.com",@"email",@"654321",@"password",@"The user response token provided by the reCAPTCHA to the user.",@"response", nil];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;

    NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //判断是否成功
        if(error)
        {
            NSLog(@"error1=======%@", error.localizedDescription);
        }
        else
        {
            // 如果请求成功，则解析数据。
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            // 判断是否解析成功
            if (error)
            {
                NSLog(@"error2=======%@", error.localizedDescription);
                
            }
            else
            {
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                //NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                //NSString *home = NSHomeDirectory();

                //NSString *filePath = [home stringByAppendingPathComponent:@"SigupPath.plist"];
                //[dict writeToFile:filePath atomically:YES];
                NSLog(@"===>%@",dict);
                
                NSDictionary *array = [dict objectForKey:@"user"];
                NSArray *Strr = [array objectForKey:@"apikey"];
                NSLog(@"....._>%@",Strr);
                //存
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:Strr forKey:@"Sigapikey"];
                [defaults synchronize];
                
                if (Strr == nil) {
                    NSString *str = [dict objectForKey:@"error"];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:str forKey:@"errors"];
                    NSLog(@"str==>%@",str);
                    
                    [defaults synchronize];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self SignUp];
                        
                    });
                }
            }
        }
           }];
       [dataTask resume];
}

-(void)SignUp{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *errors = [defaults objectForKey:@"errors"];
    NSLog(@"errors==>%@",errors);
    if (self.emailTextField.text.length == 0 | self.passwordTextField.text.length == 0 ) {
    
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"CREATE"message:errors preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"注册失败");
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    }else if (self.emailTextField.text.length !=0 | self.passwordTextField.text.length != 0 /*| [defaults objectForKey:@"apikey"] != nil*/) {
        UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"CREATE"message:errors preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[self navigationController] popViewControllerAnimated:YES];
            NSLog(@"注册成功");
           
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    }else{
        UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"CREATE"message:errors preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[self navigationController] popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    
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


