//
//  thirdCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "thirdCell.h"

@implementation thirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.menu];
    }
    return self;
}
-(UIMenu *)menu{
    if (!_menu) {
        UIAction * action = [UIAction actionWithTitle:@"Copy" image:[UIImage imageNamed:@""] identifier:@"copy" handler:^(__kindof UIAction * _Nonnull action) {
            
        }];
        NSArray * arr = [NSArray arrayWithObjects:action, nil];
        _menu = [UIMenu menuWithChildren:arr];
    }
    return _menu;
}

@end
