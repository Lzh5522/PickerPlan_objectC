//
//  TimeLineLabel.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/6.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "TimeLineLabel.h"

@implementation TimeLineLabel
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label).offset(-4);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(1);
    }];
}
-(UIView *)roundView{
    if (!_roundView) {
        _roundView = [[UIView alloc]init];
        _roundView.backgroundColor = font_color;
    }
    return _roundView;
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.backgroundColor = RGB(247, 244, 255, 1);
        _label.layer.borderColor = font_color.CGColor;
        _label.layer.borderWidth = 1;
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:12];
        [_label addSubview:self.roundView];
    }
    return _label;
}
@end
