//
//  MonthView.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/26.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MonthView : UIView
@property(nonatomic,strong) UICollectionView * monthColllectionView;
@property(nonatomic,strong) MonthScrollView * monthScrollView;
@property(nonatomic,assign) NSInteger month;
@property(nonatomic,strong) NSDate * assignDate;
@end

NS_ASSUME_NONNULL_END
