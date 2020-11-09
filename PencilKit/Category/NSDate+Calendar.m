//
//  NSDate+Calendar.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/27.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)
- (NSInteger)dateDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    return components.day;
}
-(NSDate *)previousDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day -=1;
    NSDate *previousDate = [calendar dateFromComponents:components];
    return previousDate;
}
- (NSInteger)dateMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)dateYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}
//获取1月1日
-(NSDate *)getJanuaryDayOne{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    components.day = 15;
    components.month = 1;
    NSDate * januaryDayOne = [calendar dateFromComponents:components];
    return januaryDayOne;
}
/*
 获取上一年的数组
 */
-(NSMutableArray *)getPreviousYearArray:(NSDate *)januaryDate{
    NSMutableArray * arr = [NSMutableArray array];
    NSDate * date = [januaryDate previousMonthDate];
    for (int i = 12; i>0; i--) {
        [arr addObject:date];
        date = [date previousMonthDate];
    }
    arr = (NSMutableArray*)[[arr reverseObjectEnumerator]allObjects];
    return arr;
}
/*
 获取今年的数组
 */
-(NSMutableArray *)getCurrentYearArray:(NSInteger)currentYear{
    return nil;
}
-(NSMutableArray *)getThreeYearArray:(NSInteger)currentYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components0 = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:self];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:self];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:self];
    /*
     去年
     */
    NSMutableArray * arr0 = [NSMutableArray array];
    components0.year  -=1;
    components0.month = 1;
    components0.day = 15;
    //一月一日
    NSDate * date0 = [calendar dateFromComponents:components0];
    for (int i = 0; i < 12; i++) {
        [arr0 addObject:date0];
        date0 = [date0 nextMonthDate];
    }
    /*
     今年
     */
    NSMutableArray * arr1 = [NSMutableArray array];
    components1.year = components1.year;
    components1.month = 1;
    components1.day = 15;
    //一月一日
    NSDate * date1 = [calendar dateFromComponents:components1];
    for (int i = 0; i < 12; i++) {
        [arr1 addObject:date1];
        date1 = [date1 nextMonthDate];
    }
    /*
     明年
     */
    NSMutableArray * arr2 = [NSMutableArray array];
    components2.year +=1;
    components2.month = 1;
    components2.day = 15;
    //一月一日
    NSDate * date2 = [calendar dateFromComponents:components2];
    for (int i = 0; i < 12; i++) {
        [arr2 addObject:date2];
        date2 = [date2 nextMonthDate];
    }
    NSMutableArray * allArr = [NSMutableArray array];
    [allArr addObject:arr0];
    [allArr addObject:arr1];
    [allArr addObject:arr2];
    return allArr;
}
/*
 获取下一年的数组
 */

-(NSMutableArray *)getNextYearArray:(NSDate *)januaryDate{
    NSMutableArray * arr = [NSMutableArray array];
    //下一年的一月
    
    for (int i = 0; i < 12; i++) {
        januaryDate = [januaryDate nextMonthDate];
    }
    NSDate * DecemberDate = januaryDate;
    NSDate * nextJanuaryDate = [DecemberDate nextMonthDate];
    for (int i = 0; i< 12; i++) {
        [arr addObject:nextJanuaryDate];
        nextJanuaryDate = [nextJanuaryDate nextMonthDate];
    }
    return arr;
    
}
- (NSDate *)previousMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 1) {
        components.month = 12;
        components.year -= 1;
    } else {
        components.month -= 1;
    }
    
    NSDate *previousDate = [calendar dateFromComponents:components];
    
    return previousDate;
}

- (NSDate *)nextMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 12) {
        components.month = 1;
        components.year += 1;
    } else {
        components.month += 1;
    }
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    return nextDate;
}

- (NSInteger)totalDaysInMonth {
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}

- (NSInteger)firstWeekDayInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1; // 定位到当月第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    
    // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    
    return firstWeekday;
}
@end
