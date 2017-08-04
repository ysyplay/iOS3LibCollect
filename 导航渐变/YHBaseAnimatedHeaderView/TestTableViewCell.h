//
//  TestTableViewCell.h
//  YHBaseAnimatedHeaderView
//
//  Created by vip on 16/4/26.
//  Copyright © 2016年 jaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"
@interface TestTableViewCell : UITableViewCell
@property(nonatomic,weak)SecondViewController * delegate;
@end
