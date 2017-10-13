//
//  Ysy_Cell.m
//  Demo
//
//  Created by Runa on 2017/9/29.
//  Copyright © 2017年 forkingdog. All rights reserved.
//

#import "Ysy_Cell.h"
#import "UITableViewCell+YsyTemplateLayoutCell.h"
@implementation Ysy_Cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentLab.backgroundColor = [UIColor yellowColor];
    // Initialization code
}
//如果下边界放掉，原有框架调用此方法，若下边界不放，则自动适配
- (CGSize)sizeThatFits:(CGSize)size
{
     NSLog(@"手动计算1");
    CGFloat totalHeight = 0;
    totalHeight += [self.titlelab sizeThatFits:size].height;
    size = CGSizeMake(size.width-16, size.height);
    totalHeight += [self.contentLab sizeThatFits:size].height;
    totalHeight += 40; // margins
    return CGSizeMake(size.width, totalHeight);
}
//如果下边界放掉，ysy添加的框架方法调用此方法
-(CGFloat)calculateHeight:(CGSize)size
{
    NSLog(@"手动计算2");
    CGFloat totalHeight = 0;
    totalHeight += [self.titlelab sizeThatFits:size].height;
    size = CGSizeMake(size.width-16, size.height);
    totalHeight += [self.contentLab sizeThatFits:size].height;
    totalHeight += 40; // margins
    return totalHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
