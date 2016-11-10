//
//  DevViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/9/13.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import "DevViewController.h"

@interface DevViewController ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation DevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
 
    self.view.backgroundColor = [UIColor whiteColor];
     self.listTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.listTableView.separatorColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    //[self setExtraCellLineHidden:self.listTableView];
    //[self.listTableView setSeparatorInset:UIEdgeInsetsZero];
    //[self.listTableView setLayoutMargins:UIEdgeInsetsZero];
    self.listTableView.backgroundColor = [UIColor whiteColor];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.navigationItem setTitle:@"Four-way relay"];
    [self.view addSubview:self.listTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _but1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
    [_but1 setTitle:@"R1" forState:UIControlStateNormal];
    _but1.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but1.layer.cornerRadius = 5;
        _but1.layer.masksToBounds = YES;
    [_but1 addTarget:self action:@selector(nextR1) forControlEvents:UIControlEventTouchUpInside];
    self.SwitchR1= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
    [self.SwitchR1 addTarget:self action:@selector(switchActionR1) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        NSLog(@"--%@",sww);
        //BOOL sw = [sww substringToIndex:1];
        BOOL sw= [[sww substringWithRange:NSMakeRange(0,1)] intValue];
        NSLog(@"_SwitchR1=%d",sw);
        [_SwitchR1 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:0];
        [_but1 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        
    [cell.contentView addSubview:self.SwitchR1];
    [cell.contentView addSubview:_but1];
        
    }if (indexPath.row == 1) {
        _but2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but2 setTitle:@"R2" forState:UIControlStateNormal];
        _but2.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but2.layer.cornerRadius = 5;
        _but2.layer.masksToBounds = YES;
        [_but2 addTarget:self action:@selector(nextR2) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR2= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR2 addTarget:self action:@selector(switchActionR2) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        //BOOL sw = [sww substringToIndex:1];
        BOOL sw= [[sww substringWithRange:NSMakeRange(1,1)] intValue];
        NSLog(@"_SwitchR2=%d",sw);
        [_SwitchR2 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:1];
        [_but2 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR2];
        [cell.contentView addSubview:_but2];

    }if (indexPath.row == 2) {
        _but3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but3 setTitle:@"R3" forState:UIControlStateNormal];
        _but3.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but3.layer.cornerRadius = 5;
        _but3.layer.masksToBounds = YES;
        [_but3 addTarget:self action:@selector(nextR3) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR3= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR3 addTarget:self action:@selector(switchActionR3) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        //BOOL sw = [sww substringToIndex:1];
        BOOL sw= [[sww substringWithRange:NSMakeRange(2,1)] intValue];
        NSLog(@"_SwitchR3=%d",sw);
        [_SwitchR3 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:2];
        [_but3 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR3];
        [cell.contentView addSubview:_but3];
        
    }if (indexPath.row == 3) {
        _but4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but4 setTitle:@"R4" forState:UIControlStateNormal];
        _but4.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but4.layer.cornerRadius = 5;
        _but4.layer.masksToBounds = YES;
        [_but4 addTarget:self action:@selector(nextR4) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR4= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
            [self.SwitchR4 addTarget:self action:@selector(switchActionR4) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        BOOL sw= [[sww substringWithRange:NSMakeRange(3,1)] intValue];
        NSLog(@"_SwitchR4=%d",sw);
        [_SwitchR4 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:3];
        [_but4 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR4];
        [cell.contentView addSubview:_but4];
        
    }
    return cell;
}
-(void)nextR1{
    NSLog(@"点击R1");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        //_nameTF = alert.textFields.firstObject;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self editR1];
    }];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)editR1{
   
    [_but1 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];

}

-(void)switchActionR1{
    NSLog(@"switchActionR1");
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *Sting = [defaults objectForKey:@"jwt"];
    NSString *Sting2 = @"Bearer ";
    NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
    [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
    _params = [[NSMutableDictionary alloc]init];
    
    [self Switch];
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

-(void)nextR2{
    NSLog(@"点击R2");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF = textField;
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self editR2];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)editR2{
    [_but2 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR2{
    NSLog(@"switchActionR2");
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *Sting = [defaults objectForKey:@"jwt"];
    NSString *Sting2 = @"Bearer ";
    NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
    [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
    _params = [[NSMutableDictionary alloc]init];
    
    [self Switch];
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

-(void)nextR3{
    NSLog(@"点击R3");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF = textField;
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editR3];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)editR3{
    [_but3 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR3{
    NSLog(@"switchActionR3");
    
        NSLog(@"打开按钮");
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setTimeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *Sting = [defaults objectForKey:@"jwt"];
        NSString *Sting2 = @"Bearer ";
        NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
        [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
        _params = [[NSMutableDictionary alloc]init];
    
        [self Switch];
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
-(void)nextR4{
    NSLog(@"点击R4");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF = textField;
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self editR4];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)editR4{

    [_but4 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR4{
    NSLog(@"switchActionR4");
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setTimeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *Sting = [defaults objectForKey:@"jwt"];
        NSString *Sting2 = @"Bearer ";
        NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
        [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
        _params = [[NSMutableDictionary alloc]init];
    
        [self Switch];
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
-(void)Switch{
    
    if (self.SwitchR4.on && !self.SwitchR1.on && !self.SwitchR2.on && !self.SwitchR3.on) {
        [_params setObject:@"0001" forKey:@"relays"];
    }else if(!self.SwitchR4.on && self.SwitchR1.on && self.SwitchR2.on && self.SwitchR3.on){
        [_params setObject:@"1110" forKey:@"relays"];
    }else if(!self.SwitchR4.on && !self.SwitchR1.on && !self.SwitchR2.on && !self.SwitchR3.on){
        [_params setObject:@"0000" forKey:@"relays"];
    }else if (self.SwitchR3.on && !self.SwitchR1.on && !self.SwitchR2.on && !self.SwitchR4.on) {
        [_params setObject:@"0010" forKey:@"relays"];
    }else if (!self.SwitchR3.on && self.SwitchR1.on && self.SwitchR2.on && self.SwitchR4.on) {
        [_params setObject:@"1101" forKey:@"relays"];
    }else if(self.SwitchR3.on && self.SwitchR4.on && !self.SwitchR2.on && !self.SwitchR1.on){
        [_params setObject:@"0011" forKey:@"relays"];
    }else if (!self.SwitchR3.on && !self.SwitchR4.on && self.SwitchR1.on && self.SwitchR2.on){
        [_params setObject:@"1100" forKey:@"relays"];
    }else if (self.SwitchR3.on && self.SwitchR4.on && self.SwitchR2.on && !self.SwitchR1.on){
        [_params setObject:@"0111" forKey:@"relays"];
    }else if (!self.SwitchR3.on && !self.SwitchR4.on && !self.SwitchR2.on && self.SwitchR1.on){
        [_params setObject:@"1000" forKey:@"relays"];
    }else if (self.SwitchR3.on && self.SwitchR4.on && self.SwitchR2.on && self.SwitchR1.on){
        [_params setObject:@"1111" forKey:@"relays"];
    }else if (self.SwitchR3.on && self.SwitchR2.on && !self.SwitchR4.on && !self.SwitchR1.on){
        [_params setObject:@"0110" forKey:@"relays"];
    }else if (!self.SwitchR3.on && !self.SwitchR2.on && self.SwitchR4.on && self.SwitchR1.on){
        [_params setObject:@"1001" forKey:@"relays"];
    }else if (self.SwitchR1.on && !self.SwitchR2.on && self.SwitchR3.on && !self.SwitchR4.on){
        [_params setObject:@"1010" forKey:@"relays"];
    }else if (!self.SwitchR1.on && self.SwitchR2.on && !self.SwitchR3.on && self.SwitchR4.on){
        [_params setObject:@"0101" forKey:@"relays"];
    }else if (self.SwitchR2.on && !self.SwitchR1.on && !self.SwitchR3.on && !self.SwitchR4.on) {
        [_params setObject:@"0100" forKey:@"relays"];
    }else if(!self.SwitchR2.on && self.SwitchR1.on && self.SwitchR3.on && self.SwitchR4.on){
        [_params setObject:@"1011" forKey:@"relays"];
    }
}
-(void)editNames{
    
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *Sting = [defaults objectForKey:@"jwt"];
    NSString *Sting2 = @"Bearer ";
    NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
    [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
    [par setObject:@"update" forKey:@"action"];
    NSString *devID = [defaults objectForKey:@"deviceID"];
    [par setObject:devID forKey:@"deviceid"];
    [par setObject:loginkey forKey:@"apikey"];
    
    NSMutableArray *name = [[NSMutableArray alloc]initWithObjects:self.but1.titleLabel.text,_but2.titleLabel.text,_but3.titleLabel.text,_but4.titleLabel.text, nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:name,@"names", nil];
    [par setObject:dic forKey:@"params"];
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
@end
