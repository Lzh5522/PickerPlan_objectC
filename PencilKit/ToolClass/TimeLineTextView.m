//
//  TimeLineTextView.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/6.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "TimeLineTextView.h"

@implementation TimeLineTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.roundView];
        [self addSubview:self.textView];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getEvenFromTimeLine:) name:@"TimeLineTextView.event" object:nil];
    }
    return self;
}
-(void)tapSelf{
    EKEventViewController * vc = [[EKEventViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.event = self.event;
        // 弹出视图的大小
    vc.preferredContentSize = CGSizeMake(300, 200);

        // 弹出视图设置
    UIPopoverPresentationController *popver = vc.popoverPresentationController;
//    popver.delegate = self;
        //弹出时参照视图的大小，与弹框的位置有关
    popver.sourceRect = self.bounds;
        //弹出时所参照的视图，与弹框的位置有关
    popver.backgroundColor = [UIColor whiteColor];
    popver.sourceView = self;
        //弹框的箭头方向
    popver.permittedArrowDirections = UIPopoverArrowDirectionLeft;

    popver.backgroundColor = [UIColor whiteColor];
    UIViewController * currentVC = [[self class]viewControllerFromView:self];
    
    [currentVC presentViewController:vc animated:YES completion:nil];
}
//获取当前view的控制器
+ (UIViewController *)viewControllerFromView:(UIView *)view {
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(10);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roundView.right);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
-(EKEvent *)event{
    if (!_event) {
        _event = [[EKEvent alloc]init];
    }
    return _event;
}
-(UIView *)roundView{
    if (!_roundView) {
        _roundView = [[UIView alloc]init];
        _roundView.backgroundColor = RGB(83, 64, 151, 1);
        _roundView.layer.cornerRadius = 5;
        _roundView.layer.masksToBounds = YES;
    }
    return _roundView;
}
-(UILabel *)textView{
    if (!_textView) {
        _textView = [[UILabel alloc]init];
        _textView.backgroundColor = RGB(247, 244, 255, 1);
        _textView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf)];
        [_textView addGestureRecognizer:tap];
    }
    return _textView;
}
@end
