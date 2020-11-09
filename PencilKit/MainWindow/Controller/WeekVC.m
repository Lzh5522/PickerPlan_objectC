//
//  WeekVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/17.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "WeekVC.h"
#import <PencilKit/PencilKit.h>
@interface WeekVC ()
@property(nonatomic,strong) PKCanvasView * canvasView;
@property(nonatomic,strong) PKToolPicker * picker;
@end

@implementation WeekVC

- (void)viewDidLoad {
    [super viewDidLoad];
    PKCanvasView * canvasView = [[PKCanvasView alloc]initWithFrame:self.view.bounds];
    self.canvasView = canvasView;
    [self.view addSubview:self.canvasView];
    self.canvasView.backgroundColor = [UIColor blackColor];
    PKToolPicker * picker = [[PKToolPicker alloc]init];
    self.picker = picker;
//    picker = [PKToolPicker sharedToolPickerForWindow:self.view.window];
    
    [self.picker addObserver:self.canvasView];
//    DispatchQueue.main.async {
//               uiView.becomeFirstResponder()
//           }
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 200, 200)];
    btn.titleLabel.text = @"草拟吗";
    btn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(dosome) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)dosome{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.picker setVisible:YES forFirstResponder:self.canvasView];
        [self.canvasView becomeFirstResponder];
    });
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
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
