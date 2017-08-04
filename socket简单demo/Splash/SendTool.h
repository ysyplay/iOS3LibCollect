//
//  SendTool.h
//  Splash
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

//发送工具类，把连接也包含进去了
#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
@interface SendTool : NSObject
{
    AsyncSocket *socket;
}

-(void)SendMsg:(NSString *)msg ;



@end
