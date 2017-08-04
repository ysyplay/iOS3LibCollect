//
//  ViewController.m
//  评分
//
//  Created by LH on 15/11/5.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "ViewController.h"
#import "LHRatingView.h"

@interface ViewController ()<ratingViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(20, 100, 280, 60)];
    rView.center = self.view.center;
    rView.enable = YES;
    rView.ratingType = INTEGER_TYPE;//半颗星(默认显示小数模式，只读状态下不可设置整型状态半颗星，否则数据读出有bug)
    rView.delegate = self;
    [self.view addSubview:rView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    NSLog(@"分数  %.2f",score);
    
}

@end
