//
//  SqliteTool.m
//  Splash
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SqliteTool.h"
#import <sqlite3.h>
#import "User.h"
@implementation SqliteTool
static sqlite3 *_db;
// 初始化数据库
+ (void)initialize
{
    // 之前是都是保存到docment，最近保存到docment，苹果不允许上传。
    // 游戏一般都是document
    // 获取cache文件夹路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"User.sqlite"];
    
    
    // 打开数据库，就会创建数据库文件
    // fileName保存数据库的全路径文件名
    // ppDb:数据库实例
    
    
    // 打开数据库
    if (sqlite3_open(filePath.UTF8String, &_db) == SQLITE_OK) {// 打开成功
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
        
    }
}

+ (void)execWithSql:(NSString *)sql
{
    
    char *errmsg;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (errmsg) {
        NSLog(@"操作失败--%s",errmsg);
    }else{
        NSLog(@"操作成功");
    }
}

+ (NSArray *)selectWithSql:(NSString *)sql
{
    
    // 数据库语句的字节数 -1 表示自动计算字节数
    // ppStmt句柄：用来操作查询的数据
    sqlite3_stmt *stmt;
    NSMutableArray *arrM = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        
        // 准备成功
        // 执行句柄
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int ID = sqlite3_column_int(stmt, 0);
            // 有数据
            NSString *account = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 1)];
            
            NSString *password = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 2)];
            //sqlite3_column_int(stmt, 2);
            
           // User *s = [Student studentWithName:name age:age];
            User *s = [User userWithAccount:account password:password];
            [arrM addObject:s];
            
        }
        
    }
    
    return arrM;
}

@end
