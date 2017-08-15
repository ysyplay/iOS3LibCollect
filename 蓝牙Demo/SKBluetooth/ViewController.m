//
//  ViewController.m
//  SKBluetooth
//
//  Created by 孙恺 on 15/8/8.
//  Copyright (c) 2015年 Kai Sun. All rights reserved.
//

#import "ViewController.h"
#import "YsyBluetoothManager.h"

@interface ViewController ()<YsyBluetoothManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;

@property (strong, nonatomic) YsyBluetoothManager *bluetoothManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bluetoothManager = [[YsyBluetoothManager alloc] init];
    self.bluetoothManager.delegate = self;
    
}
- (IBAction)pressSendButton:(id)sender {
    if (self.textfield.text) {
        [self.bluetoothManager writeToPeripheral:self.textfield.text];
    }
}

- (void)didGetDataForString:(NSString *)dataString {
    [self.textfield setText:[NSString stringWithFormat:@"Receive:%@",dataString]];
    NSLog(@"收到：%@",[NSString stringWithFormat:@"Receive:%@",dataString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
