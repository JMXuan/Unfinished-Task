//
//  ViewController.m
//  CalendarTool
//
//  Created by Jack on 16/2/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "CalendarTool.h"

@interface CalendarTool ()
/** 获取当前系统时间 */
@property (nonatomic, strong) NSDate *currentDate;
/** 时间格式 */
@property (nonatomic, strong) NSDateFormatter *formatter;
/** 日历对象 */
@property (nonatomic, strong) NSCalendar *calendar;
@end

@implementation CalendarTool

- (NSDate *)currentDate {
    if(_currentDate == nil) {
        _currentDate = [[NSDate alloc] init];
    }
    return _currentDate;
}

- (NSDateFormatter *)formatter {
    if(_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy.MM.dd"];
    }
    return _formatter;
}

- (NSCalendar *)calendar {
    if(_calendar == nil) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

/** 返回日历对象 */
- (NSDateComponents *)returnDateComponents{
    /** 获取一个时间元素 */
    NSDateComponents *components = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self.currentDate];
    return components;
}


/** 获取当前系统的时间 */
- (NSString *)getCurrentDateStr{
    NSString *currentDateStr = [self.formatter stringFromDate:self.currentDate];
    NSLog(@"当前系统时间:%@", currentDateStr);
    return currentDateStr;
}

/** 获取当前系统的时间 */
- (NSDate *)getCurrentDate{
    return self.currentDate;
}

/** 判断是否每月的第一天 */
- (BOOL)isFirstDayEveryMonth{
    NSDateComponents *cmp = [self returnDateComponents];
    NSLog(@"%@", cmp);
    return cmp.day == 1;
}

/** 判断与表格传入的日历是否同一年月*/
- (BOOL)isSameYear:(NSString *)tableDateStr{
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDate * tableDate = [self.formatter dateFromString:tableDateStr];
    NSDateComponents *comPonents = [self.calendar components:unit fromDate:self.currentDate toDate:tableDate options:0];
    return comPonents.year == 0 && comPonents.month == 0;
}





@end
