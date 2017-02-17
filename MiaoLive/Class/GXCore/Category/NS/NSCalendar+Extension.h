//
//  NSCalendar+Extension.h
//  RememberTime
//
//  Created by yingcan on 16/9/8.
//  Copyright © 2016年 yingcan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (Extension)

/**
 *  1.当前的日期数据元件模型
 */
+ (NSDateComponents *)currentDateComponents;
/**
 *  2.当前年
 */
+ (NSInteger)currentYear;
/**
 *  3.当前月
 */
+ (NSInteger)currentMonth;
/**
 *  4.当前天
 */
+ (NSInteger)currentDay;
/**
 *  5.当前周数
 */
+ (NSInteger)currnentWeekday;
/**
 *  6.获取指定年月的天数
 */
+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month;
/**
 *  7.获取指定年月的第一天的周数
 */
+ (NSInteger)getFirstWeekdayWithYear:(NSInteger)year
                               month:(NSInteger)month;
/**
 *  8.比较两个日期元件
 */
+ (NSComparisonResult)compareWithComponentsOne:(NSDateComponents *)componentsOne
                                 componentsTwo:(NSDateComponents *)componentsTwo;
/**
 *  9.获取两个日期元件之间的日期元件
 */
+ (NSMutableArray *)arrayComponentsWithComponentsOne:(NSDateComponents *)componentsOne
                                       componentsTwo:(NSDateComponents *)componentsTwo;
/**
 *  10.字符串转日期元件 字符串格式为：yy-MM-dd
 */
+ (NSDateComponents *)dateComponentsWithString:(NSString *)String;
/**
 *  根据指定日期获取星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

@end
