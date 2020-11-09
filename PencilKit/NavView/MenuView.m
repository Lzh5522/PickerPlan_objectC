//
//  MenuView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/25.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
    }
    return self;
}

-(NSInteger)numberOfSections{
    return 4;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 7;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

@end
