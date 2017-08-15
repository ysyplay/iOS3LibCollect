//
//  SKBluetoothManager.m
//  SKBluetoothManager
//
//  Created by 孙恺 on 15/5/15.
//  Copyright (c) 2015年 Kai Sun. All rights reserved.
//
/*
蓝牙连接可以大致分为以下几个步骤
1.建立一个Central Manager实例进行蓝牙管理
2.搜索外围设备
3.连接外围设备
4.获得外围设备的服务
5.获得服务的特征
6.从外围设备读数据
7.给外围设备发送数据
其他：提醒
*/
//  请务必根据您所使用的设备来修改 UUID

#define kPeripheralUUID @"F92FE801-4151-A61F-28DA-BD109B645CBA"

#define kServiceUUID @"49535343-FE7D-4AE5-8FA9-9FAFD205E455"
#define kCharacteristicWriteUUID @"2A2B"            // inUse
#define kCharacteristicNotifyUUID @"49535343-1E4D-4BD9-BA61-23C647249616"           // inUse
#define kCharacteristicWriteNotifyUUID @"49535343-ACA3-481C-91EC-D85E28A60318"
#define kCharacteristicReadWriteUUID @"49535343-6DAA-4D02-ABF6-19569ACA69FE"

#import "YsyBluetoothManager.h"

@interface YsyBluetoothManager()
{
    NSTimer *timer;
}
@property (strong,nonatomic) NSMutableArray *peripherals;   //连接的外围设备
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@end

@implementation YsyBluetoothManager

@synthesize delegate=delegate;

#pragma mark - Public Methods
//向外设写入数据
- (void)writeToPeripheral:(NSString *)dataString {
    if(_writeCharacteristic == nil){
        NSLog(@"writeCharacteristic 为空");
        return;
    }
    NSData *value = [self dataWithHexstring:dataString];
//    NSLog(@"十六进制:%@",value);
    [_peripheral writeValue:value forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
    NSLog(@"已经向外设%@写入数据%@",_peripheral.name,dataString);

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        manager.delegate = self;
        _isConnected = NO;
    }
    return self;
}
#pragma mark - CBCentralManager Delegate
//只要中心管理者初始化 就会触发此代理方法 判断手机蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString * state = nil;
    
    switch ([central state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"StateUnsupported";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"StateUnauthorized";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"PoweredOff";
            break;
        case CBCentralManagerStatePoweredOn:
        {
            state = @"PoweredOn";
            NSLog(@"开始扫描");
            //监测到蓝牙开启状态,搜索外设
            [self scanDevices];
            
        }
            break;
        case CBCentralManagerStateUnknown:
            state = @"unknown";
            break;
        default:
            break;
    }
    NSLog(@"手机状态:%@", state);
}
-(void)scanDevices
{
    if (timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(ConnectedDevices) userInfo:nil repeats:YES];
    }
    [manager scanForPeripheralsWithServices:nil options:nil];
}
-(void)stopScanDevices
{
    [manager stopScan];
    [timer invalidate];
     timer = nil;
}
//搜索已配对设备
-(void)ConnectedDevices
{
    //已经被系统或者其他APP连接上的设备数组
    NSArray *arr = [manager retrieveConnectedPeripheralsWithServices:@[[CBUUID UUIDWithString:@"1805"]]];
    NSLog(@"连接数量 %lu",(unsigned long)arr.count);
    if(arr.count>0)
    {
        for (CBPeripheral* peripheral in arr)
        {
            if (peripheral != nil)
            {
                [self stopScanDevices];
                peripheral.delegate = self;
                self.peripheral = peripheral;
                [manager connectPeripheral:self.peripheral options:nil];
            }
        }
    }
}
/**
 发现外设后
 @param central 中心管理者
 @param peripheral 外设
 @param advertisementData 外设携带的数据
 @param RSSI 外设发出的蓝牙信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *str = [NSString stringWithFormat:@"发现外设:%@ rssi:%@, UUID:%@ advertisementData: %@ ", peripheral, RSSI, peripheral.identifier.UUIDString, advertisementData];
    NSLog(@"%@",str);
    [_peripherals addObject:peripheral];
    
    if ([peripheral.name isEqualToString:@"WeLoop Now2 66BD0D"])
    {
        [self stopScanDevices];
        [manager connectPeripheral:peripheral options:nil];
        NSLog(@"连接外设:%@",peripheral.description);
        self.peripheral = peripheral;
    }
}
/**
 连接到外设后
 @param central 中心管理者
 @param peripheral 外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"已经连接到:%@", peripheral.description);
    // 连接成功之后,可以进行服务和特征的发现
    //  设置外设的代理
    peripheral.delegate = self;
    //停止扫描
    [central stopScan];
    // 外设发现服务,传nil代表不过滤   
    // 这里会触发外设的代理方法didDiscoverServices
    [peripheral discoverServices:nil];
}
// 连接失败后
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接外设%@失败",peripheral);
}

// 断开外设
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"与%@断开连接",peripheral);
    [self scanDevices];
}
#pragma mark - CBPeripheral Delegate
//找到服务（一个外设有多个服务）
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"已发现服务");
    if (error) {
        NSLog(@"搜索服务%@时发生错误:%@", peripheral.name, [error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services)
    {
         NSLog(@"发现服务:%@", service.UUID);
        //根据某个服务去寻找服务下的特征
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"1805"]]) {
            [peripheral discoverCharacteristics:nil forService:service];
            break;
        }
    }
}
//找到特征，（一个服务有多个特征）
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"搜索特征%@时发生错误:%@", service.UUID, [error localizedDescription]);
        return;
    }
    NSLog(@"服务:%@下的特征遍历",service.UUID);
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"发现特征:%@",characteristic);
        //找到指定的特征
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicWriteUUID]])
        {
            _writeCharacteristic = characteristic;
        }
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A2B"]])
        {
            NSLog(@"监听特征:%@",characteristic);//监听特征
            [self.peripheral readValueForCharacteristic:characteristic];
//            [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
            _isConnected = YES;
        }
    }
}
// 更新特征的value的时候会调用 （凡是从蓝牙传过来的数据都要经过这个回调，简单的说这个方法就是你拿数据的唯一方法）
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"*****************更新特征的value的时候会调用**************");
    if (error)
    {
        NSLog(@"更新特征值%@时发生错误:%@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    // 收到数据
//    NSLog(@"%@",characteristic.value);
    //这里可以加个判断用来接收指定特征的返回
//    if (characteristic == @"你要的特征的UUID或者是你已经找到的特征")
//    {
        //characteristic.value就是你要的数据
        [delegate didGetDataForString:[self hexadecimalString:characteristic.value]];
//    }
//    NSLog(@"%@",[self hexadecimalString:characteristic.value]);
}

#pragma mark - NSData and NSString

//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}
//将传入的NSString类型转换成NSData并返回
- (NSData*)dataWithHexstring:(NSString *)hexstring{
    NSData* aData;
    return aData = [hexstring dataUsingEncoding: NSASCIIStringEncoding];
}

@end
