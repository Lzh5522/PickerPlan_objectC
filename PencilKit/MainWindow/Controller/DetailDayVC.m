//
//  DetailDayVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/5.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "DetailDayVC.h"
#import "UserNoteData.h"
#import "UIImage+GetCurrentImage.h"
@interface DetailDayVC ()

@end

@implementation DetailDayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.resultView];

    [self.view addSubview:self.canvas];
    [self show];
    self.view.backgroundColor = bg_color;
    self.navigationController.navigationBar.hidden = YES;
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"cancle_btn"] forState:UIControlStateNormal];
    cancleBtn.titleLabel.textColor = [UIColor blackColor];
    [cancleBtn addTarget:self action:@selector(cancleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setImage:[UIImage imageNamed:@"save_btn"] forState:UIControlStateNormal];
    saveBtn.titleLabel.textColor = [UIColor blackColor];
    [saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    [self.view addSubview:saveBtn];
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(30);
    }];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-30);
    }];
    [self.canvas mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
-(void)cancleBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveBtnClicked{
    UserNoteData * notedata = [[UserNoteData alloc]init];
     notedata.result = [UIImage getCurrentInnerViewShot:self.view atFrame:CGRectMake(0, navigationViewHeight, ScreenW, self.resultView.bounds.size.height)];
    /*
     存储该日数据
     */
    //获取当日时间
    NSLog(@"self day %@",self.day);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.day];
    components.day -= 1; // 定位到当月中间日子
    NSDate *previousDate = [calendar dateFromComponents:components];
    NSString * currentDate = [self getCurrentTimeAndWeekDayFromDate:previousDate];
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:currentDate];
    [NSKeyedArchiver archiveRootObject:notedata toFile:filePath];
    //发通知  刷新UI
    NSNotification * notify = [[NSNotification alloc]initWithName:@"DetailDayVC.RefreshUI" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
    [self removePKToolPicker];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSString *)getCurrentTimeAndWeekDayFromDate:(NSDate *)dayDate{
    NSDate *date = dayDate;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    return   [NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
}
#pragma mark lazy
-(UIImageView *)resultView{
    if (!_resultView) {
        _resultView = [[UIImageView alloc]init];
        _resultView.image = self.img;
        _resultView.backgroundColor = bg_color;
        _resultView.userInteractionEnabled = YES;
    }
    return _resultView;
}
-(NSDate *)day{
    if (!_day) {
        _day = [[NSDate alloc]init];
    }
    return _day;
}
-(PKCanvasView *)canvas{
    if (!_canvas) {
        _canvas = [[PKCanvasView alloc]init];
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
