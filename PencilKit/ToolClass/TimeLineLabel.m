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
        [self addSubview:self.roundView];
        [self addSubview:self.label];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(10);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roundView.right);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
-(UIView *)roundView{
    if (!_roundView) {
        _roundView = [[UIView alloc]init];
        _roundView.backgroundColor = RGB(83, 64, 151, 1);
        _roundView.layer.cornerRadius = 5;
        _roundView.layer.masksToBounds = YES;
    }
    return _roundView;
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.backgroundColor = RGB(247, 244, 255, 1);
    }
    return _label;
}
@end
