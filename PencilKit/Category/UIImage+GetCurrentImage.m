//
//  UIImage+GetCurrentImage.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/3.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "UIImage+GetCurrentImage.h"

@implementation UIImage (GetCurrentImage)
+ (UIImage *) getCurrentInnerViewShot: (UIView *) innerView atFrame:(CGRect)rect
{
    UIGraphicsBeginImageContext(innerView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [innerView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return  theImage;
}
@end
