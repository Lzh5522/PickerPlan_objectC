//
//  HomeVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/17.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "HomeVC.h"
#define padding 20
#import "UserNoteData.h"
#import "NSDate+Calendar.h"

@interface HomeVC ()
//@property(nonatomic,strong) NSArray * timeArr;
@end

@implementation HomeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setUI];
    self.selectDay = [NSDate date];
    //解档
    NSString * day = [NSString stringWithFormat:@"%ld年%ld月%ld日",[_selectDay dateYear],[_selectDay dateMonth],[_selectDay dateDay]];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:day];
    UserNoteData * userNoteData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (userNoteData != nil) {
       
    }else{
    }
    
//
}


#pragma mark UI
-(void)setUI{
    self.view.backgroundColor = bg_color;
    [self.view addSubview:self.timeLineView];
    [self.view addSubview:self.scheduleView];
    [self.view addSubview:self.canvasView];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.view).offset(navigationViewHeight+padding);
        make.width.equalTo((ScreenW-6*padding)/3.0);
        make.bottom.equalTo(self.view).offset(-padding);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLineView.right).offset(padding);
        make.top.equalTo(self.timeLineView).offset(padding);
        make.width.equalTo(0.5);
        make.bottom.equalTo(self.timeLineView).offset(-padding);
    }];
    [self.scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1.right).offset(padding);
        make.top.equalTo(self.view).offset(navigationViewHeight+padding);
        make.width.equalTo((ScreenW-6*padding)/3.0);
        make.bottom.equalTo(self.view).offset(-padding);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scheduleView.right).offset(padding);
        make.top.equalTo(self.timeLineView).offset(padding);
        make.width.equalTo(0.5);
        make.bottom.equalTo(self.timeLineView).offset(-padding);
    }];
    [self.canvasView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.view).offset(navigationViewHeight+padding);
        make.width.equalTo((ScreenW-6*padding)/3.0);
        make.bottom.equalTo(self.view).offset(-padding);
    }];
}
#pragma mark lazy
-(TimeLineView *)timeLineView{
    if (!_timeLineView) {
        _timeLineView = [[TimeLineView alloc]init];
//        _timeLineView.backgroundColor = [UIColor greenColor];
    }
    return _timeLineView;
}
-(ScheduleView *)scheduleView{
    if (!_scheduleView) {
        _scheduleView = [[ScheduleView alloc]init];
        _scheduleView.backgroundColor = bg_color;
    }
    return _scheduleView;
}
-(CanvasView *)canvasView{
    if (!_canvasView) {
        _canvasView = [[CanvasView alloc]init];
        _canvasView.backgroundColor = [UIColor blueColor];
    }
    return _canvasView;
}
-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = [UIColor blackColor];
    }
    
    return _line1;
}
-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = [UIColor blackColor];
    }
    return _line2;
}

@end
