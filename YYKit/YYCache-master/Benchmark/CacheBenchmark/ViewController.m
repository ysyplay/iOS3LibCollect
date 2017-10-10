//
//  ViewController.m
//  CacheBenchmark
//
//  Created by ibireme on 2017/6/29.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "ViewController.h"
#include "Benchmark.h"
#import "YYCache.h"
#import "Model.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [Benchmark benchmark];
//    });
//    [self example1];
//    [self example2];
//    [self example3];
      [self example4];
}
#pragma mark 同步方式
-(void)example1
{
    //模拟数据
    NSString *value=@"同步方式?";
    //模拟一个key
    //同步方式
    NSString *key=@"key";
    YYCache *yyCache=[YYCache cacheWithName:@"LCJCache"];
    //根据key写入缓存value
    [yyCache setObject:value forKey:key];
    //判断缓存是否存在
    BOOL isContains=[yyCache containsObjectForKey:key];
    NSLog(@"containsObject : %@", isContains?@"YES":@"NO");
    //根据key读取数据
    id vuale=[yyCache objectForKey:key];
    NSLog(@"value : %@",vuale);
    //根据key移除缓存
    [yyCache removeObjectForKey:key];
    //移除所有缓存
    [yyCache removeAllObjects];
}
#pragma mark 异步方式
-(void)example2
{
    //模拟数据
    NSString *value=@"异步方式";
    //模拟一个key
    //异步方式
    NSString *key=@"key";
    YYCache *yyCache=[YYCache cacheWithName:@"LCJCache"];
    //根据key写入缓存value
    [yyCache setObject:value forKey:key withBlock:^{
        NSLog(@"setObject sucess");
    }];
    //判断缓存是否存在
    [yyCache containsObjectForKey:key withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"containsObject : %@", contains?@"YES":@"NO");
    }];
    
    //根据key读取数据
    [yyCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"objectForKey : %@",object);
    }];
    
    //根据key移除缓存
    [yyCache removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
        NSLog(@"removeObjectForKey %@",key);
    }];
    //移除所有缓存
    [yyCache removeAllObjectsWithBlock:^{
        NSLog(@"removeAllObjects sucess");
    }];
    
    //移除所有缓存带进度
    [yyCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        NSLog(@"removeAllObjects removedCount :%d  totalCount : %d",removedCount,totalCount);
    } endBlock:^(BOOL error) {
        if(!error){
            NSLog(@"removeAllObjects sucess");
        }else{
            NSLog(@"removeAllObjects error");
        }
    }];
}
#pragma mark YYCache缓存LRU清理
-(void)example3
{
    //具体还有几个limit可查.h
    YYCache *yyCache=[YYCache cacheWithName:@"LCJCache"];
    [yyCache.memoryCache setCountLimit:50];//内存最大缓存数据个数
    [yyCache.memoryCache setCostLimit:1*1024];//内存最大缓存开销 目前这个毫无用处
    
    [yyCache.diskCache setCostLimit:10*1024];//磁盘最大缓存开销
    [yyCache.diskCache setCountLimit:50];//磁盘最大缓存数据个数
    [yyCache.diskCache setAutoTrimInterval:60];//设置磁盘lru动态清理频率 默认 60秒
    
    //模拟一下清理
    for(int i=0 ;i<100;i++){
        //模拟数据
        NSString *value=@"I want to know who is lcj ?";
        //模拟一个key
        NSString *key=[NSString stringWithFormat:@"key%d",i];
        [yyCache setObject:value forKey:key];
    }
    
    NSLog(@"yyCache.memoryCache.totalCost:%lu",(unsigned long)yyCache.memoryCache.totalCost);
    NSLog(@"yyCache.memoryCache.costLimit:%lu",(unsigned long)yyCache.memoryCache.costLimit);
    
    NSLog(@"yyCache.memoryCache.totalCount:%lu",(unsigned long)yyCache.memoryCache.totalCount);
    NSLog(@"yyCache.memoryCache.countLimit:%lu",(unsigned long)yyCache.memoryCache.countLimit);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"yyCache.diskCache.totalCost:%lu",(unsigned long)yyCache.diskCache.totalCost);
        NSLog(@"yyCache.diskCache.costLimit:%lu",(unsigned long)yyCache.diskCache.costLimit);
        
        NSLog(@"yyCache.diskCache.totalCount:%lu",(unsigned long)yyCache.diskCache.totalCount);
        NSLog(@"yyCache.diskCache.countLimit:%lu",(unsigned long)yyCache.diskCache.countLimit);
        
        for(int i=0 ;i<100;i++)
        {
            //模拟一个key
            NSString *key=[NSString stringWithFormat:@"key%d",i];
            id vuale=[yyCache objectForKey:key];
            NSLog(@"key ：%@ value : %@",key ,vuale);
        }
    });
}
#pragma mark 缓存自定义对象需实现<NSCoding>
-(void)example4
{
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];

    YYCache *yyCache=[YYCache cacheWithName:@"LCJCache"];
    for(int i=0 ;i<100;i++)
    {
        Model *m = [[Model alloc] init];
        m.name = [@(i) stringValue];
        NSString *key=[NSString stringWithFormat:@"key%d",i];
        [yyCache setObject:m forKey:key];
    }
    for(int i=0 ;i<100;i++)
    {
        //模拟一个key
        NSString *key=[NSString stringWithFormat:@"key%d",i];
        Model *vuale=(Model *)[yyCache objectForKey:key];
        NSLog(@"key ：%@ value : %@",key ,vuale.name);
    }
    [yyCache removeAllObjects];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
