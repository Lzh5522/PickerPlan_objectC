//
//  secondCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "secondCell.h"

@implementation secondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.imgView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}
@end
