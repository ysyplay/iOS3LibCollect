//
//  ViewController2.m
//  shipei
//
//  Created by Runa on 2017/10/11.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "ViewController2.h"
#import "YsyDeviceInfoToos.h"
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define NAVIGATIONBAR (kDevice_Is_iPhoneX ? 88 :64)
#define STATUSBARH (kDevice_Is_iPhoneX ? 44 :20)
#define TABBAR (kDevice_Is_iPhoneX ? 83 :49)
@interface ViewController2 ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *NAVView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIButton *leftButt;
@property (weak, nonatomic) IBOutlet UIButton *rightButt;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation ViewController2
- (void)viewDidLoad
{
    [super viewDidLoad];
    //这里使用x的模拟器
    if ([[YsyDeviceInfoToos getDeviceName] isEqualToString:@"Simulator"])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                for (NSLayoutConstraint *constraint in _NAVView.constraints)
                {
                    //寻找某条约束，宽高这样的自身属性找自己遍历的constraints
                    //边界约束遍历父视图的constraints
                    //约束归谁所有，谁就是firstItem
                    NSLog(@"循环  第一条 %ld 第一条 %ld",(long)constraint.firstAttribute,(long)constraint.secondAttribute);
                    NSLog(@"约束值 %f",constraint.constant);
                    if (constraint.firstAttribute == NSLayoutAttributeHeight)
                    {
                        NSLog(@"变化88");
                        constraint.constant = 88;
                    }
                    if (constraint.firstAttribute == NSLayoutAttributeBottom)
                    {
                        //改变左边butt的botttom
                        if (constraint.secondItem == _leftButt)
                        {
                            //本来是贴底的
                            constraint.constant = 5;
                        }
                    }
                }
            });
        });
    }
    _table.delegate = self;
    _table.dataSource =self;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",(long)indexPath.row];
    return cell;
}
- (IBAction)butt:(id)sender
{
    NSLog(@"现在的约束");
    NSLog(@"**  %@",_NAVView.constraints);
}
- (IBAction)pop:(id)sender
{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
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
