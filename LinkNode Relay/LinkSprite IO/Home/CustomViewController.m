//
//  CustomViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/9/21.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) UISwitch *SwitchR1;
@property (nonatomic,strong) UISwitch *SwitchR2;
@property (nonatomic,strong) UISwitch *SwitchR3;
@property (nonatomic,strong) UISwitch *SwitchR4;

@property (nonatomic,strong) UIButton *but1;
@property (nonatomic,strong) UIButton *but2;
@property (nonatomic,strong) UIButton *but3;
@property (nonatomic,strong) UIButton *but4;

@property (nonatomic,strong) UITextField *nameTF;

@property (nonatomic,strong) NSMutableDictionary *params;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.listTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.listTableView.separatorColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    self.listTableView.backgroundColor = [UIColor whiteColor];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.navigationItem setTitle:@"Custom switches"];
    [self.view addSubview:self.listTableView];
    
    
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.scrollEnabled =NO;
    tableView.tableFooterView = [[UIView alloc] init];
    
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        _but1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
        [_but1 setTitle:@"enter the switch status" forState:UIControlStateNormal];
        _but1.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but1.layer.cornerRadius = 5;
        _but1.layer.masksToBounds = YES;
        
        [_but1 addTarget:self action:@selector(nextR1) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR1= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR1 addTarget:self action:@selector(switchActionR1) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL sw = [userDefaults boolForKey:@"switchValue1"];
        [_SwitchR1 setOn:sw];
        //UITextField
        NSString *str = [userDefaults stringForKey:@"inputValue1"];
        [_but1 setTitle:str forState:UIControlStateNormal];
        NSLog(@"inputValue1=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR1];
        [cell.contentView addSubview:_but1];
        
    }if (indexPath.row == 1) {
        _but2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
        [_but2 setTitle:@"enter the switch status" forState:UIControlStateNormal];
        _but2.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but2.layer.cornerRadius = 5;
        _but2.layer.masksToBounds = YES;
        [_but2 addTarget:self action:@selector(nextR2) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR2= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR2 addTarget:self action:@selector(switchActionR2) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL sw = [userDefaults boolForKey:@"switchValue2"];
        [_SwitchR2 setOn:sw];
        //UITextField
        NSString *str = [userDefaults stringForKey:@"inputValue2"];
        [_but2 setTitle:str forState:UIControlStateNormal];
        NSLog(@"inputValue2=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR2];
        [cell.contentView addSubview:_but2];
        
    }if (indexPath.row == 2) {
        _but3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
        [_but3 setTitle:@"enter the switch status" forState:UIControlStateNormal];
        _but3.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but3.layer.cornerRadius = 5;
        _but3.layer.masksToBounds = YES;
        
        [_but3 addTarget:self action:@selector(nextR3) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR3= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR3 addTarget:self action:@selector(switchActionR3) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL sw = [userDefaults boolForKey:@"switchValue3"];
        [_SwitchR3 setOn:sw];
        //UITextField
        NSString *str = [userDefaults stringForKey:@"inputValue3"];
        [_but3 setTitle:str forState:UIControlStateNormal];
        NSLog(@"inputValue3=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR3];
        [cell.contentView addSubview:_but3];
        
    }if (indexPath.row == 3) {
        _but4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
        [_but4 setTitle:@"enter the switch status" forState:UIControlStateNormal];
        _but4.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but4.layer.cornerRadius = 5;
        _but4.layer.masksToBounds = YES;
        [_but4 addTarget:self action:@selector(nextR4) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR4= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR4 addTarget:self action:@selector(switchActionR4) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL sw = [userDefaults boolForKey:@"switchValue4"];
        [_SwitchR4 setOn:sw];
        //UITextField
        NSString *str = [userDefaults stringForKey:@"inputValue4"];
        [_but4 setTitle:str forState:UIControlStateNormal];
        NSLog(@"inputValue4=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR4];
        [cell.contentView addSubview:_but4];
        
    }
    return cell;
}
-(void)nextR1{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"State" message:@"Please enter the switch status,such as:1001010...(Click switch to send)" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"switch state";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_but1 setTitle:_nameTF.text forState:UIControlStateNormal];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_but1.titleLabel.text forKey:@"inputValue1"];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)switchActionR1{
    if(!_SwitchR1.on){
        
    [_but1 setTitle:@"Has reset" forState:UIControlStateNormal];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 0 forKey:@"switchValue1"];
        
    }else if(_SwitchR1.on){

        [self.SwitchR2 setOn:NO];
        [self.SwitchR3 setOn:NO];
        [self.SwitchR4 setOn:NO];
        
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setTimeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 1 forKey:@"switchValue1"];
        [defaults setBool:_SwitchR2.on forKey:@"switchValue2"];
        [defaults setBool:_SwitchR3.on forKey:@"switchValue3"];
        [defaults setBool:_SwitchR4.on forKey:@"switchValue4"];

        NSString *Sting = [defaults objectForKey:@"jwt"];
        NSString *Sting2 = @"Bearer ";
        NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
        [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
        _params = [[NSMutableDictionary alloc]init];
        [_params setObject:_but1.titleLabel.text forKey:@"relays"];
        NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
        NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
        [par setObject:@"update" forKey:@"action"];
        
        NSString *devID = [defaults objectForKey:@"deviceID"];
        
        [par setObject:devID forKey:@"deviceid"];
        [par setObject:loginkey forKey:@"apikey"];
        [par setObject:_params forKey:@"params"];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:par options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = jsonData;
        NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
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
                NSLog(@"解析数据===>%@",dict);
            }
        }];
        
        [dataTask resume];

    }
}
-(void)nextR2{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"State" message:@"Please enter the switch status,such as:1001010...(Click switch to send)" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"switch state";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_but2 setTitle:_nameTF.text forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_but2.titleLabel.text forKey:@"inputValue2"];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)switchActionR2{
    if(!_SwitchR2.on){
        
        [_but2 setTitle:@"Has reset" forState:UIControlStateNormal];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 0 forKey:@"switchValue2"];

        
    }else if(_SwitchR2.on){
       
        [self.SwitchR1 setOn:NO];
        [self.SwitchR3 setOn:NO];
        [self.SwitchR4 setOn:NO];
        
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setTimeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 1 forKey:@"switchValue2"];
        [defaults setBool:_SwitchR1.on forKey:@"switchValue1"];
        [defaults setBool:_SwitchR3.on forKey:@"switchValue3"];
        [defaults setBool:_SwitchR4.on forKey:@"switchValue4"];

        NSString *Sting = [defaults objectForKey:@"jwt"];
        NSString *Sting2 = @"Bearer ";
        NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
        [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
        _params = [[NSMutableDictionary alloc]init];
        
        [_params setObject:_but2.titleLabel.text forKey:@"relays"];
        NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
        NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
        [par setObject:@"update" forKey:@"action"];
        
        NSString *devID = [defaults objectForKey:@"deviceID"];
        
        [par setObject:devID forKey:@"deviceid"];
        [par setObject:loginkey forKey:@"apikey"];
        [par setObject:_params forKey:@"params"];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:par options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = jsonData;
        NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
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
                NSLog(@"解析数据===>%@",dict);
            }
        }];
        
        [dataTask resume];
        
    }

}
-(void)nextR3{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"State" message:@"Please enter the switch status,such as:1001010...(Click switch to send)" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"switch state";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_but3 setTitle:_nameTF.text forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_but3.titleLabel.text forKey:@"inputValue3"];

    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)switchActionR3{
    
    if(!_SwitchR3.on){
        
        [_but3 setTitle:@"Has reset" forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 0 forKey:@"switchValue3"];
        
    }else if(_SwitchR3.on){
        
        [self.SwitchR1 setOn:NO];
        [self.SwitchR2 setOn:NO];
        [self.SwitchR4 setOn:NO];
        
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setTimeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 1 forKey:@"switchValue3"];
        [defaults setBool:_SwitchR1.on forKey:@"switchValue1"];
        [defaults setBool:_SwitchR2.on forKey:@"switchValue2"];
        [defaults setBool:_SwitchR4.on forKey:@"switchValue4"];
        
        NSString *Sting = [defaults objectForKey:@"jwt"];
        NSString *Sting2 = @"Bearer ";
        NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
        [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
        _params = [[NSMutableDictionary alloc]init];
        
        [_params setObject:_but3.titleLabel.text forKey:@"relays"];
        NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
        NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
        [par setObject:@"update" forKey:@"action"];
        
        NSString *devID = [defaults objectForKey:@"deviceID"];
        
        [par setObject:devID forKey:@"deviceid"];
        [par setObject:loginkey forKey:@"apikey"];
        [par setObject:_params forKey:@"params"];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:par options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = jsonData;
        NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
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
                NSLog(@"解析数据===>%@",dict);
            }
        }];
        
        [dataTask resume];
        
    }

    
}
-(void)nextR4{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"State" message:@"Please enter the switch status,such as:1001010...(Click switch to send)" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"switch state";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_but4 setTitle:_nameTF.text forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_but4.titleLabel.text forKey:@"inputValue4"];

    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)switchActionR4{
    
    if(!_SwitchR4.on){
        
        [_but4 setTitle:@"Has reset" forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 0 forKey:@"switchValue4"];
        
    }else if(_SwitchR4.on){
        
        [self.SwitchR1 setOn:NO];
        [self.SwitchR3 setOn:NO];
        [self.SwitchR2 setOn:NO];
        
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setTimeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: 1 forKey:@"switchValue4"];
        [defaults setBool:_SwitchR1.on forKey:@"switchValue1"];
        [defaults setBool:_SwitchR2.on forKey:@"switchValue2"];
        [defaults setBool:_SwitchR3.on forKey:@"switchValue3"];

        NSString *Sting = [defaults objectForKey:@"jwt"];
        NSString *Sting2 = @"Bearer ";
        NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
        [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
        _params = [[NSMutableDictionary alloc]init];
        
        [_params setObject:_but4.titleLabel.text forKey:@"relays"];
        NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
        NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
        [par setObject:@"update" forKey:@"action"];
        
        NSString *devID = [defaults objectForKey:@"deviceID"];
        
        [par setObject:devID forKey:@"deviceid"];
        [par setObject:loginkey forKey:@"apikey"];
        [par setObject:_params forKey:@"params"];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:par options:NSJSONWritingPrettyPrinted error:&error];
        request.HTTPBody = jsonData;
        NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
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
                NSLog(@"解析数据===>%@",dict);
            }
        }];
        
        [dataTask resume];
        
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
