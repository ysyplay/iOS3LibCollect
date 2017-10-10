//
//  Model.m
//  CacheBenchmark
//
//  Created by Runa on 2017/9/30.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "Model.h"

@implementation Model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    return self;
}

@end
