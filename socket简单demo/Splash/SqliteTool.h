//
//  SqliteTool.h
//  Splash
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteTool : NSObject
// 插入。删除，修改
+ (void)execWithSql:(NSString *)sql;
+ (NSArray *)selectWithSql:(NSString *)sql;
@end
