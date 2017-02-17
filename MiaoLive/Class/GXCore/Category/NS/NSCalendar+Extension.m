//
//  NSCalendar+Extension.m
//  RememberTime
//
//  Created by yingcan on 16/9/8.
//  Copyright © 2016年 yingcan. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)
// *  1.当前的日期数据元件模型
+ (NSDateComponents *)currentDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return [calendar components:unitFlags fromDate:[NSDate date]];
}
/**
 *  根据日期获取星期几
 *
 *  @param inputDate 输入NSDate类型日期
 *
 *  @return 星期
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSInteger)currentMonth
{
    return [NSCalendar currentDateComponents].month;
}

+ (NSInteger)currentYear
{
    return [NSCalendar currentDateComponents].year;
}

+ (NSInteger)currentDay
{
    return [NSCalendar currentDateComponents].day;
}

+ (NSInteger)currnentWeekday
{
    return [NSCalendar currentDateComponents].weekday;
}

//根据年月 获取当相应月份的天数
+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

//根据相应年月获取当相应的周是周几
+ (NSInteger)getFirstWeekdayWithYear:(NSInteger)year
                               month:(NSInteger)month
{
    NSString *stringDate = [NSString stringWithFormat:@"%ld-%ld-01", (long)year, (long)month];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:stringDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    return [components weekday];
}

//比较两个日期原件
+ (NSComparisonResult)compareWithComponentsOne:(NSDateComponents *)componentsOne
                                 componentsTwo:(NSDateComponents *)componentsTwo
{
    if (componentsOne.year  == componentsTwo.year &&
        componentsOne.month == componentsTwo.month &&
        componentsOne.day   == componentsTwo.day) {
        return NSOrderedSame;
    }else if (componentsOne.year < componentsTwo.year ||
              (componentsOne.year == componentsTwo.year && componentsOne.month < componentsTwo.month) ||
              (componentsOne.year == componentsTwo.year && componentsOne.month == componentsTwo.month && componentsOne.day < componentsTwo.day)) {
        return NSOrderedAscending;
    }else {
        return NSOrderedDescending;
    }
}

/**
 *  9.获取两个日期元件之间的日期元件
 */
+ (NSMutableArray *)arrayComponentsWithComponentsOne:(NSDateComponents *)componentsOne
                                       componentsTwo:(NSDateComponents *)componentsTwo
{
    NSMutableArray *arrayComponents = [NSMutableArray array];
    
    NSString *stringOne = [NSString stringWithFormat:@"%ld-%ld-%ld",
                           (long)componentsOne.year,
                           (long)componentsOne.month,
                           (long)componentsOne.day];
    NSString *stringTwo = [NSString stringWithFormat:@"%ld-%ld-%ld",
                           (long)componentsTwo.year,
                           (long)componentsTwo.month,
                           (long)componentsTwo.day];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    NSDate *dateFromString = [dateFormatter dateFromString:stringOne];
    NSDate *dateToString = [dateFormatter dateFromString:stringTwo];
    int timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
    
    NSTimeInterval timeInterval = [dateFromString timeIntervalSinceDate:dateFromString];
    
    for (int i = 0; i <= timediff; i+=86400) {
        timeInterval = i;
        NSDate *date = [dateFromString dateByAddingTimeInterval:timeInterval];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        [arrayComponents addObject:[calendar components:unitFlags fromDate:date]];
    }
    return arrayComponents;
}

/**
 *  10.字符串转日期元件 字符串格式为：yy-MM-dd
 */
+ (NSDateComponents *)dateComponentsWithString:(NSString *)String
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:String];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return  [calendar components:unitFlags fromDate:date];
}

@end
