//
//  HomeVC.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/17.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineView.h"
#import "ScheduleView.h"
#import "CanvasView.h"
#import <PencilKit/PencilKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : UIViewController
@property(nonatomic,strong) TimeLineView * timeLineView;
@property(nonatomic,strong) ScheduleView * scheduleView;
@property(nonatomic,strong) CanvasView * canvasView;
//@property(nonatomic,assign) NSInteger homeLayout;
@property(nonatomic,strong) UIView *line1;
@property(nonatomic,strong) UIView *line2;
@property(nonatomic,strong) PKDrawing * drawing;
@property(nonatomic,strong) UIImage * result;
@property(nonatomic,strong) NSDate * selectDay;
@end

NS_ASSUME_NONNULL_END
