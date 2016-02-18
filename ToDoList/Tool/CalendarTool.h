//
//  ViewController.h
//  CalendarTool
//
//  Created by Jack on 16/2/18.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTool : NSObject

/** 获取当前系统的时间(字符串格式) */
- (NSString *)getCurrentDateStr;

/** 获取当前系统的时间(时间格式) */
- (NSString *)getCurrentDate;

/** 判断是否每月的第一天 */
- (BOOL)isFirstDayEveryMonth;

/**
 *  判断与表格传入的日历是否同一年月
 *
 *  @param tableDateStr 数据表格的日期
 *
 *  @return 判断值
 */
- (BOOL)isSameYear:(NSString *)tableDateStr;
@end

