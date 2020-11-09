//
//  NSDate+Calendar.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/27.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Calendar)
/**
 *  获得当前 NSDate 对象对应的日子
 */
- (NSInteger)dateDay;

/**
 *  获得当前 NSDate 对象对应的月份
 */
- (NSInteger)dateMonth;

/**
 *  获得当前 NSDate 对象对应的年份
 */
- (NSInteger)dateYear;

/**
 *  获得当前 NSDate 对象的上个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)previousMonthDate;

/**
 *  获得当前 NSDate 对象的下个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)nextMonthDate;

/**
 *  获得当前 NSDate 对象对应的月份的总天数
 */
- (NSInteger)totalDaysInMonth;

/**
 *  获得当前 NSDate 对象对应月份当月第一天的所属星期
 */
- (NSInteger)firstWeekDayInMonth;
/*
 获取一月一日
 */
-(NSDate *)getJanuaryDayOne;
-(NSMutableArray *)getCurrentYearArray;
-(NSMutableArray *)getPreviousYearArray:(NSDate *)januaryDate;
-(NSMutableArray *)getNextYearArray:(NSDate *)januaryDate;
-(NSMutableArray *)getThreeYearArray:(NSInteger)currentYear;
-(NSDate *)previousDate;
@end

NS_ASSUME_NONNULL_END
