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
    }
    return self;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        _label.textColor = font_color;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
@end
