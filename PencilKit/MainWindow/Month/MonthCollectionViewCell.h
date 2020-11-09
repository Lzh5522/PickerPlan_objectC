//
//  MonthCollectionViewCell.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/26.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MonthCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView * imgView;
@property(nonatomic,strong) UILabel * todayLabel;
@property (nonatomic, strong) UIView *todayCircle; 
@property(nonatomic,strong) MonthModel * monthModel;
@end

NS_ASSUME_NONNULL_END
