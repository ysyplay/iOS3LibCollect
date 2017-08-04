//
//  ViewController.m
//  Splash
//
//  Created by Mac on 16/3/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "SqliteTool.h"
#import "User.h"
#import <sqlite3.h>
//#import "iToast.h"
#import "MBProgressHUD+CZ.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)Login:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Login interface");
    
    [self.password setSecureTextEntry:YES];
    
    
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  -- UITapGestureRecognizer
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
}


#pragma mark  -- uiTextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField

{

    CGRect frame = textField.frame;
    
    int offset = frame.origin.y + 70 - (self.view.frame.size.height - 263.0);//iPhone键盘高度216，iPad的为352,这里设成263更方便，并且考虑到搜狗的键盘比系统的键盘高一点
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:0.5f];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    
    if(offset > -15)
        
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

//输入框编辑完成以后，将视图恢复到原始状态

-(void)textFieldDidEndEditing:(UITextField *)textField

{
    
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}



- (IBAction)Login:(id)sender {
    NSString *Account = self.account.text;
    NSString *Password = self.password.text;

    // 准备查询
    NSString *sql = @"select * from t_user;";
    
    NSArray *arr = [SqliteTool selectWithSql:sql];
    [MBProgressHUD showMessage:@"正在登录中。。。"];
    //模拟登录有一个等待过程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //登录完成 隐藏提示框
        
        [MBProgressHUD hideHUD];
 
    
    NSInteger flag = 0 ;
    //遍历数组，验证帐号密码
    for (User *s in arr) {
        
        if([s.account isEqualToString:Account]&&[s.password isEqualToString:Password]){
               flag = 1;
        }
        
    }
    if(flag == 0){
        // [[iToast makeText:NSLocalizedString(@"用户名或密码错误", @"")] show];
        [MBProgressHUD showError:@"用户名或密码错误"];
    }else{
            
        //执行一个segue，就会进入segue所指的控制器
        [self performSegueWithIdentifier:@"toHome" sender:nil];
        //[[iToast makeText:NSLocalizedString(@"欢迎使用", @"")] show];
        [MBProgressHUD showSuccess:@"欢迎使用"];
    }
    
    });
    
}
@end

