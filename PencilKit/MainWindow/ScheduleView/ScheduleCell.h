//
//  ScheduleCell.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/24.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ScheduleCellDelegate;
@interface ScheduleCell : UITableViewCell
@property(nonatomic,strong) UITextView * textView;
@property(nonatomic,strong) UIButton * checkBtn;
@property(nonatomic,weak) id <ScheduleCellDelegate> delegate;
@end
@protocol ScheduleCellDelegate <NSObject>

- (void)textViewCell:(ScheduleCell *)cell didChangeText:(NSString *)text;

@end
NS_ASSUME_NONNULL_END
