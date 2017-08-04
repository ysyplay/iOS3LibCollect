//
//  TestTableViewCell.m
//  YHBaseAnimatedHeaderView
//
//  Created by vip on 16/4/26.
//  Copyright © 2016年 jaki. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)changeRate:(UIStepper *)sender {
    self.delegate.animatedlevel = (int)sender.value;
}
- (IBAction)changeFrame:(UIStepper *)sender {
    self.delegate.maxScrollOffset = sender.value;
}
- (IBAction)changeAlpha:(UIStepper *)sender {
    self.delegate.minAlpha = sender.value;
}
- (IBAction)changeBluer:(UIStepper *)sender {
    self.delegate.maxBluer = sender.value;
}
- (IBAction)openAlpha:(UISwitch *)sender {
    self.delegate.alphaAnimated = sender.isOn;
}
- (IBAction)openBluer:(UISwitch *)sender {
    self.delegate.bluerAnimated = sender.isOn;
}
- (IBAction)return:(id)sender {
    if(self.delegate.navigationController){
        [self.delegate.navigationController popViewControllerAnimated:YES];
    }else{
        [self.delegate dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
