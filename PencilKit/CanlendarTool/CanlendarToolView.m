//
//  CanlendarToolView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CanlendarToolView.h"
#import "UIButton+AddCorners.h"
#define CR 9
@implementation CanlendarToolView



//-(instancetype)initWithFrame:(CGRect)frame{
//    if(self = [super initWithFrame:frame]){
//        [self addSubview:self.dayBtn];
//        [self addSubview:self.weekBtn];
//        [self addSubview:self.monthBtn];
//        [self addSubview:self.yearBtn];
//        self.backgroundColor = RGB(166, 160, 160, 1);
//
//    }
//    return self;
//}
//
//
//
//-(void)btnClicked:(UIButton *)btn{
//    [self.delegate handleBtnClicked:btn.tag];
//    switch (btn.tag) {
//        case 0:
//            self.dayBtn.selected = YES;
//            self.weekBtn.selected = NO;
//            self.monthBtn.selected = NO;
//            self.yearBtn.selected = NO;
//            break;
//        case 1:
//            self.dayBtn.selected = NO;
//            self.weekBtn.selected = YES;
//            self.monthBtn.selected = NO;
//            self.yearBtn.selected = NO;
//            break;
//        case 2:
//            self.dayBtn.selected = NO;
//            self.weekBtn.selected = NO;
//            self.monthBtn.selected = YES;
//            self.yearBtn.selected = NO;
//            break;
//        case 3:
//            self.dayBtn.selected = NO;
//            self.weekBtn.selected = NO;
//            self.monthBtn.selected = NO;
//            self.yearBtn.selected = YES;
//            break;
//        default:
//            break;
//    }
//}
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    CGFloat W = self.bounds.size.width;
//    CGFloat H = self.bounds.size.height;
//    self.dayBtn.frame = CGRectMake(0, 0, W/4.0, H);
//    self.weekBtn.frame = CGRectMake(W/4.0, 0, W/4.0, H);
//    self.monthBtn.frame = CGRectMake(W*2/4.0, 0, W/4.0, H);
//    self.yearBtn.frame = CGRectMake(W/4.0*3, 0, W/4.0, H);
//    [self setCornerRadius:CR addRectCorners:UIRectCornerAllCorners];
//    [self.delegate handleBtnClicked:0];
//    self.dayBtn.selected = YES;
//    self.weekBtn.selected = NO;
//    self.monthBtn.selected = NO;
//    self.yearBtn.selected = NO;
//
//}
//
//#pragma lazy
//-(UIButton *)dayBtn{
//    if(!_dayBtn){
//        _dayBtn = [[UIButton alloc]init];
//        _dayBtn.tag = 0;
//        [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_btn_selected"] forState:UIControlStateNormal];
//        [_dayBtn setBackgroundImage:[UIImage imageNamed:@"day_btn_normal"] forState:UIControlStateSelected];
//        [_dayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_dayBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        _dayBtn.adjustsImageWhenHighlighted = NO;
//    }
//    return _dayBtn;
//}
//-(UIButton *)weekBtn{
//    if(!_weekBtn){
//        _weekBtn = [[UIButton alloc]init];
//        _weekBtn.tag = 1;
//        [_weekBtn setBackgroundImage:[UIImage imageNamed:@"month_btn_selected"] forState:UIControlStateNormal];
//        [_weekBtn setBackgroundImage:[UIImage imageNamed:@"month_btn_normal"] forState:UIControlStateSelected];
//        [_weekBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_weekBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _weekBtn.adjustsImageWhenHighlighted = NO;
//    }
//    return _weekBtn;
//}
//-(UIButton *)monthBtn{
//    if(!_monthBtn){
//        _monthBtn = [[UIButton alloc]init];
//        _monthBtn.tag = 2;
//        [_monthBtn setBackgroundImage:[UIImage imageNamed:@"year_btn_selected"] forState:UIControlStateNormal];
//        [_monthBtn setBackgroundImage:[UIImage imageNamed:@"year_btn_normal"] forState:UIControlStateSelected];
//        [_monthBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_monthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _monthBtn.adjustsImageWhenHighlighted = NO;
//    }
//    return _monthBtn;
//}
//-(UIButton *)yearBtn{
//    if (!_yearBtn) {
//        _yearBtn = [[UIButton alloc]init];
//        _yearBtn.tag = 3;
//        [_yearBtn setBackgroundImage:[UIImage imageNamed:@"time_btn_selected"] forState:UIControlStateNormal];
//        [_yearBtn setBackgroundImage:[UIImage imageNamed:@"time_btn_normal"] forState:UIControlStateSelected];
//        [_yearBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_yearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _yearBtn.adjustsImageWhenHighlighted = NO;
//    }
//    return _yearBtn;
//}
//-(UIColor *)bgColor{
//    if(!_bgColor){
//        _bgColor = RGB(203, 203, 204, 1);
//    }
//    return _bgColor;
//}
//-(UIColor *)selectedColor{
//    if (!_selectedColor) {
//        _selectedColor = [UIColor whiteColor];
//    }
//    return _selectedColor;
//}
//-(UIColor *)titleColor{
//    if (!_titleColor) {
//        _titleColor = [UIColor blackColor];
//    }
//    return _titleColor;
//}
//-(UIColor *)titleSelectedColor{
//    if (!_titleSelectedColor) {
//        _titleSelectedColor = [UIColor blackColor];
//    }
//    return _titleSelectedColor;;
//}
@end
