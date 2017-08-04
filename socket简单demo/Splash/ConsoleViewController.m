//
//  ConsoleViewController.m
//  Splash
//
//  Created by Mac on 16/3/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ConsoleViewController.h"


@interface ConsoleViewController ()

- (IBAction)BeeWarningSwitch:(id)sender;
- (IBAction)BalconyLedSwitch:(id)sender;
- (IBAction)CorridorLedSwitch:(id)sender;
- (IBAction)ElectricalCookerSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *BeeWarning;
@property (weak, nonatomic) IBOutlet UISwitch *BalconyLed;

@property (weak, nonatomic) IBOutlet UISwitch *ElectricalCooker;

@property (weak, nonatomic) IBOutlet UISwitch *CorridorLed;


@end

@implementation ConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BeeWarning.on = NO;
    self.BalconyLed.on = NO;
    self.CorridorLed.on = NO;
    self.ElectricalCooker.on = NO;
    
    NSLog(@"这是Console");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//  要发送的时候才建立连接


- (IBAction)BeeWarningSwitch:(id)sender {

    NSString *BeeOnMsg = @"F";
    NSString *BeeOffMsg = @"f";
    if(self.BeeWarning.isOn == NO){
        [self sendtool:BeeOffMsg];
        
    }
    else{
     [self sendtool:BeeOnMsg];
    }


    
}

- (IBAction)BalconyLedSwitch:(id)sender {
    NSString *BalconyOnMsg = @"W";
    NSString *BalconyOffMsg = @"w";
    if(self.BalconyLed.isOn == NO){
        [self sendtool:BalconyOffMsg];
        
    }
    else{
        [self sendtool:BalconyOnMsg];
    }

}

- (IBAction)CorridorLedSwitch:(id)sender {
    NSString *CorridorOnMsg = @"X";
    NSString *CorridorOffMsg = @"x";
    if(self.CorridorLed.isOn == NO){
        [self sendtool:CorridorOffMsg];
        
    }
    else{
        [self sendtool:CorridorOnMsg];
    }
}

- (IBAction)ElectricalCookerSwitch:(id)sender {
    NSString *ElectricalCookerOnMsg = @"Y";
    NSString *ElectricalCookerOffMsg = @"y";
    if(self.ElectricalCooker.isOn == NO){
        [self sendtool:ElectricalCookerOffMsg];
        
    }
    else{
        [self sendtool:ElectricalCookerOnMsg];
    }
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
