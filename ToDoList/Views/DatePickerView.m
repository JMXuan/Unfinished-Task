//
//  DatePickerView.m
//  ToDoList
//
//  Created by Jack on 16/2/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    UIDatePicker *taskDatePicker = [[UIDatePicker alloc]initWithFrame:frame];
    taskDatePicker.date = [NSDate date];
    /** 设置datepicker最小值为当前时间 */
    taskDatePicker.minimumDate = [NSDate date];
    /** 设置最大值为一个月内的时间 */
    taskDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:720 * 60 * 60];
    /** 设置时区为本地时区 */
    taskDatePicker.timeZone = [NSTimeZone localTimeZone];
    taskDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self addSubview:taskDatePicker];
    [taskDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    /** 时间值被改变时调用的方法 */
    [taskDatePicker bk_addEventHandler:^(id sender) {
        NSDate *selectedDate = [sender date];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
        NSString *selectedDateStr = [formatter stringFromDate:selectedDate];
        NSLog(@"被选中的时间：%@", selectedDateStr);
        
    } forControlEvents:UIControlEventValueChanged];
    }
    return self;
}





@end
