//
//  TimeLineCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/23.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "TimeLineCell.h"
#define padding 5

@implementation TimeLineCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.line];
        self.contentView.backgroundColor = bg_color;
    }
    return self;
}
-(void)prepareForReuse{
    [super prepareForReuse];
//    self.timeLabel.hidden = YES;
//    self.line.hidden = YES;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.equalTo(40);
        make.height.equalTo(20);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.right).offset(padding);
        make.centerY.equalTo(self.timeLabel);
        make.right.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
}
#pragma mark lazy
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = font_color;
        
    }
    return _timeLabel;
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}
@end
