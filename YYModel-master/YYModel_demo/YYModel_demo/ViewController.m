//
//  ViewController.m
//  YYModel_demo
//
//  Created by Runa on 2017/9/28.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "model1.h"
#import "model2.h"
#import "model3.h"
#import "model3_1.h"
#import "model4.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *json1 = @{
                            @"uid":@123456,
                            @"name":@"Harry",
                            @"created":@"1965-07-31T00:00:00+0000"
                            };
    //当 JSON/Dictionary 中的对象类型与 Model 属性不一致时，YYModel 将会进行如下自动转换。自动转换不支持的值将会被忽略，以避免各种潜在的崩溃问题。
    model1 *m1 = [model1 yy_modelWithJSON:json1];
    NSLog(@"m1:  %@",m1);
    
    //2.Model 属性名和 JSON 中的 Key 不相同
    NSDictionary *json2 = @{
                            @"n":@"Harry Pottery",
                            @"p": @256,
                            @"ext" : @{
                                @"desc" : @"A book written by J.K.Rowing."
                            },
                            @"ID" : @100010
                            };
    model2 *m2 = [model2 yy_modelWithJSON:json2];
    NSLog(@"m2:  %@",m2);
    
    //3.Model 包含其他 Model,model3下有个属性为model3_1的对象，自动解析
    NSDictionary *json3 = @{
                            @"author":@{
                                @"name":@"J.K.Rowling",
                                @"birthday":@"1965-07-31T00:00:00+0000"
                            },
                            @"name":@"Harry Potter",
                            @"pages":@256
                            };
    model3 *m3 = [model3 yy_modelWithJSON:json3];
   
    NSLog(@"m3: %@   %@",m3, m3.author.name);
    //4.容器类属性
    NSDictionary *json4 = @{
                            @"title":@"这是一个标题",
                            @"arr":@[@{
                                         @"uid":@1,
                                         @"name":@"Harry",
                                         @"created":@"1965-07-31T00:00:00+0000"
                                         },
                                     @{
                                         @"uid":@2,
                                         @"name":@"Harry",
                                         @"created":@"1965-07-31T00:00:00+0000"
                                         }
                                     ],
                            @"dic":@{
                                       @"uid":@123456,
                                       @"name":@"Harry",
                                    @"created":@"1965-07-31T00:00:00+0000"
                                    },
                            };
    model4 *m4 = [model4 yy_modelWithJSON:json4];
    NSLog(@"m4:  %@ ",[m4 yy_modelDescription]);
    //5.黑名单与白名单  通过model2演示
    //6.数据校验与自定义转换 通过model1演示
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
