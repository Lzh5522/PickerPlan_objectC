//
//  CanlendarToolView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CanlendarToolView.h"
#import "UIButton+AddCorners.h"
#define cornerRadius 10
@implementation CanlendarToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.dayBtn];
        [self addSubview:self.weekBtn];
        [self addSubview:self.monthBtn];
        [self addSubview:self.yearBtn];
        self.backgroundColor = RGB(203, 203, 204, 1);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnSelectDayBtn) name:@"MonthScrollView.SelectedDay" object:nil];
    }
    return self;
}

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)btnSelectDayBtn{
    self.dayBtn.selected = YES;
    self.weekBtn.selected = NO;
    self.monthBtn.selected = NO;
    self.yearBtn.selected = NO;
}
-(void)btnClicked:(UIButton *)btn{
    [self.delegate handleBtnClicked:btn.tag];
    switch (btn.tag) {
        case 0:
            self.dayBtn.selected = YES;
            self.weekBtn.selected = NO;
            self.monthBtn.selected = NO;
            self.yearBtn.selected = NO;
            [self.dayBtn setBackgroundColor:self.selectedColor];
            [self.weekBtn setBackgroundColor:self.bgColor];
            [self.monthBtn setBackgroundColor:self.bgColor];
            [self.yearBtn setBackgroundColor:self.bgColor];
            break;
        case 1:
            self.dayBtn.selected = NO;
            self.weekBtn.selected = YES;
            self.monthBtn.selected = NO;
            self.yearBtn.selected = NO;
            [self.dayBtn setBackgroundColor:self.bgColor];
            [self.weekBtn setBackgroundColor:self.selectedColor];
            [self.monthBtn setBackgroundColor:self.bgColor];
            [self.yearBtn setBackgroundColor:self.bgColor];
            break;
        case 2:
            self.dayBtn.selected = NO;
            self.weekBtn.selected = NO;
            self.monthBtn.selected = YES;
            self.yearBtn.selected = NO;
            [self.dayBtn setBackgroundColor:self.bgColor];
            [self.weekBtn setBackgroundColor:self.bgColor];
            [self.monthBtn setBackgroundColor:self.selectedColor];
            [self.yearBtn setBackgroundColor:self.bgColor];
            break;
        case 3:
            self.dayBtn.selected = NO;
            self.weekBtn.selected = NO;
            self.monthBtn.selected = NO;
            self.yearBtn.selected = YES;
            [self.dayBtn setBackgroundColor:self.bgColor];
            [self.weekBtn setBackgroundColor:self.bgColor];
            [self.monthBtn setBackgroundColor:self.bgColor];
            [self.yearBtn setBackgroundColor:self.selectedColor];
            break;
        default:
            break;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutIfNeeded];
    [self setCornerRadius:cornerRadius addRectCorners:UIRectCornerAllCorners];
    [self.delegate handleBtnClicked:0];
    self.dayBtn.selected = YES;
    self.weekBtn.selected = NO;
    self.monthBtn.selected = NO;
    self.yearBtn.selected = NO;
    [self.dayBtn setBackgroundColor:self.selectedColor];
    [self.weekBtn setBackgroundColor:self.bgColor];
    [self.monthBtn setBackgroundColor:self.bgColor];
    [self.yearBtn setBackgroundColor:self.bgColor];
    [self.dayBtn setCornerRadius:cornerRadius addRectCorners:UIRectCornerAllCorners];
    [self.weekBtn setCornerRadius:cornerRadius addRectCorners:UIRectCornerAllCorners];
    [self.monthBtn setCornerRadius:cornerRadius addRectCorners:UIRectCornerAllCorners];
    [self.yearBtn setCornerRadius:cornerRadius addRectCorners:UIRectCornerAllCorners];
    
    
    [self.dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self.bounds.size.width/4.0);
    }];
    [self.weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayBtn.right);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self.bounds.size.width/4.0);
    }];
    [self.monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weekBtn.right);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self.bounds.size.width/4.0);
    }];
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.monthBtn.right);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
#pragma lazy
-(UIButton *)dayBtn{
    if(!_dayBtn){
        _dayBtn = [[UIButton alloc]init];
        _dayBtn.tag = 0;
        [_dayBtn setTitle:@"日" forState:UIControlStateNormal];
        [_dayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dayBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dayBtn;
}
-(UIButton *)weekBtn{
    if(!_weekBtn){
        _weekBtn = [[UIButton alloc]init];
        _weekBtn.tag = 1;
        [_weekBtn setTitle:@"月" forState:UIControlStateNormal];
        [_weekBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_weekBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _weekBtn;
}
-(UIButton *)monthBtn{
    if(!_monthBtn){
        _monthBtn = [[UIButton alloc]init];
        _monthBtn.tag = 2;
        [_monthBtn setTitle:@"年" forState:UIControlStateNormal];
        [_monthBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_monthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _monthBtn;
}
-(UIButton *)yearBtn{
    if (!_yearBtn) {
        _yearBtn = [[UIButton alloc]init];
        _yearBtn.tag = 3;
        [_yearBtn setTitle:@"时间" forState:UIControlStateNormal];
        [_yearBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_yearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _yearBtn;
}
-(UIColor *)bgColor{
    if(!_bgColor){
        _bgColor = RGB(203, 203, 204, 1);
    }
    return _bgColor;
}
-(UIColor *)selectedColor{
    if (!_selectedColor) {
        _selectedColor = [UIColor whiteColor];
    }
    return _selectedColor;
}
-(UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}
-(UIColor *)titleSelectedColor{
    if (!_titleSelectedColor) {
        _titleSelectedColor = [UIColor blackColor];
    }
    return _titleSelectedColor;;
}
@end
