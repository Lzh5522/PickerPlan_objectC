//
//  CustomSheduleCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/7.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CustomSheduleCell.h"
@interface CustomSheduleCell()<UITextViewDelegate>

@end
@implementation CustomSheduleCell
-(void)setFrame:(CGRect)frame{
    frame.size.height -= 15;
    [super setFrame:frame];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.bgView];
        self.backgroundColor = bg_color;
    }
    return self;
}
-(void)checkBtnClick{
    if (self.checkBtn.selected == YES) {
        self.checkBtn.selected = NO;
    }else{
        self.checkBtn.selected = YES;
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(40);
        make.height.equalTo(15);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.right);
        make.centerY.equalTo(self.timeLabel);
        make.right.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.top.equalTo(self.bgView).offset(10);
        make.bottom.equalTo(self.bgView).offset(-10);
        make.right.equalTo(self.bgView).offset(-35);
    }];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noteLabel);
        make.right.equalTo(self.bgView).offset(-10);
        make.width.equalTo(24);
        make.height.equalTo(24);
        
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(self.timeLabel.bottom);
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
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.borderColor = [UIColor blackColor].CGColor;
        _bgView.layer.borderWidth = 0.5;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = RGB(236, 228, 254, 1);
        _bgView.userInteractionEnabled = YES;
        [_bgView addSubview:self.noteLabel];
        [_bgView addSubview:self.checkBtn];
        
    }
    return _bgView;
}
-(UITextView *)noteLabel{
    if (!_noteLabel) {
        _noteLabel = [[UITextView alloc]init];
        _noteLabel.textColor = font_color;
        _noteLabel.font = [UIFont systemFontOfSize:16];
        _noteLabel.backgroundColor = RGB(236, 228, 254, 1);
        _noteLabel.delegate = self;
//        _noteLabel.translatesAutoresizingMaskIntoConstraints = YES;
        _noteLabel.scrollEnabled = NO;
//        [_noteLabel sizeToFit];
    }
    return _noteLabel;
}
-(UIButton *)checkBtn{
    if (!_checkBtn) {
        _checkBtn = [[UIButton alloc]init];
        [_checkBtn setImage:[UIImage imageNamed:@"check_btn"] forState:UIControlStateNormal];
        [_checkBtn setImage:[UIImage imageNamed:@"checked_btn"] forState:UIControlStateSelected];
        [_checkBtn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}
@end
