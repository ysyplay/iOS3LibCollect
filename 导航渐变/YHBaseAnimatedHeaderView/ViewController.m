//
//  ViewController.m
//  YHBaseAnimatedHeaderView
//
//  Created by vip on 16/4/26.
//  Copyright © 2016年 jaki. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)present:(id)sender {
    [self presentViewController:[[SecondViewController alloc] init] animated:YES completion:nil];
}
- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
