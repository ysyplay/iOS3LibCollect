//
//  model3.h
//  YYModel_demo
//
//  Created by Runa on 2017/9/28.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "YsyModel.h"
@class model3_1;
@interface model3 : YsyModel
@property NSString *name;
@property NSString *pages;
@property model3_1 *author; //model3 包含 model3_1属性
@end
