//
//  TimeLineTextView.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/6.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineTextView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TimeLineTextViewDelegate <NSObject>

-(void)showDetailView:(EKEvent *)event;

@end
@interface TimeLineTextView : UIView
@property(nonatomic,strong) UIView * roundView;
@property(nonatomic,strong) UILabel * textView;
@property(nonatomic,weak) id<TimeLineTextViewDelegate> delegate;
@property(nonatomic,strong) EKEvent * event;
@end

NS_ASSUME_NONNULL_END
