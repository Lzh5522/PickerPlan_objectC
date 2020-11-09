//
//  ScheduleCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/24.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "ScheduleCell.h"
#import "UITextView+AddCorners.h"
@interface ScheduleCell()<UITextViewDelegate>

@end
@implementation ScheduleCell
//间距
- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
//    frame.origin.y += 10;
    frame.size.height -= 5;
//    frame.size.width -= 20;
    [super setFrame:frame];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textView];
//        [self.textView setCornerRadius:10 addRectCorners:UIRectCornerAllCorners];
        [self.contentView addSubview:self.checkBtn];
        self.contentView.backgroundColor = bg_color;
        self.contentView.layer.cornerRadius = 10;
        self.backgroundColor = bg_color;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return self;
}
#pragma marl UI
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-40);
        make.bottom.equalTo(self.contentView);
    }];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
//        make.left.equalTo(self.textView.right).offset();
        
    }];
    
}
#pragma mark lazy
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
//        _textView.layer.cornerRadius = 10;
//        _textView.layer.borderWidth = 1;
//        _textView.layer.borderColor = [UIColor blackColor].CGColor;
//        _textView.userInteractionEnabled = NO;
//        _textView.scrollEnabled = NO;
//        _textView.layer
    }
    return _textView;
}

-(UIButton *)checkBtn{
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_checkBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    }
    return _checkBtn;
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textViewCell:didChangeText:)]) {
       [self.delegate textViewCell:self didChangeText:textView.text];
     }
//    [self.delegate updateHeight:[self heightForString:self.textView andWidth:self.contentView.frame.size.width]];
    CGRect bounds = textView.bounds;
     // 计算 text view 的高度
    // *********************
     CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
     CGSize newSize = [textView sizeThatFits:maxSize];
     bounds.size = newSize;
    textView.bounds = bounds;
    //***********************
    
    //----------------------------------
//    CGFloat newHeight = [self heightForString:self.textView andWidth:self.contentView.frame.size.width];
//    textView.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, newHeight);
    
    
    
    
    //---------------------------------
     
     // 让 table view 重新计算高度
     UITableView *tableView = [self tableView];
     [tableView beginUpdates];
     [tableView endUpdates];
    
//    [textView flashScrollIndicators];   // 闪动滚动条
//
//    static CGFloat maxHeight = 130.0f;
//
//    CGRect frame = textView.frame;
//
//    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
//
//    CGSize size = [textView sizeThatFits:constraintSize];
//
//    if (size.height >= maxHeight)
//
//    {
//        size.height = maxHeight;
//
//        textView.scrollEnabled = YES;   // 允许滚动
//
//    }
//
//    else
//
//    {
//        textView.scrollEnabled = NO;
//        // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
//
//    }
//
//    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
}
//计算文字高度
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
      CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
      return sizeToFit.height;
  }
- (UITableView *)tableView {
  UIView *tableView = self.superview;
  while (![tableView isKindOfClass:[UITableView class]] && tableView) {
    tableView = tableView.superview;
  }
  return (UITableView *)tableView;
}
@end
