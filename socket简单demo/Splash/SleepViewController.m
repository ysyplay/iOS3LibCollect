//
//  SleepViewController.m
//  Splash
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SleepViewController.h"

@interface SleepViewController ()
- (IBAction)Monitor:(id)sender;
- (IBAction)Led:(id)sender;
- (IBAction)Curtain:(id)sender;
- (IBAction)Tv:(id)sender;
- (IBAction)AirSub:(id)sender;
- (IBAction)AirAdd:(id)sender;
- (IBAction)Air:(id)sender;
- (IBAction)AllLedOn:(id)sender;
- (IBAction)AllLedOff:(id)sender;
@property(nonatomic,assign) int MonitorFlag;
@property(nonatomic,assign) int LedFlag;
@property(nonatomic,assign) int CurtainFlag;
@property(nonatomic,assign) int AirFlag;
@property(nonatomic,assign) int TvFlag;
@end

@implementation SleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"这是Sleep");
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
- (IBAction)Monitor:(id)sender {
    NSString *MonitorOn = @"M";
    NSString *MonitorOff = @"m";
    
    if (0 ==_MonitorFlag ) {
        [self sendtool:MonitorOn];
        _MonitorFlag = 1;
    }
    else{
        [self sendtool:MonitorOff];
        _MonitorFlag = 0;
    }
}

- (IBAction)Led:(id)sender {
    NSString *LedOn = @"B";
    NSString *LedOff = @"b";
    
    if (0 ==_LedFlag ) {
        [self sendtool:LedOn];
        _LedFlag = 1;
    }
    else{
        [self sendtool:LedOff];
        _LedFlag = 0;
    }
    
    
    
}

- (IBAction)Curtain:(id)sender {
    NSString *CurtainOn = @"K";
    NSString *CurtainOff = @"k";
    
    if (0 ==_CurtainFlag ) {
        [self sendtool:CurtainOn];
        _CurtainFlag = 1;
    }
    else{
        [self sendtool:CurtainOff];
        _CurtainFlag = 0;
    }
    
    
}

- (IBAction)Tv:(id)sender {
    NSString *TvOn = @"N";
    NSString *TvOff = @"n";
    
    if (0 ==_TvFlag ) {
        [self sendtool:TvOn];
        _TvFlag = 1;
    }
    else{
        [self sendtool:TvOff];
        _TvFlag = 0;
    }
    
    
}

- (IBAction)AirSub:(id)sender {
    NSString *AirSub = @"P";
    [self sendtool:AirSub];
    
}

- (IBAction)AirAdd:(id)sender {
    NSString *AirAdd = @"O";
    [self sendtool:AirAdd];
    
}

- (IBAction)Air:(id)sender {
    NSString *AirOn = @"L";
    NSString *AirOff = @"l";
    
    if (0 ==_AirFlag ) {
        [self sendtool:AirOn];
        _AirFlag = 1;
    }
    else{
        [self sendtool:AirOff];
        _AirFlag = 0;
    }
    
    
}

- (IBAction)AllLedOn:(id)sender {
    NSString *AllLedOn = @"Z";
    
    [self sendtool:AllLedOn];
    
}

- (IBAction)AllLedOff:(id)sender {
    
    NSString *AllLedOff = @"z";
    
    [self sendtool:AllLedOff];
    
}


-(void)sendtool:(NSString *)msg{
    //从defaults中读取ip和端口
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *ip = [defaults objectForKey:@"ip" ];
    NSString *port = [defaults objectForKey:@"port"];
    //运用的时候，port必须转整数
    NSInteger portInt = [port intValue];
    
    if(socket==nil)
    {
        socket=[[AsyncSocket alloc] initWithDelegate:self];
        NSError *error=nil;
        if(![socket connectToHost:ip  onPort:portInt error:&error])
        {
            NSLog(@"连接服务器失败!");
        }
        else
        {
            NSLog(@"已连接!");
            [socket writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
            
        }
    }
    else
    {
        NSLog(@"已连接!");
        [socket writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
    
    
}


#pragma mark AsyncScoket Delagate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu",sock,host,port);
    [sock readDataWithTimeout:1 tag:0];
}
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //[sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];  // 这句话仅仅接收\r\n的数据
    
    [sock readDataWithTimeout: -1 tag: 0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"===%@",aStr);
    //  [aStr release];
    NSData* aData= [@"<xml>我<xml>" dataUsingEncoding: NSUTF8StringEncoding];
    [sock writeData:aData withTimeout:-1 tag:1];
    [sock readDataWithTimeout:1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    //断开连接了
    NSLog(@"onSocketDidDisconnect:%p", sock);
    //  NSString *msg = @"Sorry this connect is failure";
    //  _Status.text=msg;
    // [msg release];
    
    socket = nil;
}

@end
