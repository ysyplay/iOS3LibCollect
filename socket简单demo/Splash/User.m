//
//  User.m
//  Splash
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "User.h"

@implementation User
+ (instancetype)userWithAccount:(NSString *)account password:(NSString *)password
{
    User *s = [[self alloc] init];
    
    s.account = account;
    s.password = password;
    
    return s;
}
@end
