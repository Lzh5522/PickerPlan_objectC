//
//  CalendarCell.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/29.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarCell : UICollectionViewCell
@property(nonatomic,strong) UILabel * label;
@property(nonatomic,strong) UIView * todayCircle;
@end

NS_ASSUME_NONNULL_END
