//
//  ViewController1.m
//  JPushDemo
//
//  Created by Runa on 2017/6/16.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController.h"
#import "JPUSHService.h"
@interface ViewController1 ()
{
    UILabel *label;
}
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    label = [[UILabel alloc]init];
    
    label.frame =CGRectMake(100,100,200, 200);
    
    label.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:label];
    
    label.text =@"1dsafafaf";
    label.numberOfLines = 0;
  
    [label sizeToFit];
      NSLog(@"**** %f",label.frame.size.height);
}
- (IBAction)click:(id)sender
{
    ViewController *vc1 = [[ViewController alloc] init];
    vc1.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc1 animated:YES];
}
//如果提示没有目标，网站重新登录以下
- (IBAction)butt1:(id)sender
{
    [JPUSHService setAlias:@"1" callbackSelector:nil object:nil];
}
- (IBAction)butt2:(id)sender
{
    [JPUSHService setAlias:@"2" callbackSelector:nil object:nil];
}
//取消推送别名
- (IBAction)clear:(id)sender
{
    [JPUSHService setAlias:@"0" callbackSelector:nil object:nil];
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

@end
