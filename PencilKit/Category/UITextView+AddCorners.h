//
//  UITextView+AddCorners.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/25.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (AddCorners)
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;
@end

NS_ASSUME_NONNULL_END
