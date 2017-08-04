//
//  RegisterViewController.m
//  Splash
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "SqliteTool.h"
#import "User.h"
#import <sqlite3.h>
//#import "iToast.h"
#import "MBProgressHUD+CZ.h"
@interface RegisterViewController ()
- (IBAction)Register:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[[iToast makeText:NSLocalizedString(@"欢迎注册", @"")] show];
    [MBProgressHUD showNormalMessage:@"欢迎注册" toView:self.view];
    //创建表
    NSString *sql = @"create table if not exists t_user (id integer primary key autoincrement,account text,password text);";
    [SqliteTool execWithSql:sql];
    
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    
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

- (IBAction)Register:(id)sender {
    NSString *Account = self.account.text;
    NSString *Password = self.password.text;
    
    //NSString *sql = @"insert into t_user (account,password) values ('yz',18);";
    NSString *sql = [NSString stringWithFormat:@"insert into t_user (account,password) values ('%@','%@');",Account,Password];
    
    
    [SqliteTool execWithSql:sql];
   // [[iToast makeText:NSLocalizedString(@"注册成功,请返回登录界面", @"")] show];
    [MBProgressHUD showSuccess:@"注册成功,请返回登录界面"];
    
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

@end
