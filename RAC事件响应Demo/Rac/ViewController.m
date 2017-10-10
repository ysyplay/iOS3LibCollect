//
//  ViewController.m
//  Rac
//
//  Created by Runa on 2017/8/3.
//  Copyright © 2017年 Runa. All rights reserved.
//
//我们所熟知的iOS 开发中的事件包括：
//
//Target
//Delegate
//KVO
//通知
//时钟
//网络异步回调
//
//ReactiveCocoa ，就是用信号接管了iOS 中的所有事件；也就意味着，用一种统一的方式来处理iOS中的所有事件，解决了各种分散的事件处理方式
//高聚合，低耦合
#import "ViewController.h"
#import "ReactiveObjC.h"
#import "Person.h"
@interface ViewController ()
@property NSString *random,*password;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic) RACDelegateProxy *proxy;
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController
- (Person *)person {
    
    if (!_person) {
        _person = [[Person alloc] init];
    }
    return _person;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self demoKvo];
    [self notificationDemo];
    [self delegateDemo];
    [self buttonDemo];
    [self textFileCombination];
    [self demoTextField];
    //1.创建信号,block发送信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //3发送信号
        [subscriber sendNext:@"发送对象"];
        return nil;
    }];
    //2.订阅信号，block接收
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
//点击屏幕改变self.name
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    self.random = [NSString stringWithFormat:@" %d",arc4random_uniform(100)];
}
#pragma -mark KVO 监听
- (void)demoKvo {
    [RACObserve(self.person, password)
     subscribeNext:^(id x) {
         NSLog(@"******* password改变了%@",x);
     }];
}
#pragma -mark 通知
/**
 * 验证此函数：点击textFile时，系统键盘会发送通知，打印出通知的内容
 */
- (void)notificationDemo {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil]
     subscribeNext:^(id x) {
//         NSLog(@"notificationDemo : %@", x);
      }
     ];
}
#pragma -mark 代理方法
/**
 * 验证此函：nameText的输入字符时，输入回撤或者点击键盘的回车键使passWordText变为第一响应者（即输入光标移动到passWordText处）
 */
- (void)delegateDemo {
    @weakify(self)
    // 1. 定义代理
    self.proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
    // 2. 代理去注册文本框的监听方法
    [[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)]
     subscribeNext:^(id x) {
         @strongify(self)
         if (self.TF.hasText) {
             [self.passWordText becomeFirstResponder];
         }
     }];
    self.TF.delegate = (id<UITextFieldDelegate>)self.proxy;
}
#pragma -mark 按钮监听
/**
 * 验证此函数：当loginButton可以点击时，点击button输出person的属性，实现监控的效果
 */
- (void)buttonDemo {
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         NSLog(@"按钮点击了 %@",x);
     }
     ];
}
#pragma -mark 文本信号组合

/**
 * TF和passWordText都有文字时，才允许点击按钮
 */
- (void)textFileCombination{
    id signals = @[[self.TF rac_textSignal],[self.passWordText rac_textSignal]];
    @weakify(self);
    [[RACSignal
      combineLatest:signals]
     subscribeNext:^(RACTuple *x) {
         @strongify(self);
         NSString *name = x[0];
         NSString *password = x[1];
         if (name.length > 0 && password.length > 0) {
             self.loginButton.enabled = YES;
             self.person.name = name;
             self.person.password = password;
             NSLog(@"用户名：%@   密码：%@",name,password);
             
         } else  {
             self.loginButton.enabled = NO;

         }
     }];
}
#pragma -mark 文本框输入事件监听
- (void)demoTextField {
    
    @weakify(self);
    [[self.TF rac_textSignal]
     subscribeNext:^(id x)
    {
         @strongify(self);
         NSLog(@"%@",x);
         self.person.name = x;
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    NSLog(@"没有循环引用。 %s",__FUNCTION__);
}
@end
