//
//  CalendarCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/29.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.todayCircle];
        [self addSubview:self.label];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(40);
        make.height.equalTo(20);
    }];
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textColor = font_color;
        _label.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label;
}
- (UIView *)todayCircle {
    if (_todayCircle == nil) {
        _todayCircle = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.8 * self.bounds.size.height, 0.8 * self.bounds.size.height)];
        _todayCircle.center = CGPointMake(0.5 * self.bounds.size.width, 0.5 * self.bounds.size.height);
        _todayCircle.layer.cornerRadius = 0.5 * _todayCircle.frame.size.width;
    }
    return _todayCircle;
}
@end
