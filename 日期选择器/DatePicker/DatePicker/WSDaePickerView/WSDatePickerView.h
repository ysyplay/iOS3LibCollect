//
//  WSDatePickerView.h
//  WSDatePicker
//
//  Created by iMac on 17/2/23.
//  Copyright © 2017年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Extension.h"

typedef enum{
    DateStyleShowYearMonthDayHour =0,
    DateStyleShowYearMonthDayHourMinute ,
    DateStyleShowYearMonthDayHourMinuteSeconds,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute
    
}WSDateStyle;


@interface WSDatePickerView : UIView

@property (nonatomic,strong)UIColor *doneButtonColor;//按钮颜色

@property (nonatomic, retain) NSDate *maxLimitDate;//限制最大时间（没有设置默认2200）
@property (nonatomic, retain) NSDate *minLimitDate;//限制最小时间（没有设置默认1900）

-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle CompleteBlock:(void(^)(NSDate *))completeBlock;

-(void)show;


@end

