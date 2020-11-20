//
//  DetailDayVC.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/5.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PencilKit/PencilKit.h>
#import "Canvas.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailDayVC : UIViewController
@property(nonatomic,strong) UIImageView * resultView;
@property(nonatomic,strong) Canvas * canvasView;
@property(nonatomic,strong) UIImage * img;
@property(nonatomic,strong) NSDate * day;
@property(nonatomic,strong) PKCanvasView * canvas;
@property(nonatomic,strong) PKToolPicker * picker;
@end

NS_ASSUME_NONNULL_END
