//
//  HomeViewController.m
//  Splash
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HomeViewController.h"
enum cutType{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};
typedef enum cutType cutType;
@interface HomeViewController ()
{
    BOOL isConnected;
}
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
@property (nonatomic, retain) NSTimer        *connectTimer; // 计时器
@property (nonatomic,assign) cutType cuttype;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"Home");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Monitor:(id)sender
{
    NSString *MonitorOn = @"G";
    NSString *MonitorOff = @"g";

    if (0 ==_MonitorFlag )
    {
        [self sendtool:MonitorOn];
        _MonitorFlag = 1;
    }
    else
    {
        [self sendtool:MonitorOff];
        _MonitorFlag = 0;
    }
}

- (IBAction)Led:(id)sender {
    NSString *LedOn = @"A";
    NSString *LedOff = @"a";
    
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
    NSString *CurtainOn = @"D";
    NSString *CurtainOff = @"d";
    
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
    NSString *TvOn = @"H";
    NSString *TvOff = @"h";
    
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
     NSString *AirSub = @"J";
    [self sendtool:AirSub];
    
}

- (IBAction)AirAdd:(id)sender {
    NSString *AirAdd = @"I";
    [self sendtool:AirAdd];
    
}

- (IBAction)Air:(id)sender {
    NSString *AirOn = @"E";
    NSString *AirOff = @"e";
    
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
    if(!socket)
    {
        NSLog(@"创建socket");
        socket=[[AsyncSocket alloc] initWithDelegate:self];
       
        if(![socket connectToHost:ip  onPort:portInt withTimeout:3 error:nil])
        {
            NSLog(@"连接服务器失败!");
        }
        else
        {
            NSLog(@"已连接1!");
            [socket writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
        }
    }
    else
    {
        NSLog(@"已连接2!");
        [socket writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
    isConnected = YES;
}
-(void)socketConnectHost
{
    //从defaults中读取ip和端口
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *ip = [defaults objectForKey:@"ip" ];
    NSString *port = [defaults objectForKey:@"port"];
    //运用的时候，port必须转整数
    NSInteger portInt = [port intValue];
    if(!socket)
    {
        NSLog(@"创建socket");
        socket=[[AsyncSocket alloc] initWithDelegate:self];
     
    }
    if(![socket connectToHost:ip  onPort:portInt withTimeout:3 error:nil])
    {
        NSLog(@"连接服务器失败!");
        
    }
    isConnected = YES;
}
#pragma mark AsyncScoket Delagate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
     NSLog(@"socket连接成功");
    isConnected = NO;
    [sock readDataWithTimeout:-1 tag:0];
    if (!self.connectTimer)
    {
        self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:45 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
        [self.connectTimer fire];
    }

}
// 心跳连接
-(void)longConnectToSocket{
    
    NSLog(@"心跳");
    // 根据服务器要求发送固定格式的数据，假设为指令@"longConnect"，但是一般不会是这么简单的指令
    
    NSString *longConnect = @"longConnect";
    
    NSData   *dataStream  = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    
    [socket writeData:dataStream withTimeout:-1 tag:1];
    
}
// 切断socket
-(void)cutOffSocket
{
    NSLog(@"切断链接");
    [self.connectTimer invalidate];
    self.cuttype = SocketOfflineByUser;
    [socket disconnect];
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"sorry the connect is failure %ld",sock.userData);

   if (sock.userData == SocketOfflineByUser) {
        // 如果由用户断开，不进行重连
        return;
    }
    else
    {
        socket = nil; //这里的实验soket貌似每次都断开了链接
        if (!isConnected)
        {
            [self socketConnectHost];
        }
        
        NSLog(@"重连");
    }
}
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //[sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];  // 这句话仅仅接收\r\n的数据
    NSLog(@"已经写了数据");

}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
     NSLog(@"已经读了数据");
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"===%@",aStr);
    //  [aStr release];
//    NSData* aData= [@"<xml>我<xml>" dataUsingEncoding: NSUTF8StringEncoding];
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

@end
