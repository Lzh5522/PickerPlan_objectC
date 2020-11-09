//
//  MonthView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/26.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MonthView.h"
#import "MonthCollectionViewCell.h"
#import "NSDate+Calendar.h"
#import "MonthScrollView.h"
@interface MonthView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation MonthView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.monthScrollView];
        NSArray * arr = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
        for(NSInteger i=0;i<7;i++){
            UILabel * weekLabel = [[UILabel alloc]init];
            weekLabel.font = [UIFont boldSystemFontOfSize:24];
            weekLabel.textColor = font_color;
            weekLabel.textAlignment = NSTextAlignmentRight;
            weekLabel.frame = CGRectMake((ScreenW/7.0)*i, navigationViewHeight, ScreenW/7.0, 30);
            weekLabel.text = arr[i];
            
            [self addSubview:weekLabel];
        }
    }
    return self;
}
#pragma mark 获取当月
- (NSString *)getCurrentMonth {
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    return   [NSString stringWithFormat:@"%ld年%ld月",year,month];
}

#pragma mark lazy
-(MonthScrollView *)monthScrollView{
    if (!_monthScrollView) {
        _monthScrollView = [[MonthScrollView alloc]initWithFrame:CGRectMake(1, navigationViewHeight+30, ScreenW-2, ScreenH-navigationViewHeight-30-20)];
    }
    return _monthScrollView;
}


@end
