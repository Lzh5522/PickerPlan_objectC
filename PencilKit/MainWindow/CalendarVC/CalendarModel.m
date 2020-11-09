//
//  CalendarModel.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/29.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CalendarModel.h"
#import "NSDate+Calendar.h"
@implementation CalendarModel
- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        self.monthDate = date;
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
    }
    
    return self;
    
}
- (NSInteger)setupTotalDays {
    return [self.monthDate totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday {
    return [self.monthDate firstWeekDayInMonth];
}

- (NSInteger)setupYear {
    return [self.monthDate dateYear];
}

- (NSInteger)setupMonth {
    return [self.monthDate dateMonth];
}
@end
