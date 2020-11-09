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
    [self.resultView addSubview:self.canvasView];
    [self.canvasView show];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = YES;
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.textColor = [UIColor blackColor];
    [cancleBtn addTarget:self action:@selector(cancleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.textColor = [UIColor blackColor];
    [saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    [self.view addSubview:saveBtn];
    [self.canvasView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.resultView);
        make.top.equalTo(self.resultView);
        make.bottom.equalTo(self.resultView);
        make.right.equalTo(self.resultView);
    }];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(10);
    }];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-10);
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
    NSString * currentDate = [self getCurrentTimeAndWeekDayFromDate:_day];
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:currentDate];
    [NSKeyedArchiver archiveRootObject:notedata toFile:filePath];
    [self.canvasView removePKToolPicker];
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
        _resultView = [[UIImageView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, self.view.bounds.size.width, self.view.bounds.size.height-50)];
        _resultView.image = self.img;
        _resultView.backgroundColor = bg_color;
    }
    return _resultView;
}
-(Canvas *)canvasView{
    if (!_canvasView) {
        _canvasView = [[Canvas alloc]init];
    }
    return _canvasView;
}

@end
