//
//  YsyModel.h
//  YYModel_demo
//
//  Created by Runa on 2017/9/28.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YsyModel : NSObject<NSCoding>
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)copyWithZone:(NSZone *)zone;
- (NSUInteger)hash;
- (BOOL)isEqual:(id)object;
- (NSString *)description;
@end
