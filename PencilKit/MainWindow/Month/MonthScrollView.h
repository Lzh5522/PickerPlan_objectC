//
//  MonthScrollView.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/4.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);
@interface MonthScrollView : UIScrollView
//@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调
@property(nonatomic,strong) NSDate * selectedDate;
- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份
-(void)notifyToChangeCalendarHeader;
@end

NS_ASSUME_NONNULL_END
