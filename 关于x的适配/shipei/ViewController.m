//
//  ViewController.m
//  shipei
//
//  Created by Runa on 2017/10/11.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "YsyDeviceInfoToos.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *NAVView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[YsyDeviceInfoToos getDeviceName] isEqualToString:@"Simulator"])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                for (NSLayoutConstraint *constraint in _NAVView.constraints)
                {
                    NSLog(@"循环");
                    if (constraint.firstAttribute == NSLayoutAttributeHeight)
                    {
                        NSLog(@"变化88");
                        constraint.constant = 88;
                    }
                }
            });
        });
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (IBAction)buttClick:(id)sender
{
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
