//
//  User.h
//  Splash
//
//  Created by Mac on 16/3/30.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
+ (instancetype)userWithAccount:(NSString *)account password:(NSString *)password;

@end
