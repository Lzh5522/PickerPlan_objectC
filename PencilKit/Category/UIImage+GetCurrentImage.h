//
//  UIImage+GetCurrentImage.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/3.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GetCurrentImage)
+ (UIImage *) getCurrentInnerViewShot: (UIView *) innerView atFrame:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
