//
//  RelayViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/9/20.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import "RelayViewController.h"

@interface RelayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) UISwitch *SwitchR1;
@property (nonatomic,strong) UISwitch *SwitchR2;
@property (nonatomic,strong) UISwitch *SwitchR3;
@property (nonatomic,strong) UISwitch *SwitchR4;
@property (nonatomic,strong) UISwitch *SwitchR5;
@property (nonatomic,strong) UISwitch *SwitchR6;
@property (nonatomic,strong) UISwitch *SwitchR7;
@property (nonatomic,strong) UISwitch *SwitchR8;

@property (nonatomic,strong) UIButton *but1;
@property (nonatomic,strong) UIButton *but2;
@property (nonatomic,strong) UIButton *but3;
@property (nonatomic,strong) UIButton *but4;
@property (nonatomic,strong) UIButton *but5;
@property (nonatomic,strong) UIButton *but6;
@property (nonatomic,strong) UIButton *but7;
@property (nonatomic,strong) UIButton *but8;

@property (nonatomic,strong) UITextField *nameTF;

@property (nonatomic,strong) NSMutableDictionary *params;

@end

@implementation RelayViewController

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
    [self.navigationItem setTitle:@"Eight-way relay"];
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
    return 8;
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
        //NSLog(@"--%@",sww);
        //BOOL sw = [sww substringFromIndex:1];
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
    }if (indexPath.row == 4) {
        _but5 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but5 setTitle:@"R5" forState:UIControlStateNormal];
        _but5.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but5.layer.cornerRadius = 5;
        _but5.layer.masksToBounds = YES;
        [_but5 addTarget:self action:@selector(nextR5) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR5= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR5 addTarget:self action:@selector(switchActionR5) forControlEvents:UIControlEventValueChanged];
        
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        BOOL sw= [[sww substringWithRange:NSMakeRange(4,1)] intValue];
        NSLog(@"_SwitchR5=%d",sw);
        [_SwitchR5 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:4];
        [_but5 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        
        [cell.contentView addSubview:self.SwitchR5];
        [cell.contentView addSubview:_but5];
        
    }if (indexPath.row == 5) {
        _but6 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but6 setTitle:@"R6" forState:UIControlStateNormal];
        _but6.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but6.layer.cornerRadius = 5;
        _but6.layer.masksToBounds = YES;
        [_but6 addTarget:self action:@selector(nextR6) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR6= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR6 addTarget:self action:@selector(switchActionR6) forControlEvents:UIControlEventValueChanged];
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        BOOL sw= [[sww substringWithRange:NSMakeRange(5,1)] intValue];
        NSLog(@"_SwitchR6=%d",sw);
        [_SwitchR6 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:5];
        [_but6 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        [cell.contentView addSubview:self.SwitchR6];
        [cell.contentView addSubview:_but6];

        
    }if (indexPath.row == 6) {
        _but7 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but7 setTitle:@"R7" forState:UIControlStateNormal];
        _but7.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but7.layer.cornerRadius = 5;
        _but7.layer.masksToBounds = YES;
        [_but7 addTarget:self action:@selector(nextR7) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR7= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR7 addTarget:self action:@selector(switchActionR7) forControlEvents:UIControlEventValueChanged];
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        BOOL sw= [[sww substringWithRange:NSMakeRange(6,1)] intValue];
        NSLog(@"_SwitchR7=%d",sw);
        [_SwitchR7 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:6];
        [_but7 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        [cell.contentView addSubview:self.SwitchR7];
        [cell.contentView addSubview:_but7];

        
    }if (indexPath.row == 7) {
        _but8 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 120, 40)];
        [_but8 setTitle:@"R8" forState:UIControlStateNormal];
        _but8.backgroundColor = [UIColor colorWithDisplayP3Red:241.0/255.0 green:176.0/255.0 blue:52.0/255.0 alpha:1.0];
        _but8.layer.cornerRadius = 5;
        _but8.layer.masksToBounds = YES;
        [_but8 addTarget:self action:@selector(nextR8) forControlEvents:UIControlEventTouchUpInside];
        self.SwitchR8= [[UISwitch alloc]initWithFrame: CGRectMake(self.view.bounds.size.width-60,15, 100, 50)];
        [self.SwitchR8 addTarget:self action:@selector(switchActionR8) forControlEvents:UIControlEventValueChanged];
        //UISwitch
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * sww = [userDefaults stringForKey:@"Relays"];
        BOOL sw= [[sww substringWithRange:NSMakeRange(7,1)] intValue];
        NSLog(@"_SwitchR8=%d",sw);
        [_SwitchR8 setOn:sw];
        //UITextField
        NSArray *str = [userDefaults arrayForKey:@"Names"];
        NSString *name = [str objectAtIndex:7];
        [_but8 setTitle:name forState:UIControlStateNormal];
        NSLog(@"ParamsRelays=>%@~~~%d",str,sw);
        [cell.contentView addSubview:self.SwitchR8];
        [cell.contentView addSubview:_but8];
        
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
        self.nameTF = textField;
        
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
        self.nameTF = textField;
        
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
        self.nameTF = textField;
        
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
-(void)nextR5{
    NSLog(@"点击R5");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self editR5];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)editR5{
    [_but5 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR5{
    NSLog(@"switchActionR5");
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
-(void)nextR6{
    NSLog(@"点击R6");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self editR6];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)editR6{
    [_but6 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR6{
    NSLog(@"switchActionR6");
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
-(void)nextR7{
    NSLog(@"点击R7");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self editR7];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)editR7{
    [_but7 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR7{
    NSLog(@"switchActionR7");
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
-(void)nextR8{
    NSLog(@"点击R8");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Modify Name" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self editR8];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)editR8{
    [_but8 setTitle:_nameTF.text forState:UIControlStateNormal];
    [self editNames];
}
-(void)switchActionR8{
    NSLog(@"switchActionR8");
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
    
    NSMutableArray *name = [[NSMutableArray alloc]initWithObjects:self.but1.titleLabel.text,_but2.titleLabel.text,_but3.titleLabel.text,_but4.titleLabel.text,_but5.titleLabel.text,_but6.titleLabel.text,_but7.titleLabel.text,_but8.titleLabel.text, nil];
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
-(void)Switch{
    if (_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on) {
        [_params setObject:@"11111111" forKey:@"relays"];
    }else if (!_SwitchR1.on &&!_SwitchR2.on &&!_SwitchR3.on &&!_SwitchR4.on &&!_SwitchR5.on &&!_SwitchR6.on &&!_SwitchR7.on &&!_SwitchR8.on){
        [_params setObject:@"00000000" forKey:@"relays"];
    }else if (_SwitchR1.on &&!_SwitchR2.on &&!_SwitchR3.on &&!_SwitchR4.on &&!_SwitchR5.on &&!_SwitchR6.on &&!_SwitchR7.on &&!_SwitchR8.on){
        [_params setObject:@"10000000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01111111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11000000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00111111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11100000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00011111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11110000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00001111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11111000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00000111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11111100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00000011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11111110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00000001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00111110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11000001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00011110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11100001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00001110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11110001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00000110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11111001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00000010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11111101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00111100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11000011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00111000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11000111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00110000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11001111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01000000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10111111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00100000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11011111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00010000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11101111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00001000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11110111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00000100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11111011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11001101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00110011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11101100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00010011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11110110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00001001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11101000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00010111" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10101010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01010101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11111010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00000101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11110100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00001011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10101000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01010011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10101100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10101101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01010010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10100101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01011010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10110101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01001010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10110100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01001011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11011010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00100101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01001001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10110110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11011011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00100100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00100010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11011101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00100001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11011110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00010001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11101110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10001000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01110111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01000100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10111011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00011000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11100111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00011100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11100011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01111110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10000001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00110010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11001101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11000101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00111010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00011101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11100010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00110001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11001110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11001010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00110101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10000100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01111011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01111001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10000110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00111001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11000110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00001010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11110101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00001100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11110011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00001101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11110010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00011010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11100101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00011011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11100100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00100011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11011100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00100110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11011001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00101000" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11010111" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00101001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11010110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00101010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11010101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00101011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00101100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11010011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00101101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11010010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00101110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11010001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00101111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11010000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00110100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11001011" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00110110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11001001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00110111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11001000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00111011" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11000100" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00111101" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11000010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01000001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10111110" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01000010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10111101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01000011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10111100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01000101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10111010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01000110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10111001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01000111" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10111000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01001000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10110111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01001100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10110011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01001101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10110010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01001110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10110001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01001111" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10110000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01010000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10101111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01010001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10101110" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01010100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10101011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01010110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10101001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01010111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01011000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10100111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01011001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10100110" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01011011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10100100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01011100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10100011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01011101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10100010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01011110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10100001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01011111" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10100000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01100000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10011111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01100001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10011110" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01100010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10011101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01100011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10011100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01100100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10011011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01100101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10011010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01100110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10011001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01100111" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10011000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01101000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10010111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01101001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10010110" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01101010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10010101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01101011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10010100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01101100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10010011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01101101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10010010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01101110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10010001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01101111" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10010000" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01110000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10001111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01110001" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10001110" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01110010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10001101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01110011" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10001100" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01111100" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10000011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01111101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10000010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10000101" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01111010" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10000111" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01111000" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10001001" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01110110" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"10001010" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"01110101" forKey:@"relays"];
    }else if(_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"10001011" forKey:@"relays"];
    }else if(!_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"01110100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11011000" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00100111" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11100110" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00011001" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11101001" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00010110" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"11101010" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"00010101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00010100" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && _SwitchR6.on && !_SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11101101" forKey:@"relays"];
    }else if(!_SwitchR1.on && !_SwitchR2.on && !_SwitchR3.on && _SwitchR4.on && !_SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && !_SwitchR8.on){
        [_params setObject:@"00010010" forKey:@"relays"];
    }else if(_SwitchR1.on && _SwitchR2.on && _SwitchR3.on && !_SwitchR4.on && _SwitchR5.on && !_SwitchR6.on && _SwitchR7.on && _SwitchR8.on){
        [_params setObject:@"11101011" forKey:@"relays"];
    }
}
@end
