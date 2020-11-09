//
//  TimeLineLabel.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/6.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AddCorners.h"
NS_ASSUME_NONNULL_BEGIN

@interface TimeLineLabel : UIView
@property(nonatomic,strong) UIView * roundView;
@property(nonatomic,strong) UILabel * label;
@end

NS_ASSUME_NONNULL_END
