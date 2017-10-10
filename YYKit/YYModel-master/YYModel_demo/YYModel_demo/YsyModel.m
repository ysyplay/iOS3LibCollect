//
//  YsyModel.m
//  YYModel_demo
//
//  Created by Runa on 2017/9/28.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "YsyModel.h"
#import "YYModel.h"
//可以作为以下演示model的父类，以下方法为分装//Coding/Copying/hash/equal/description
@implementation YsyModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}
- (NSUInteger)hash
{
    return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object
{
    return [self yy_modelIsEqual:object];
}
- (NSString *)description
{
    return [self yy_modelDescription];
}
@end
