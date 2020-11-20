//
//  Canvas.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/3.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.canvas];
    }
    return self;
}
-(PKCanvasView *)canvas{
    if (!_canvas) {
        _canvas = [[PKCanvasView alloc]initWithFrame:self.bounds];
        _canvas.backgroundColor = [UIColor clearColor];
    }
    return _canvas;
}
-(PKToolPicker *)picker{
    if (!_picker) {
        _picker = [[PKToolPicker alloc]init];
    }
    return _picker;
}
-(void)show{
   
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.picker setVisible:YES forFirstResponder:self.canvas];
        [self.picker addObserver:self.canvas];
        [self.canvas becomeFirstResponder];
    });
}
-(void)removePKToolPicker{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.picker setVisible:NO forFirstResponder:self.canvas];
    });
}
@end
