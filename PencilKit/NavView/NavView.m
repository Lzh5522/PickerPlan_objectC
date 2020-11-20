//
//  NavView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/22.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "NavView.h"
#define btnPadding 4
@interface NavView()<CanlendarToolDelegate>

@end
@implementation NavView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.menuBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.canlendarBtn];
        [self addSubview:self.pkToolBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.okBtn];
        [self addSubview:self.canlenderToolView];
        [self addSubview:self.timeLabel];
        self.timeLabel.text = [self getCurrentTimeAndWeekDay];
        self.backgroundColor = bg_color;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.canlenderToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(31);
        make.width.equalTo(354);
        make.height.equalTo(32);
    }];
    [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(46);
        make.height.equalTo(46);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.menuBtn.right).offset(btnPadding);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(46);
        make.height.equalTo(46);
    }];
    [self.canlendarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareBtn.right).offset(btnPadding);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(46);
        make.height.equalTo(46);
    }];
    [self.pkToolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.canlendarBtn.right).offset(btnPadding);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(46);
        make.height.equalTo(46);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pkToolBtn.right).offset(btnPadding);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(46);
        make.height.equalTo(46);
    }];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addBtn.right).offset(btnPadding);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(46);
        make.height.equalTo(46);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-8);
        make.top.equalTo(self).offset(24);
        make.width.equalTo(264);
        make.height.equalTo(46);
    }];
}

#pragma mark action
-(void)btnAction:(UIButton *)btn{
    [self.delegate handleBtnAction:btn];
    
}
-(void)handleSegClicked:(UISegmentedControl *)seg{
    [self.delegate handleCanlenderToolAction:seg.selectedSegmentIndex];
}

#pragma mark get time function
-(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    NSLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}
- (NSString *)getCurrentTimeAndWeekDay {
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    return   [NSString stringWithFormat:@"%ld年%ld月%ld日 %@",year,month,day,[arrWeek objectAtIndex:week-1]];
}

#pragma mark lazy
-(CanlendarToolView *)canlenderToolView{
    if(!_canlenderToolView){
        NSArray*buttonNames = [NSArray arrayWithObjects:@"日", @"月", @"年",@"时间",nil];
        _canlenderToolView = [[CanlendarToolView alloc]initWithItems:buttonNames];
        _canlenderToolView.selectedSegmentIndex=0;
        [_canlenderToolView addTarget:self action:@selector(handleSegClicked:)forControlEvents:UIControlEventValueChanged];
//        _canlenderToolView.delegate = self;
        
        
    }
    return _canlenderToolView;
}
-(UIButton *)menuBtn{
    if(!_menuBtn){
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuBtn setImage:[UIImage imageNamed:@"menuBtn"] forState:UIControlStateNormal];
        [_menuBtn sizeToFit];
        _menuBtn.tag = 10;
        [_menuBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        _shareBtn.tag = 11;
        [_shareBtn sizeToFit];
        [_shareBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(UIButton *)canlendarBtn{
    if (!_canlendarBtn) {
        _canlendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _canlendarBtn.tag = 12;
        [_canlendarBtn setImage:[UIImage imageNamed:@"calendarBtn"] forState:UIControlStateNormal];
        [_canlendarBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_canlendarBtn sizeToFit];
    }
    return _canlendarBtn;
}
-(UIButton *)pkToolBtn{
    if (!_pkToolBtn) {
        _pkToolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pkToolBtn.tag = 13;
        [_pkToolBtn setImage:[UIImage imageNamed:@"pkToolBtn"] forState:UIControlStateNormal];
        [_pkToolBtn setImage:[UIImage imageNamed:@"pkToolBtn_selected"] forState:UIControlStateSelected];
        [_pkToolBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pkToolBtn sizeToFit];
    }
    return _pkToolBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.tag = 14;
        [_addBtn setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn sizeToFit];
    }
    return _addBtn;
}
-(UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.tag = 15;
        [_okBtn setImage:[UIImage imageNamed:@"addBtn"] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_okBtn sizeToFit];
        _okBtn.hidden = YES;
    }
    return _okBtn;
}
-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = RGB(74, 71, 110, 1);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont boldSystemFontOfSize:25];
        
    }
    return _timeLabel;
}

@end
