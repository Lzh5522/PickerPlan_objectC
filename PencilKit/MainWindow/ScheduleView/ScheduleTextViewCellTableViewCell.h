//
//  ScheduleTextViewCellTableViewCell.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/25.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleTextViewCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;


@end

NS_ASSUME_NONNULL_END
