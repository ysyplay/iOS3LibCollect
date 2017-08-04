//
//  ViewController.m
//  SGImagePickerController
//
//  Created by yyx on 15/9/17.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import "ViewController.h"
#import "SGImagePickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
    picker.maxCount = 2;
    //返回选择的缩略图
    [picker setDidFinishSelectThumbnails:^(NSArray *thumbnails)
     {
        NSLog(@"缩略图%@",thumbnails);
    }];
    
    //返回选中的原图
    [picker setDidFinishSelectImages:^(NSArray *images)
     {
        NSLog(@"原图%@",images);
    }];
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
