//
//  CalendarView.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/29.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);
@interface CalendarView : UIView
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UIButton * rightYearBtn;
@property(nonatomic,strong) UIButton * leftDayBtn;
@property(nonatomic,strong) UIButton * rightDayBtn;
@property(nonatomic,strong) UICollectionView * collectionViewL;
@property(nonatomic,strong) UICollectionView * collectionViewM;
@property(nonatomic,strong) UICollectionView * collectionViewR;
@property(nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSDate *currentMonthDate;
@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler;
@end

NS_ASSUME_NONNULL_END
