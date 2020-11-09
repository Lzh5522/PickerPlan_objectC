//
//  MonthModel.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/27.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MonthModel.h"
#import "NSDate+Calendar.h"
@implementation MonthModel
- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        self.monthDate = date;
        self.totalDays = [self setupTotalDays];
        self.firstWeekday = [self setupFirstWeekday];
        self.year = [self setupYear];
        self.month = [self setupMonth];
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
