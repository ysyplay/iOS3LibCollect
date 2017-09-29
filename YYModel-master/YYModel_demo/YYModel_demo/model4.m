//
//  model4.m
//  YYModel_demo
//
//  Created by Runa on 2017/9/28.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "model4.h"
#import "model1.h"
@implementation model4
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"arr" : [model1 class],
            };
}

@end
