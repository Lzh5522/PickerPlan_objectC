//
//  CanvasVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/2.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "CanvasVC.h"
#import <PencilKit/PencilKit.h>
@interface CanvasVC ()
@property(nonatomic,strong) PKCanvasView * canvasView;
@property(nonatomic,strong) PKToolPicker * picker;
@end

@implementation CanvasVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _picker = [[PKToolPicker alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.picker setVisible:YES forFirstResponder:self.canvasView];
        [self.picker addObserver:self.canvasView];
        [self.canvasView becomeFirstResponder];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _canvasView = [[PKCanvasView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:_canvasView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
