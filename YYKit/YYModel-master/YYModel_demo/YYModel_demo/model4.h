//
//  model4.h
//  YYModel_demo
//
//  Created by Runa on 2017/9/28.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "YsyModel.h"


@class model1;
@interface model4 : YsyModel
@property NSString *title;
@property NSArray *arr; //Array<model1>
@property NSDictionary *dic; //Dict<NSString,model1>
@end
