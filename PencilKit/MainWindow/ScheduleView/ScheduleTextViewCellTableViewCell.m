//
//  ScheduleTextViewCellTableViewCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/25.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "ScheduleTextViewCellTableViewCell.h"
@interface ScheduleTextViewCellTableViewCell()<UITextViewDelegate>

@end

@implementation ScheduleTextViewCellTableViewCell

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textView.delegate = self;
    self.backgroundColor = bg_color;
    self.contentView.backgroundColor = bg_color;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    self.textView.backgroundColor = bg_color;
    self.textView.textColor = font_color;
}
- (void)textViewDidChange:(UITextView *)textView{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
}
- (UITableView *)tableView{

    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    
    return (UITableView *)tableView;
}

@end
