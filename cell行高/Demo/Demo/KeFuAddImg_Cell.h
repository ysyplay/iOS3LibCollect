//
//  KeFuAddImg_Cell.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/13.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KeFuAddImg_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (strong, nonatomic) UIView *upImageView;
@property (nonatomic, copy) void (^RefreshBlock)();
@end
