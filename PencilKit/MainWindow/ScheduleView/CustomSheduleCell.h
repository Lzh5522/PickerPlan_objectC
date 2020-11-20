//
//  CustomSheduleCell.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/7.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomSheduleCell : UITableViewCell
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UIView * line;
@property(nonatomic,strong) UIView * bgView;
@property(nonatomic,strong) UITextView * noteLabel;
@property(nonatomic,strong) UIButton * checkBtn;

@end

NS_ASSUME_NONNULL_END
