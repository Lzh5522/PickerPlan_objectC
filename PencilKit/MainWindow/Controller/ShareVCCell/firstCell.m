//
//  firstCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "firstCell.h"

@implementation firstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (NSInteger i = 0; i<4; i++) {
            UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
            img.frame = CGRectMake(self.bounds.size.width/4.0, 0, self.bounds.size.width/4.0, self.bounds.size.height);
            [self.contentView addSubview:img];
        }
    }
    return self;
}

@end
