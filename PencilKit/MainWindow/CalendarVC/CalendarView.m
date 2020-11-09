//
//  CalendarView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/29.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarCell.h"
#import "CalendarModel.h"
#import "NSDate+Calendar.h"
#import "GFCalendarScrollView.h"
@interface CalendarView()
@property(nonatomic,strong) GFCalendarScrollView * CalendarScrollView;
@end
@implementation CalendarView
static NSString *const CellID = @"cell";
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.timeLabel];
        [self addSubview:self.leftDayBtn];
        [self addSubview:self.rightDayBtn];
        [self addSubview:self.CalendarScrollView];
        NSArray * arr = [NSArray arrayWithObjects:@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",nil];
        for(NSInteger i=0;i<7;i++){
            UILabel * dayLabel = [[UILabel alloc]init];
            dayLabel.font = [UIFont boldSystemFontOfSize:24];
            dayLabel.textColor = [UIColor blackColor];
            dayLabel.textAlignment = NSTextAlignmentCenter;
            dayLabel.font = [UIFont systemFontOfSize:14];
            dayLabel.frame = CGRectMake((self.frame.size.width/7.0)*i, 50, self.frame.size.width/7.0, 25);
            dayLabel.text = arr[i];
            [self addSubview:dayLabel];
        }
        [self addNotificationObserver];
        
    }
    return self;
}
- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"GFCalendar.ChangeCalendarHeaderNotification" object:nil];
}
- (void)changeCalendarHeaderAction:(NSNotification *)sender {
    NSDictionary *dic = sender.userInfo;
    
    NSNumber *year = dic[@"year"];
    NSNumber *month = dic[@"month"];
    
    NSString *title = [NSString stringWithFormat:@"%@年%@月", year, month];
    
    self.timeLabel.text = title;
}
- (void)setDidSelectDayHandler:(DidSelectDayHandler)didSelectDayHandler {
    _didSelectDayHandler = didSelectDayHandler;
    if (_CalendarScrollView != nil) {
        _CalendarScrollView.didSelectDayHandler = _didSelectDayHandler; // 传递 block
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(110);
        make.height.equalTo(25);
    }];
    [self.rightYearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel);
        make.left.equalTo(self.timeLabel.right).offset(0);
    }];
    [self.rightDayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.timeLabel);
    }];
    [self.leftDayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel);
        make.right.equalTo(self.rightDayBtn.left).offset(-32);
    }];
    
}


-(NSString *)getMonthAndYear{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    return [NSString stringWithFormat:@"%ld年%ld月",year,month];
}



-(void)previousMonth{
    GFCalendarScrollView * scrollView = self.CalendarScrollView;
    [scrollView nextMonth];
}
-(void)nextMonth{
    GFCalendarScrollView * scrollView = self.CalendarScrollView;
    [scrollView previousMonth];
}
-(GFCalendarScrollView *)CalendarScrollView{
    if (!_CalendarScrollView) {
        _CalendarScrollView = [[GFCalendarScrollView alloc]initWithFrame:CGRectMake(0, 80, self.bounds.size.width, self.bounds.size.height-80)];
    }
    return _CalendarScrollView;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = [self getMonthAndYear];
        _timeLabel.textColor = font_color;
        _timeLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _timeLabel;
}

-(UIButton *)leftDayBtn{
    if (!_leftDayBtn) {
        _leftDayBtn = [[UIButton alloc]init];
        [_leftDayBtn setImage:[UIImage imageNamed:@"left_btn"] forState:UIControlStateNormal];
        [_leftDayBtn addTarget:self action:@selector(previousMonth) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftDayBtn;
}
-(UIButton *)rightDayBtn{
    if (!_rightDayBtn) {
        _rightDayBtn = [[UIButton alloc]init];
        [_rightDayBtn setImage:[UIImage imageNamed:@"right_btn"] forState:UIControlStateNormal];
        [_rightDayBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightDayBtn;
}
@end
