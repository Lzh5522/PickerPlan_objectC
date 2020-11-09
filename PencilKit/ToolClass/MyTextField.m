//
//  MyTextField.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/17.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

- (CGRect)placeholderRectForBounds:(CGRect)bounds
 {
   return CGRectInset(bounds, 0, 0);
 }
 // text position
 - (CGRect)textRectForBounds:(CGRect)bounds {

  return CGRectInset(bounds, 0,0);
 }

 // text position while editing
 - (CGRect)editingRectForBounds:(CGRect)bounds {

     return CGRectInset(bounds, 0, 0);
 }
@end
