
//
//  QRCodeScannerViewController.m
//  LinkSprite IO
//
//  Created by Jian on 16/9/7.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "QRCodeScannerViewController.h"

@interface QRCodeScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>
//@property NSTimer *scannerTimeoutTimer;
@property (copy) NSString *resultsToDisplay;



@property AVCaptureSession *captureSession;
@property AVCaptureMetadataOutput *metadataOutput;
@property AVCaptureStillImageOutput *stillImageOutput;
@property BOOL decoding;
@property AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (strong, nonatomic) CALayer *scanLayer;
//@property (strong, nonatomic) UIView *boxView;

@property (nonatomic, weak) IBOutlet UIView *viewPreview;
@property (nonatomic, weak) IBOutlet UIImageView *videoSnapshotImageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *macTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property NSString *name;

@property (nonatomic,strong) UITextField *nameTF;
@property (nonatomic,strong) NSMutableArray *addlist;
@property (nonatomic,strong) NSString *Type;
@property (nonatomic,strong) NSMutableArray *deviceidlist;
@property (nonatomic,strong) NSMutableArray *Names;
@property (nonatomic,strong) NSArray *Strr;
@end

@implementation QRCodeScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextButton.enabled = NO;
    _captureSession = nil;
    self.decoding = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"Linkie add" forState:UIControlStateNormal];
    [rightButton sizeToFit];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -CGRectGetWidth(rightButton.imageView.frame) - 3, 0, CGRectGetWidth(rightButton.imageView.frame) + 3);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetWidth(rightButton.titleLabel.frame) + 3, 0, -CGRectGetWidth(rightButton.titleLabel.frame) - 3);
    [rightButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:YES];
   /*
    if (!_decoding) {
        if ([self startReading]) {
            [self.nextButton setTitle:@"Stop"];
        }
    }
    else{
        [self stopReading];
        [self.nextButton setTitle:@"Start!"];
    }
    _decoding = !_decoding;
*/
    if (!_decoding) {
        
    [self startReading];
    
    }else if(_decoding){
        
        [self stopReading];
    }
}

#pragma mark - Local Methods

- (BOOL)startReading {
    
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"==>%@", [error localizedDescription]);
        return NO;
    }
    //3.创建媒体数据输出流
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    self.captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [self.captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [self.captureSession addOutput:self.metadataOutput];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [self.captureSession addOutput:self.stillImageOutput];
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    [self.metadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [self.videoPreviewLayer setFrame:self.viewPreview.layer.bounds];
    //9.将图层添加到预览view的图层上
    [self.viewPreview.layer addSublayer:self.videoPreviewLayer];
    //10.设置扫描范围
   self.metadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    /*
    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.2f, _viewPreview.bounds.size.height * 0.2f, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f, _viewPreview.bounds.size.height - _viewPreview.bounds.size.height * 0.4f)];
    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [_viewPreview addSubview:_boxView];
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];*/
    
    //10.开始扫描
    [self.captureSession startRunning];
    
    return YES;
}
/*
//实现计时器方法
- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}*/
- (void)stopReading {
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self.videoPreviewLayer removeFromSuperlayer];
}
//!!!
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (self.decoding) {
        NSLog(@"运行");
        return;
    }
    self.decoding = YES;
    //NSLog(@"运行");
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            //NSString *metaDataString = [[metadataObj stringValue] uppercaseString];
            NSLog(@"Result: %@", [metadataObj stringValue]);
           // NSLog(@"dataString:%@",metaDataString);
            //存
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //[defaults setObject:metaDataString forKey:@"metaDataString"];
            [defaults setObject:[metadataObj stringValue] forKey:@"metaDataString"];
            [defaults synchronize];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self processResults:metaDataString];
                [self captureStillImage];
                [self.tableView reloadData];
            });
            self.decoding = NO;
        }
    }
}
/*
- (void)processResults:(NSString*)results {
    
    if ([self.scannerTimeoutTimer isValid]) {
        [self.scannerTimeoutTimer invalidate];
        self.scannerTimeoutTimer = nil;
    }

}*/

- (IBAction)next:(id)sender {
    NSLog(@"Linkie add");
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
-(void)done{
    NSLog(@"绑定");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.addlist = nil;
    self.addlist = [NSMutableArray arrayWithArray:[defaults objectForKey:@"LoginDevicenames"]];
    NSString *metaDataString = [defaults objectForKey:@"metaDataString"];
    NSArray *array = [metaDataString componentsSeparatedByString:@","];
    NSString *mac = [array[0] substringFromIndex:3];
    self.macTextField.text = mac;
    
    NSString *key = [[NSString alloc]init];
    if (array.count > 1) {
        key = [array[1] substringFromIndex:3];
        self.keyTextField.text = key;
        NSLog(@"arraykey>%@",key);
    }
    NSLog(@"arraymac>%@",mac);
    
    
     if (_nameTF.text.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Care" message:@"Device name must be specified!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if (_nameTF.text.length != 0) {
        NSLog(@"===添加");
        NSURL *URL = [NSURL URLWithString:@"http://www.linksprite.io/api/user/device/add"];
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
        [params setObject:@"Relay" forKey:@"group"];
        //[params setObject:_Type forKey:@"type"];
        [params setObject:mac forKey:@"deviceid"];
        [params setObject:key forKey:@"apikey"];
        
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
                        if (self.nameTF.text.length) {
                            NSDictionary *Dict = @{@"name":self.nameTF.text,@"Type":_Type};
                            if (!self.addlist.count)
                            {
                                self.addlist = nil;
                                self.addlist = [NSMutableArray array];
                                if ([defaults objectForKey:@"LoginDevicenames"])
                                {
                                    self.addlist = nil;
                                    self.addlist = [NSMutableArray arrayWithArray:[defaults objectForKey:@"LoginDevicenames"]];
                                }
                            }
                            [self.addlist addObject:Dict];
                            [defaults setObject:self.addlist forKey:@"LoginDevicenames"];
                            [defaults synchronize];
                            [self DeviceType];
                        }
                    }
                });
            }
        }];
        [dataTask resume];
    }
}
-(void)DeviceType{
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
- (void)captureStillImage {
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    [stillImageConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    [stillImageConnection setVideoScaleAndCropFactor:1.0f];
    [self.stillImageOutput setOutputSettings:[NSDictionary dictionaryWithObject:AVVideoCodecJPEG forKey:AVVideoCodecKey]];
    self.stillImageOutput.outputSettings = @{AVVideoCodecKey: AVVideoCodecJPEG, AVVideoQualityKey:@1};
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error){
        if (error) {
        //NSLog(@"error: %@", error);
    } else { NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image =[UIImage imageWithData:jpegData];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.videoSnapshotImageView.image = image;
            self.videoSnapshotImageView.contentMode = UIViewContentModeScaleToFill;
        });
    }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self stopReading];
        });
    }];
    NSLog(@"捕获静止图像");
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *metaDataString = [defaults objectForKey:@"metaDataString"];
    NSArray *array = [metaDataString componentsSeparatedByString:@","];
    NSString *mac = [array[0] substringFromIndex:3];
    self.macTextField.text = mac;
    
    if (array.count > 1) {
         NSString *key = [array[1] substringFromIndex:3];
        self.keyTextField.text = key;
         NSLog(@"arraykey>%@",key);
    }
    NSLog(@"arraymac>%@",mac);
   
    return 0;
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CGFloat height = 0.0;
    if (section == 0) {
        return [super tableView:tableView viewForHeaderInSection:section];
    } else if (section == 1) {
        height = 64.0;
    }
    UIView *nameHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.bounds), height)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:16.0];
    //nameLabel.textColor = [UIColor styleTextColor];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    
    if (section == 1) {
        nameLabel.text = NSLocalizedString(@"Name Your Device:", @"");
    }
    
    [nameHeaderView addSubview:nameLabel];
    [nameHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(12)-[label]-(12)-|" options:0 metrics:nil views:@{ @"label" : nameLabel }]];
    [nameHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|" options:0 metrics:nil views:@{ @"label" : nameLabel }]];
    
    return nameHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.macTextField) {
        [self.keyTextField becomeFirstResponder];
    } else if (textField == self.keyTextField) {
        [self.keyTextField resignFirstResponder];
    }
    
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    BOOL allow = YES;
       return allow;
}*/

@end
