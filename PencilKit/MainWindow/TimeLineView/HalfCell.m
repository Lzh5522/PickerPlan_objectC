//
//  HalfCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/23.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "HalfCell.h"
#define padding 5
@implementation HalfCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.line];
        self.contentView.backgroundColor = bg_color;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(45);
        make.top.equalTo(self.contentView);
        make.height.equalTo(0.5);
        make.width.equalTo(20);
    }];
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}

@end
