//
//  MonthCollectionViewCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/26.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MonthCollectionViewCell.h"

@implementation MonthCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imgView];
        [self addSubview:self.todayCircle];
        [self addSubview:self.todayLabel];
    }
    return self;
}
-(void)prepareForReuse{
    [super prepareForReuse];
    self.imgView.image = nil;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self.todayCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
        make.width.equalTo(30);
        make.height.equalTo(30);
    }];
    [_todayCircle setCornerRadius:15 addRectCorners:UIRectCornerAllCorners];
    [self.todayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.todayCircle);
        make.width.equalTo(25);
        make.height.equalTo(20);
    }];
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}
-(UILabel *)todayLabel{
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc]init];
        _todayLabel.textColor = font_color;
        _todayLabel.font = [UIFont boldSystemFontOfSize:18];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _todayLabel;
}
- (UIView *)todayCircle {
    if (_todayCircle == nil) {
        _todayCircle = [[UIView alloc] init];
    }
    return _todayCircle;
}
@end
