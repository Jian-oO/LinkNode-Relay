//
//  HomeViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/8/31.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import "HomeViewController.h"
#import "AddViewController.h"
#import "DevViewController.h"
#import "RelayViewController.h"
#import "CustomViewController.h"


@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray *allCameras;
@property (nonatomic,strong) UICollectionView *cameraView;
@property (nonatomic,strong) UIImageView *cameraImage;

@property (nonatomic,strong) NSString *devID;
@property (nonatomic,strong) NSMutableArray *Names;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
}
- (IBAction)logout:(id)sender {
    //退出登录页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Add:(id)sender {

    [self.navigationController pushViewController:[AddViewController new] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    self.allCameras = [NSArray arrayWithArray:[df objectForKey:@"LoginDevicenames"]];
    //NSLog(@"allcameras==>%@",_allCameras);
    
    if (self.view.bounds.size.width > self.view.bounds.size.height)
    {
        CGRect frame = self.view.frame;
        frame.size.width = self.view.bounds.size.height;
        frame.size.height = self.view.bounds.size.width;
        self.view.frame = frame;
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [self.cameraView removeFromSuperview];
        self.cameraView = nil;
        self.cameraView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-120) collectionViewLayout:flowLayout];
        self.cameraView.contentInset = UIEdgeInsetsMake(30, 0, 20, 0);
        self.cameraView.dataSource = self;
        self.cameraView.delegate = self;
        [self.cameraView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CameraCell"];
        [self.cameraView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:self.cameraView];
    }
    else
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [self.cameraView removeFromSuperview];
        self.cameraView = nil;
        self.cameraView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-120) collectionViewLayout:flowLayout];
        self.cameraView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        self.cameraView.dataSource = self;
        self.cameraView.delegate = self;
        [self.cameraView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CameraCell"];
        [self.cameraView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:self.cameraView];
    }
}


#pragma mark -- UICollectionViewDataSource & UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allCameras.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CameraCell" forIndexPath:indexPath];
    //解除Label重用导致的字体重叠，有三个地方。
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSString *Url = [self.allCameras[indexPath.row] objectForKey:@"Type"];
    if ([Url isEqualToString:@"01"]) {
        self.cameraImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01"]];
    }else if ([Url isEqualToString:@"02"]){
        self.cameraImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"02"]];
    }else if ([Url isEqualToString:@"03"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"03"]];
    }else if ([Url isEqualToString:@"04"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"04"]];
    }else if ([Url isEqualToString:@"05"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"05"]];
    }else if ([Url isEqualToString:@"00"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"06"]];
    }
    
    self.cameraImage.frame = CGRectMake(0, 0, (self.view.bounds.size.width - 60) / 4, (self.view.bounds.size.width - 60) / 4);
    [cell.contentView addSubview:self.cameraImage];
    
    UILabel *cameraName = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.width - 60) / 4 + 5, (self.view.bounds.size.width - 60) / 4, 15)];
    cameraName.text = [self.allCameras[indexPath.row] objectForKey:@"name"];
    cameraName.textColor = [UIColor grayColor];
    cameraName.textAlignment = NSTextAlignmentCenter;
    cameraName.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:cameraName];
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 60) / 4, (self.view.bounds.size.width - 60) / 4 + 20);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark - 点击设备
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击设备");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *deviceidArray = [defaults objectForKey:@"devlist"];
    self.devID = deviceidArray[indexPath.row];
    NSLog(@"self.devID->%@===%ld",self.devID,(long)indexPath.row);
    
    NSLog(@"查询设备状态");
    NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/http"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *Sting = [defaults objectForKey:@"jwt"];
    NSString *Sting2 = @"Bearer ";
    NSString *Valuestr = [Sting2 stringByAppendingString:Sting];
    [request setValue:Valuestr forHTTPHeaderField:@"Authorization"];
    
   
    self.Names = [[NSMutableArray alloc]initWithObjects:@"names",@"relays", nil];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
    [par setObject:@"query" forKey:@"action"];
    [par setObject:self.devID forKey:@"deviceid"];
    [par setObject:loginkey forKey:@"apikey"];
    [par setObject:_Names forKey:@"params"];
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
            NSDictionary *dec = [dict objectForKey:@"params"];
            NSString *relays = [dec objectForKey:@"relays"];
            NSArray *name = [dec objectForKey:@"names"];
            //存
            [defaults setObject:dec forKey:@"ParamsRelays"];
            [defaults setObject:relays forKey:@"Relays"];
            [defaults setObject:name forKey:@"Names"];
            
            [defaults setObject:str forKey:@"deviceID"];
            [defaults synchronize];
            NSLog(@"NSstring_>%@",str);
            NSLog(@"%@---%ld",relays,relays.length);
            NSLog(@"%@---%ld",name,name.count);
            //[name firstObject];
            //[name lastObject];
            if([[name firstObject] isEqualToString:@"Custom"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:[CustomViewController new] animated:YES];
                });
            }else if (relays.length == 4) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:[DevViewController new] animated:YES];
                });
            }else if (relays.length == 8){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:[RelayViewController new] animated:YES];
                });
            }else if(relays == nil){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Creation failed"message:@"Device not initialized, remove the device again to add." preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }
        }
    }];
    
    [dataTask resume];
    
    /*
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Device" message:@"Select the type of relay,And initialize." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *siRelay = [UIAlertAction actionWithTitle:@"Four-way relay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController pushViewController:[DevViewController new] animated:YES];
        
        [self Dev];//初始化
    }];
    UIAlertAction *baRelay = [UIAlertAction actionWithTitle:@"Eight-way relay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController pushViewController:[RelayViewController new] animated:YES];
        
        [self Relay];
    }];
    UIAlertAction *Relay = [UIAlertAction actionWithTitle:@"Custom" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController pushViewController:[CustomViewController new] animated:YES];
        
        //[self Custom];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:siRelay];
    [alert addAction:baRelay];
    [alert addAction:Relay];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    */
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
    
    //[params setObject:self.Names forKey:@"names"];
    [params setObject:self.Names forKey:@"names"];
    [params setObject:@"0" forKey:@"relays"];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *loginkey = [defaults objectForKey:@"Loginapikey"];
    [par setObject:@"update" forKey:@"action"];
    [par setObject:self.devID forKey:@"deviceid"];
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
    [par setObject:self.devID forKey:@"deviceid"];
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
    [par setObject:self.devID forKey:@"deviceid"];
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

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSString *Url = [self.allCameras[indexPath.row] objectForKey:@"Type"];
    
    if ([Url isEqualToString:@"01"]) {
        self.cameraImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01"]];
    }else if ([Url isEqualToString:@"02"]){
        self.cameraImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"02"]];
    }else if ([Url isEqualToString:@"03"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"03"]];
    }else if ([Url isEqualToString:@"04"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"04"]];
    }else if ([Url isEqualToString:@"05"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"05"]];
    }else if ([Url isEqualToString:@"00"]){
        self.cameraImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"06"]];
    }

    self.cameraImage.frame = CGRectMake(0, 0, (self.view.bounds.size.width - 60) / 4, (self.view.bounds.size.width - 60) / 4);
    [cell.contentView addSubview:self.cameraImage];
    UILabel *cameraName = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.width - 60) / 4 + 5, (self.view.bounds.size.width - 60) / 4, 15)];
    cameraName.text = [self.allCameras[indexPath.row] objectForKey:@"name"];
    cameraName.textColor = [UIColor lightGrayColor];
    cameraName.textAlignment = NSTextAlignmentCenter;
    cameraName.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:cameraName];
}
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    self.cameraImage.frame = CGRectMake(0, 0, (self.view.bounds.size.width - 60) / 4, (self.view.bounds.size.width - 60) / 4);
    [cell.contentView addSubview:self.cameraImage];
    UILabel *cameraName = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.width - 60) / 4 + 5, (self.view.bounds.size.width - 60) / 4, 15)];
    cameraName.text = [self.allCameras[indexPath.row] objectForKey:@"name"];
    cameraName.textColor = [UIColor grayColor];
    cameraName.textAlignment = NSTextAlignmentCenter;
    cameraName.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:cameraName];
}

@end
