//
//  SKBluetoothManager.h
//  SKBluetoothManager
//
//  Created by 孙恺 on 15/5/15.
//  Copyright (c) 2015年 Kai Sun. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

@protocol YsyBluetoothManagerDelegate

@required
//这个代理方法用来读取外设信息
- (void)didGetDataForString:(NSString *)dataString;

@end

@interface YsyBluetoothManager : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>{
    CBCentralManager *manager;
    id<YsyBluetoothManagerDelegate> delegate;
}

@property BOOL isConnected;
@property (retain, nonatomic) id<YsyBluetoothManagerDelegate> delegate;
@property (nonatomic, strong) CBPeripheral *peripheral;

- (void)writeToPeripheral:(NSString *)dataString;
@end
