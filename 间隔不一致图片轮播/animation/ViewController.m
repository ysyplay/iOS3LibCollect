//
//  ViewController.m
//  animation
//
//  Created by Runa on 2017/10/13.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "ViewController.h"
#define WEAK  __weak typeof(self) weakSelf = self
@interface ViewController ()
{
    NSOperationQueue *queue;
}
@property BOOL cancel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo1];
}
-(void)demo1
{
    NSArray *imagesArray = @[[UIImage imageNamed:@"1"],
                             [UIImage imageNamed:@"2"],
                             [UIImage imageNamed:@"3"],
                             [UIImage imageNamed:@"4"],
                             [UIImage imageNamed:@"5"]];
    NSArray *timeIntervals = @[@1,@2,@3,@4,@5];
    UIImageView *animationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 131, 125)];
    __block int i = 0;
    [self.view addSubview:animationImageView];
    dispatch_queue_t queue = dispatch_queue_create("ImageViewqueue", DISPATCH_QUEUE_SERIAL);
    WEAK;
    dispatch_async(queue, ^{
        //线程一旦开启，只有将block内的事做完，系统才会进行回收处理，这里用weakSelf避免VC已经销毁，但线程任务还在继续。
        while (weakSelf)
        {
            if (weakSelf.cancel)
            {
                 //通过外部按钮，退出循环
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"切换   %d",i+1);
                animationImageView.image = imagesArray[i];
            });
            sleep([timeIntervals[i] intValue]);
            i++;
            if (i==imagesArray.count)
            {
                i=0;
            }
          
        }
        NSLog(@"线程任务结束");
    });
}
- (IBAction)stop:(id)sender
{
    _cancel = YES;
}
-(void)dealloc
{
   NSLog(@"干掉了  %s",__FUNCTION__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
