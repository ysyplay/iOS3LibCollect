//
//  ViewController.m
//  二维码扫描
//
//  Created by 孙俊华 on 16/11/17.
//  Copyright © 2016年 孙俊华. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#define Width  300.0   //正方形二维码的边长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic) AVCaptureSession *session;//会话
@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer;//
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self beginScanning];

    [self navigationView];

    [self setupMaskView];
    
    [self animation];
    


}
-(void)navigationView{
    
    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navigationView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:navigationView];
    
    UIButton *xiangceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xiangceBtn.frame = CGRectMake(10, 10, 50, 50);
    xiangceBtn.backgroundColor = [UIColor redColor];
    [xiangceBtn addTarget:self action:@selector(xiangceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [xiangceBtn setTitle:@"相册" forState:UIControlStateNormal];
    [navigationView addSubview:xiangceBtn];
    
}
-(void)xiangceBtnClick{
    
    UIImagePickerController *imagrPicker = [[UIImagePickerController alloc]init];
    imagrPicker.delegate = self;
    imagrPicker.allowsEditing = YES;
    //将来源设置为相册
    imagrPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagrPicker animated:YES completion:nil];

    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //设置数组，放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(image)]];
        //判断是否有数据（即是否是二维码）
        if (features.count >= 1) {
            //取第一个元素就是二维码所存放的文本信息
            CIQRCodeFeature *feature = features[0];
            NSString *scannedResult = feature.messageString;
            //通过对话框的形式呈现
            [self alertControllerMessage:scannedResult];
        }else{
            [self alertControllerMessage:@"这不是一个二维码"];
        }
    }];
}
//由于要写两次，所以就封装了一个方法
-(void)alertControllerMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)animation{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-Width)/2.0, (kScreenHeight-Width-64)/2.0, Width, Width)];
    imageView.image = [UIImage imageNamed:@"scanscanBg"];
    
    [self.view addSubview:imageView];
    
    
    UIImageView *animationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanLine"]];
    
    animationView.frame = CGRectMake(0,0, Width, 10);
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath =@"transform.translation.y";
    
    animation.byValue = @(Width-5);
    
    animation.removedOnCompletion = NO;
    
    animation.duration = 2.0;
    
    animation.repeatCount = MAXFLOAT;
    
    [animationView.layer addAnimation:animation forKey:nil];
    
    [imageView addSubview:animationView];
}
-(void)beginScanning{
    // 获取 AVCaptureDevice 实例
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    // 创建会话
    _session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    // 初始化输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat x = ((kScreenHeight-Width-64)/2.0)/kScreenHeight;
    CGFloat y = ((kScreenWidth-Width)/2.0)/kScreenWidth;
    CGFloat width = Width/kScreenHeight;
    CGFloat height = Width/kScreenWidth;
    output.rectOfInterest = CGRectMake(x, y, width, height);
    
    if ([_session canAddInput:input]) {
        // 添加输入流
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]) {
        // 添加输出流
        [_session addOutput:output];
    }
    
    //设置二维码类型
    output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //添加扫描画面
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_previewLayer setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:_previewLayer];
    // 开始会话
    [_session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        //删除预览图层
//        [self.previewLayer removeFromSuperlayer];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle: UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];

        
//
//        if ([stringValue rangeOfString:@"http://"].location == NSNotFound) {
//            //是网址 判断是否可用 可用就加载 不可用就继续判断
//            
//        } else {
//            //判断是否是汉子
//            for(int i=0; i< [stringValue length];i++){
//                int a = [stringValue characterAtIndex:i];
//                if( a > 0x4e00 && a < 0x9fff){
//                    NSLog(@"汉字");
//                }
//            }
        
//        }
    }
}
- (void)setupMaskView{
    
    //设置统一的视图颜色和视图的透明度
    UIColor *color = [UIColor blackColor];
    float alpha = 0.6;
    
    //设置扫描区域外部上部的视图
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 64, kScreenWidth, (kScreenHeight-64-Width)/2.0-64);
    topView.backgroundColor = color;
    topView.alpha = alpha;
    
    //设置扫描区域外部左边的视图
    UIView *leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 64+topView.frame.size.height, (kScreenWidth-Width)/2.0,Width);
    leftView.backgroundColor = color;
    leftView.alpha = alpha;
    
    //设置扫描区域外部右边的视图
    UIView *rightView = [[UIView alloc]init];
    rightView.frame = CGRectMake((kScreenWidth-Width)/2.0+Width,64+topView.frame.size.height, (kScreenWidth-Width)/2.0,Width);
    rightView.backgroundColor = color;
    rightView.alpha = alpha;
    
    //设置扫描区域外部底部的视图
    UIView *botView = [[UIView alloc]init];
    botView.frame = CGRectMake(0, 64+Width+topView.frame.size.height,kScreenWidth,kScreenHeight-64-Width-topView.frame.size.height);
    botView.backgroundColor = color;
    botView.alpha = alpha;
    
    //将设置好的扫描二维码区域之外的视图添加到视图图层上
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:botView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
