//
//  YearDetailCell.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/31.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YearDetailCell : UICollectionViewCell
@property(nonatomic,strong) NSDate * currentDate;
@property(nonatomic,strong) UILabel * monthLabel;
@property(nonatomic,strong) UICollectionView * monthDetailCollectionView;

@property(nonatomic,strong) MonthModel * model;
@end

NS_ASSUME_NONNULL_END
