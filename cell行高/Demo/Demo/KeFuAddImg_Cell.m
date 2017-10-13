//
//  KeFuAddImg_Cell.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/13.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "KeFuAddImg_Cell.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface KeFuAddImg_Cell ()

@end

@implementation KeFuAddImg_Cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"*******");
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _upImageView = [[UIView alloc] initWithFrame:CGRectMake(12,40, SCREEN_WIDTH-24, 10)];
    _upImageView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_upImageView];
}
- (IBAction)add:(id)sender
{
    if (_RefreshBlock)
    {
        _upImageView.frame = CGRectMake(12,40, SCREEN_WIDTH-24, _upImageView.frame.size.height+30);
        NSLog(@"******** %f",_upImageView.frame.size.height);
        _RefreshBlock();
    }
}
-(CGFloat)calculateHeight:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += _upImageView.frame.size.height;
    NSLog(@"_upImageView %f",self.upImageView.frame.size.height);
    totalHeight += [self.titlelab sizeThatFits:size].height;
    NSLog(@"self.titleLab %f",[self.titlelab sizeThatFits:size].height);
    totalHeight += 140; // margins
     NSLog(@"图片cell的手动计算 %f",totalHeight);
    return totalHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
