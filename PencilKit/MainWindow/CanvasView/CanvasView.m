//
//  CanvasView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/22.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CanvasView.h"
#import <PencilKit/PencilKit.h>
@interface CanvasView()
@property(nonatomic,strong) PKCanvasView * canvasView;
@property(nonatomic,strong) PKToolPicker * picker;
@end
@implementation CanvasView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.canvasView];
       
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.canvasView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    for(int i = 0;i<16;i++){
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(topPadding/2, 60*i, self.frame.size.width-topPadding, 0.7)];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
    }
   
}

-(PKCanvasView *)canvasView{
    if (!_canvasView) {
        _canvasView = [[PKCanvasView alloc]initWithFrame:self.bounds];
        _canvasView.backgroundColor = bg_color;
    }
    return _canvasView;
}

-(void)show{
   
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.picker setVisible:YES forFirstResponder:self.canvasView];
        [self.picker addObserver:self.canvasView];
        [self.canvasView becomeFirstResponder];
    });
}
-(void)removePKToolPicker{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.picker setVisible:NO forFirstResponder:self.canvasView];
    });
}
-(PKToolPicker *)picker{
    if (!_picker) {
        _picker = [[PKToolPicker alloc]init];
    }
    return _picker;
}
@end
