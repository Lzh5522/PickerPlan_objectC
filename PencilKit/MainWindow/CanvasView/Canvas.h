//
//  Canvas.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/3.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PencilKit/PencilKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Canvas : UIView
@property(nonatomic,strong) PKCanvasView * canvas;
@property(nonatomic,strong) PKToolPicker * picker;
-(void)show;
-(void)removePKToolPicker;
@end

NS_ASSUME_NONNULL_END
