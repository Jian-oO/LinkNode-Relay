//
//  AddViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/9/1.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import "AddViewController.h"


typedef NS_ENUM(NSUInteger,VTEditModel){
    VTEditModelAdd = 0,
    VTEditModelModify = 1
};

@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *listTableView;

@property (nonatomic,strong) UITextField *nameTF;
//@property (nonatomic,strong) UITextField *urlTF;
@property (nonatomic,strong) NSMutableArray *addlist;

@property (nonatomic,strong) NSMutableArray *deviceidlist;

@property (nonatomic,strong) NSString *Type;
@property (nonatomic,strong) NSDictionary *selectCamera;
@property (nonatomic,strong) NSMutableString *devID;
@property (nonatomic,strong) NSMutableArray *Names;
@property (nonatomic,strong) NSArray *Strr;

@property VTEditModel model;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"Add List"];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithTitle:@"DIY add" style:UIBarButtonItemStylePlain target:self action:@selector(addType)];
    self.navigationItem.rightBarButtonItem =addItem;
    
    self.listTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.listTableView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.listTableView.separatorColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    [self setExtraCellLineHidden:self.listTableView];
    [self.listTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.listTableView setLayoutMargins:UIEdgeInsetsZero];
    self.listTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listTableView];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.deviceidlist = [defaults objectForKey:@"devlist"];
    NSLog(@"++++++>%@",self.deviceidlist);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    self.addlist = nil;
    self.addlist = [NSMutableArray arrayWithArray:[df objectForKey:@"LoginDevicenames"]];
    [self.listTableView reloadData];
}
-(void)setExtraCellLineHidden:(UITableView*)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(void)addUrlType{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Type" message:@"Add your device type" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Power switch",@"Simple light",@"Weather station",@"GPS tracker",@"Led bar",@"Custom device type",nil];
    [alertView show];
    //alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 01) {
        _Type = @"01";
        [self addType];
    }
    if (buttonIndex == 02) {
        _Type = @"02";
        [self addType];
    }
    if (buttonIndex == 03) {
        _Type = @"03";
        [self addType];
    }
    if (buttonIndex == 04) {
        _Type = @"04";
        [self addType];
    }
    if (buttonIndex == 05) {
        _Type = @"05";
        [self addType];
    }
    if (buttonIndex == 06) {
        _Type = @"00";
        [self addType];
    }
}*/
-(void)addType{
    self.model = VTEditModelAdd;
    NSLog(@"DIY add");
    _Type = @"00";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Device" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"device name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameTF = textField;
    }];
    /*[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"group name";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.urlTF = textField;
    }];*/
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self done];
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return [textField resignFirstResponder];
    
}
-(void)done{
    if (self.model == VTEditModelAdd)
    {
        if (self.nameTF.text.length /*&& self.urlTF.text.length*/)
        {
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            NSDictionary *cameraDict = @{@"name":self.nameTF.text,/*@"rtspURL":self.urlTF.text,*/@"Type":_Type};
            
            if (!self.addlist.count)
            {
                self.addlist = nil;
                self.addlist = [NSMutableArray array];
                if ([df objectForKey:@"LoginDevicenames"])
                {
                    self.addlist = nil;
                    self.addlist = [NSMutableArray arrayWithArray:[df objectForKey:@"LoginDevicenames"]];
                }
            }
            [self.addlist addObject:cameraDict];
            [df setObject:self.addlist forKey:@"LoginDevicenames"];
            [df synchronize];
            
            [self reloadCameraList];
        }
        else if(_nameTF.text.length == 0 /*| _urlTF.text.length == 0*/)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Care" message:@"Device name must be specified!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    
    if (_nameTF.text.length != 0 /*&& _urlTF.text.length != 0*/) {
        NSLog(@"===添加");
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/user/device"];
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_nameTF.text forKey:@"name"];
 //[params setObject:_urlTF.text forKey:@"group"];
    [params setObject:@"Relay" forKey:@"group"];
    [params setObject:_Type forKey:@"type"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    
    NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //判断是否成功
        if(error)
        {
            NSLog(@"error1=======%@", error.localizedDescription);
            UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Care"message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            // 如果请求成功，则解析数据。
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            // 判断是否解析成功
         
                NSLog(@"===>%@",dict);
                _Strr = [dict objectForKey:@"deviceid"];
                NSLog(@"deviceid___>%@",_Strr);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_Strr == nil) {
                    NSString *error = [dict objectForKey:@"error"];
                    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Care"message:error preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alert animated:YES completion:nil];
                }else if(_Strr != nil){
                    //存
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    self.deviceidlist = [NSMutableArray arrayWithArray:[defaults objectForKey:@"devlist"]];
                    [self.deviceidlist addObject:_Strr];
                    [defaults setObject:self.deviceidlist forKey:@"devlist"];
                    [defaults synchronize];
                    NSLog(@"self.deviceidlist->%@",self.deviceidlist);
                    
                    [self DeviceType];
                }
            });
        }
    }];
    [dataTask resume];
        }
        }
        /*
    for (NSDictionary *cameraDict in self.list)
    {
        if ([[cameraDict objectForKey:@"name"] isEqualToString:self.nameTF.text] || [[cameraDict objectForKey:@"rtspURL"] isEqualToString:self.urlTF.text])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Care" message:@"Device already exists" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }*/
    /*
    if (self.model == VTEditModelModify)
    {
        if (self.nameTF.text.length && self.urlTF.text.length)
        {
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            if (!self.addlist.count)
            {
                self.addlist = nil;
                self.addlist = [NSMutableArray arrayWithArray:[df objectForKey:@"LoginDevicenames"]];
            }
            [self.addlist removeObject:self.selectCamera];
            NSDictionary *cameraDict = @{@"name":self.nameTF.text,@"rtspURL":self.urlTF.text,@"Type":_Type};
            [self.addlist addObject:cameraDict];
            [df setObject:self.addlist forKey:@"LoginDevicenames"];
            [df synchronize];
            
            [self reloadCameraList];
        }
        else if(_nameTF.text.length == 0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Care" message:@"Lack Of Necessary Information" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        if(_nameTF.text.length != 0){
    
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //NSString *deviceidSting = [defaults objectForKey:@"deviceID"];
            //NSLog(@"deviceidSting->%@",deviceidSting);
            NSString *devStr = @"http://www.linksprite.io/api/user/device/";
            NSString *Dev = [devStr stringByAppendingString:self.devID];
            NSLog(@"devUrl00000->%@",Dev);
            
            NSURL *URL = [NSURL URLWithString:Dev];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
            [request setTimeoutInterval:10.0];
            [request setHTTPMethod:@"POST"];
            [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            NSString *Sting = [defaults objectForKey:@"jwt"];
            NSString *Sting2 = @"Bearer ";
            NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
            NSLog(@"Sting->%@",Valuestr);
            [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            [params setObject:_nameTF.text forKey:@"name"];
            //[params setObject:_urlTF.text forKey:@"group"];
            
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
            request.HTTPBody = jsonData;
            
            NSLog(@"HttpBody Data->Bytes %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"修改===>%@",dict);
            }];
            [dataTask resume];
        }
    }*/
}

-(void)reloadCameraList
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    if (self.addlist.count != [[df objectForKey:@"LoginDevicenames"] count])
    {
        self.addlist = nil;
        self.addlist = [NSMutableArray arrayWithArray:[df objectForKey:@"LoginDevicenames"]];
    }
    [self.listTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Camera"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.addlist[indexPath.row] objectForKey:@"name"];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectCamera = self.addlist[indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.deviceidlist = [defaults objectForKey:@"devlist"];
    
    self.devID = self.deviceidlist[indexPath.row];
    NSLog(@"self.devID->%@\n%@",self.devID,self.deviceidlist);
    [self editCamera];
}
-(void)editCamera
{
    self.model = VTEditModelModify;
    
    _Type = [_selectCamera objectForKey:@"Type"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Device" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [self.selectCamera objectForKey:@"name"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.enabled = NO;
        self.nameTF = textField;
    }];
    /*[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [self.selectCamera objectForKey:@"rtspURL"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //self.urlTF = textField;
    }];*/
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self delete];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)delete
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *devStr = @"http://www.linksprite.io/api/user/device/";
    //_devID = @"test";
    NSString *Dev = [devStr stringByAppendingString:_devID];
    NSLog(@"devStr00000->%@",Dev);
    NSURL *URL = [NSURL URLWithString:Dev];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:20.0];
    [request setHTTPMethod:@"DELETE"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *Sting = [defaults objectForKey:@"jwt"];
    NSString *Sting2 = @"Bearer ";
    NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
    NSLog(@"Sting->%@",Valuestr);
    [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_nameTF.text forKey:@"name"];
    //[params setObject:_urlTF.text forKey:@"group"];
    [params setObject:_Type forKey:@"type"];
    
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self deleteerror];
            });
        
        }
        else
        {
            // 如果请求成功，则解析数据。
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"Dev===>%@",dict);
            
             NSLog(@"====>%@",self.deviceidlist);
            
            NSMutableArray *arraylist = [[NSMutableArray alloc]initWithArray:self.deviceidlist];
            
            for (NSString *list in arraylist) {
                NSLog(@"list->%@",list);
                if ([list isEqualToString:_devID]) {
                    [arraylist removeObject:list];
                     break;
                }
            }
            [defaults setObject:arraylist forKey:@"devlist"];
            [defaults synchronize];
            NSLog(@"====>%@",arraylist);
        }
    }];
    if (!self.addlist.count)
    {
        self.addlist = nil;
        self.addlist = [NSMutableArray arrayWithArray:[defaults objectForKey:@"LoginDevicenames"]];
    }
    for (NSDictionary *cameraDict in self.addlist)
    {
        if ([[cameraDict objectForKey:@"name"] isEqualToString:[self.selectCamera objectForKey:@"name"]])
        {
            [self.addlist removeObject:cameraDict];
            break;
        }
    }

    [defaults setObject:self.addlist forKey:@"LoginDevicenames"];
    [defaults synchronize];
    
    [self reloadCameraList];
    [dataTask resume];
}
-(void)deleteerror{
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Delete"message:@"Request timed out!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)DeviceType{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Device Type" message:@"Please select the type of device" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *siRelay = [UIAlertAction actionWithTitle:@"Four-way relay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self Dev];//初始化
        [self Care];
    }];
    UIAlertAction *baRelay = [UIAlertAction actionWithTitle:@"Eight-way relay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self Relay];
        [self Care];
    }];
    UIAlertAction *Relay = [UIAlertAction actionWithTitle:@"Custom switches" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self Custom];
        [self Care];
    }];
    //UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:siRelay];
    [alert addAction:baRelay];
    [alert addAction:Relay];
    //[alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)Dev{
    //四路继电器
    NSLog(@"四路初始化");
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    self.Names = [[NSMutableArray alloc]initWithObjects:@"R1",@"R2",@"R3",@"R4", nil];
    
    [params setObject:self.Names forKey:@"names"];
    [params setObject:@"0000" forKey:@"relays"];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
    [par setObject:@"update" forKey:@"action"];
    [par setObject:_Strr forKey:@"deviceid"];
    [par setObject:loginkey forKey:@"apikey"];
    [par setObject:params forKey:@"params"];
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
            NSArray *str = [dict objectForKey:@"deviceid"];
            [defaults setObject:str forKey:@"deviceID"];
            [defaults synchronize];
            NSLog(@"NSstring_>%@",str);
        }
    }];
    
    [dataTask resume];
}
-(void)Relay{
    NSLog(@"八路初始化");
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    self.Names = [[NSMutableArray alloc]initWithObjects:@"R1",@"R2",@"R3",@"R4",@"R5",@"R6",@"R7",@"R8", nil];
    
    [params setObject:self.Names forKey:@"names"];
    [params setObject:@"00000000" forKey:@"relays"];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
    [par setObject:@"update" forKey:@"action"];
    [par setObject:self.Strr forKey:@"deviceid"];
    [par setObject:loginkey forKey:@"apikey"];
    [par setObject:params forKey:@"params"];
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
            NSArray *str = [dict objectForKey:@"deviceid"];
            [defaults setObject:str forKey:@"deviceID"];
            [defaults synchronize];
            NSLog(@"NSstring_>%@",str);
        }
    }];
    
    [dataTask resume];
}
-(void)Custom{
    NSLog(@"自定义获取");
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
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    self.Names = [[NSMutableArray alloc]initWithObjects:@"Custom",@"...", nil];
    
    [params setObject:self.Names forKey:@"names"];
    [params setObject:@"0" forKey:@"relays"];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
    [par setObject:@"update" forKey:@"action"];
    [par setObject:_Strr forKey:@"deviceid"];
    [par setObject:loginkey forKey:@"apikey"];
    [par setObject:params forKey:@"params"];
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
            NSArray *str = [dict objectForKey:@"deviceid"];
            [defaults setObject:str forKey:@"deviceID"];
            [defaults synchronize];
            NSLog(@"NSstring_>%@",str);
        }
    }];
    
    [dataTask resume];
    
    
}
- (void)Care{
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Complete"message:@"Create Success✅" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


/*
-(void)查询Web设备调用方法{
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
            NSArray *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"dict->%@",dict);
            NSMutableArray  *muarrayID=[[NSMutableArray alloc]init];
            
            NSMutableArray *muarrayname = [[NSMutableArray alloc]init];
            for (int i; i < dict.count; i++) {
                NSDictionary * devid = [dict objectAtIndex:i];
                NSString *ID = [devid objectForKey:@"deviceid"];
                [muarrayID addObject:ID];
                
                NSString *name = [devid objectForKey:@"name"];
                
                NSString *type = [devid objectForKey:@"type"];
                
                NSMutableDictionary *mudic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:type,@"Type",name,@"name", nil];
                NSLog(@"nudic==>%@",mudic);
                [muarrayname addObject:mudic];
            }
            NSLog(@"ID..>%@",muarrayID);
            NSLog(@"%@",muarrayname);
            [defaults setObject:muarrayname forKey:@"LoginDevicenames"];
            //[defaults setObject:dict forKey:@"LoginDeviceids"];
            [defaults setObject:muarrayID forKey:@"devlist"];
            [defaults synchronize];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               // [self home];
            });
        }
    }];
    [dataTask resume];
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
