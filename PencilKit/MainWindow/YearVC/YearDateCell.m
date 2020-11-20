//
//  YearDateCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/31.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "YearDateCell.h"

@implementation YearDateCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        self.backgroundColor = RGB(249, 245, 249, 1);
    }
    return self;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        _label.textColor = RGB(83, 64, 151, 1);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:15];
    }
    return _label;
}
@end
