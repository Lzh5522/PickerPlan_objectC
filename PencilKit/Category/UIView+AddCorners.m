//
//  UIView+AddCorners.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "UIView+AddCorners.h"

@implementation UIView (AddCorners)
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner{
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}
@end
