//
//  MainWindowVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MainWindowVC.h"
#import <UIKit/UIKit.h>
#import "NavView.h"
#define padding 10
#define btnPadding 70
#import "HomeVC.h"
#import "WeekVC.h"
#import "MenuView.h"
#import "CanvasView.h"
#import "MonthVC.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "CalendarView.h"
#import "YearVC.h"
#import "CanvasVC.h"
#import <PencilKit/PencilKit.h>
#import "Canvas.h"
#import "UIImage+GetCurrentImage.h"
#import "MonthView.h"
#import "DetailDayVC.h"
#import "AddNoteVC.h"
#import "NSDate+Calendar.h"
#import "CanlendarToolView.h"
#import "MenuView.h"
#import "ShareVC.h"
#import "TimeVC.h"
@interface MainWindowVC ()<NavigationViewDelegate,UIPopoverPresentationControllerDelegate>

@property(nonatomic,strong) NavView * navView;
@property(nonatomic,strong) MenuView * menuView;
@property(nonatomic,strong) UIViewController * popVC;

@end

@implementation MainWindowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self setUpUI];
}
-(Canvas *)canvas{
    if (!_canvas) {
        _canvas = [[Canvas alloc]initWithFrame:self.view.bounds];
    }
    return _canvas;
}
-(void)setUpUI{
    self.count = 0;
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(navigationViewHeight);
    }];
    [self.view addSubview:self.menuView];
    HomeVC * homeVC = [[HomeVC alloc]init];
    
    [self addChildViewController:homeVC];
    MonthVC * monthVC = [[MonthVC alloc]init];
    
    [self addChildViewController:monthVC];
    YearVC * yearVC = [[YearVC alloc]init];
    
    [self addChildViewController:yearVC];
    TimeVC * timeVC = [[TimeVC alloc]init];
    
    [self addChildViewController:timeVC];
    [self addNotificationObserver];
}
- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"YearVC.ChangeCalendarHeaderNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDay:) name:@"MonthScrollView.SelectedDay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMonthCalendarHeaderAction:) name:@"MonthScrollView.ChangeCalendarHeaderNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectDayJump:) name:@"MonthScrollView.SelectedDay.tiao" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectNoReuslt) name:@"MonthScrollView.NoResult" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMonthJump:) name:@"YearVC.SelectedMonth" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMonthDetialJump:) name:@"YearVC.SelectedMonthDetail" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCalendarDay:) name:@"Calendar.SelectedDay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectNoReuslt) name:@" CalendarScrollView.SelectedNoResult" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removePopVC) name:@" CalendarScrollView.removePOPVC" object:nil];
   
}
-(void)removePopVC{
    [self.popVC dismissViewControllerAnimated:NO completion:nil];
}
-(void)selectCalendarDay:(NSNotification *)sender{
    NSDictionary * dic = sender.userInfo;
    NSDate * date = dic[@"select_day"];
    UserNoteData * noteData = dic[@"userNoteData"];
    DetailDayVC * detailVC = [[DetailDayVC alloc]init];
    detailVC.modalPresentationStyle = UIModalPresentationFullScreen;
    detailVC.img = noteData.result;
    detailVC.day = date;
    [self presentViewController:detailVC animated:NO completion:nil];
}
-(void)selectMonthDetialJump:(NSNotification *) sender{
    //更改标题
    NSDictionary * dic = sender.userInfo;
    NSDate * date = dic[@"selectedDate"];
    self.navView.timeLabel.text =[NSString stringWithFormat:@"%ld年%ld月",[date dateYear],[date dateMonth]];
    //界面跳转
    self.navView.canlenderToolView.weekBtn.selected = YES;
    self.navView.canlenderToolView.monthBtn.selected = NO;
    self.selectedIndex= 1;
}
-(void)selectMonthJump:(NSNotification *)sender{
    //界面跳转
    NSDictionary * dic = sender.userInfo;
    NSDate * date = dic[@"selectedDate"];
    self.navView.timeLabel.text =[NSString stringWithFormat:@"%ld年%ld月",[date dateYear],[date dateMonth]];
    self.navView.canlenderToolView.weekBtn.selected = YES;
    self.navView.canlenderToolView.monthBtn.selected = NO;
    self.selectedIndex= 1;
}
-(void)selectNoReuslt{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"那一天没有笔记" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:nil];
        }];
    [alertVC addAction:alertT];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
-(void)changeMonthCalendarHeaderAction:(NSNotification *)sender{
    NSDictionary *dic = sender.userInfo;
    NSNumber * year = dic[@"now_year"];
    NSNumber * month = dic[@"now_month"];
    self.navView.timeLabel.text =[NSString stringWithFormat:@"%@年%@月",year,month];

}
- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)selectDay:(NSNotification *)sender{
    NSDictionary *dic = sender.userInfo;
    NSDate *day = dic[@"select_day"];
    NSString * selectDay = [self getCurrentTimeAndWeekDayFromDate:[day previousDate]];//当前选择是几月几号
    //解档
    UserNoteData * userNoteData = [[UserNoteData alloc]init];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:selectDay];
    userNoteData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(userNoteData){
        DetailDayVC * detailVC = [[DetailDayVC alloc]init];
        detailVC.modalPresentationStyle = UIModalPresentationFullScreen;
        detailVC.img = userNoteData.result;
        detailVC.day = day;
        [self presentViewController:detailVC animated:NO completion:nil];
    }
  
}
-(void)selectDayJump:(NSNotification *)sender{
    NSDictionary *dic = sender.userInfo;
    NSDate *day0 = dic[@"select_day"];
    NSDate *day = [day0 previousDate];
    HomeVC * vc = self.viewControllers[0];
    [vc.view setNeedsLayout];
    vc.drawing = [[PKDrawing alloc]init];
    vc.result = [[UIImage alloc]init];
    vc.selectDay = day;
    
    self.navView.canlenderToolView.dayBtn.selected = YES;
    self.navView.canlenderToolView.weekBtn.selected = NO;
    self.selectedIndex = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navView.timeLabel.text  = [self getCurrentTimeAndWeekDayFromDate:day];
    });
}
-(void)changeCalendarHeaderAction:(NSNotification *)sender{
    NSDictionary *dic = sender.userInfo;
    
    NSNumber *year = dic[@"year"];
    NSString *title = [NSString stringWithFormat:@"%@年", year];
    
    _navView.timeLabel.text =  title;
}

- (NSString *)getCurrentTimeYear{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    return [NSString stringWithFormat:@"%ld年",year];
}
- (NSString *)getCurrentTimeYearAndMonth {
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    return   [NSString stringWithFormat:@"%ld年%ld月",year,month];
}
#pragma mark 获取当日时间
- (NSString *)getCurrentTimeAndWeekDay {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    return   [NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
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
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}
-(void)handleCanlenderToolAction:(NSInteger)tag{
    HomeVC * homeVC = [[HomeVC alloc]init];
    homeVC = self.viewControllers[0];
    Canvas * c = [[Canvas alloc]init];
    
    for (NSInteger i =0; i<homeVC.view.subviews.count; i++) {
        if ([homeVC.view.subviews[i] isKindOfClass:[Canvas class]]) {
            c = homeVC.view.subviews[i];
        }
    }
    switch (tag) {
        case 0:
            self.selectedIndex = 0;
            c.canvas.drawing = [PKDrawing new];
            self.navView.menuBtn.hidden = NO;
            self.navView.shareBtn.hidden = NO;
            self.navView.canlendarBtn.hidden = NO;
            self.navView.timeLabel.hidden = NO;
            self.navView.addBtn.hidden = NO;
            self.navView.pkToolBtn.hidden = NO;
            self.navView.timeLabel.text = [self getCurrentTimeAndWeekDay];
            self.navView.canlenderToolView.dayBtn.selected = YES;
            self.navView.canlenderToolView.monthBtn.selected = NO;
            break;
        case 1:
            self.selectedIndex = 1;
            self.navView.timeLabel.text = [self getCurrentTimeYearAndMonth];
            self.navView.menuBtn.hidden = NO;
            self.navView.timeLabel.hidden = NO;
            self.navView.shareBtn.hidden = NO;
            self.navView.canlendarBtn.hidden = NO;
            self.navView.addBtn.hidden = YES;
            self.navView.pkToolBtn.hidden = YES;
            break;
        case 2:
            self.selectedIndex = 2;
            self.navView.timeLabel.text = [self getCurrentTimeYear];
            self.navView.timeLabel.hidden = NO;
            self.navView.menuBtn.hidden = NO;
            self.navView.shareBtn.hidden = NO;
            self.navView.canlendarBtn.hidden = NO;
            self.navView.addBtn.hidden = YES;
            self.navView.pkToolBtn.hidden = YES;
            break;
        case 3:
            self.selectedIndex = 3;
            self.navView.menuBtn.hidden = NO;
            self.navView.timeLabel.hidden = YES;
            self.navView.shareBtn.hidden = NO;
            self.navView.canlendarBtn.hidden = NO;
            self.navView.addBtn.hidden = YES;
            self.navView.pkToolBtn.hidden = YES;
            break;
        default:
            break;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.menuView.frame = CGRectMake(-320, 0, 320, ScreenH);
    }];
}
-(void)handleBtnAction:(UIButton *)btn{
    switch (btn.tag) {
        case 10:
        {
            //menu
            [UIView animateWithDuration:0.5 animations:^{
                self.menuView.frame = CGRectMake(0, 0, 320, ScreenH);
            }];
        }
            break;
        case 11:
        {
            
            ShareVC *popVC = [[ShareVC alloc] init];
            popVC.modalPresentationStyle = UIModalPresentationPopover;
                // 弹出视图的大小
            popVC.preferredContentSize = CGSizeMake(375, 600);

                // 弹出视图设置
            UIPopoverPresentationController *popver = popVC.popoverPresentationController;
            popver.delegate = self;
                //弹出时参照视图的大小，与弹框的位置有关
            popver.sourceRect = btn.bounds;
                //弹出时所参照的视图，与弹框的位置有关
            popver.sourceView = btn;
                //弹框的箭头方向
            popver.permittedArrowDirections = UIPopoverArrowDirectionUp;

            popver.backgroundColor = [UIColor whiteColor];
            [self presentViewController:popVC animated:YES completion:nil];
            btn.selected = YES;
            
            
        }
            break;
        case 12:{
            UIViewController *popVC = [[UIViewController alloc]init];
            self.popVC = popVC;
            self.popVC.modalPresentationStyle = UIModalPresentationPopover;
                // 弹出视图的大小
            self.popVC.preferredContentSize = CGSizeMake(300, 260);
            CalendarView * view = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
            
            [self.popVC.view addSubview:view];
            
                // 弹出视图设置
            UIPopoverPresentationController *popver = self.popVC.popoverPresentationController;
            popver.delegate = self;
                //弹出时参照视图的大小，与弹框的位置有关
            popver.sourceRect = btn.bounds;
                //弹出时所参照的视图，与弹框的位置有关
            popver.sourceView = btn;
                //弹框的箭头方向
            popver.permittedArrowDirections = UIPopoverArrowDirectionUp;
            [self presentViewController:self.popVC animated:YES completion:nil];
            btn.selected = YES;
        }
            break;
        case 13:
        {
            
            if(btn.selected == YES){
                UIViewController * vc = self.viewControllers[0];
                for (int i = 0; i<vc.view.subviews.count; i++) {
                    if ([vc.view.subviews[i] isKindOfClass:[Canvas class]]) {
                        Canvas * canvas = [[Canvas alloc]init];
                        canvas = vc.view.subviews[i];
                        HomeVC * homeVC = [[HomeVC alloc]init];
                        homeVC = self.viewControllers[0];
                        /*
                         存储  drawing
                         */
                        homeVC.drawing = canvas.canvas.drawing;
                        homeVC.result = [UIImage getCurrentInnerViewShot:homeVC.view atFrame:CGRectMake(0, navigationViewHeight, ScreenW, homeVC.view.bounds.size.height-70)];
                        /*
                         存储当日数据
                         */
                        UserNoteData * noteData = [[UserNoteData alloc]init];
                        noteData.result = homeVC.result;
                        //获取当日时间
                        NSString * currentDate = [self getCurrentTimeAndWeekDayFromDate:homeVC.selectDay];
                        NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
                        NSString *filePath = [path stringByAppendingPathComponent:currentDate];
                        [NSKeyedArchiver archiveRootObject:noteData toFile:filePath];
                        [canvas removePKToolPicker];
//                        [canvas removeFromSuperview];
                        [canvas sendSubviewToBack:vc.view];
                        canvas.userInteractionEnabled = NO;
                    }
                }
                
                btn.selected = NO;
                self.navView.menuBtn.userInteractionEnabled = YES;
                self.navView.shareBtn.userInteractionEnabled = YES;
                self.navView.addBtn.userInteractionEnabled = YES;
                self.navView.canlendarBtn.userInteractionEnabled = YES;
                self.navView.canlenderToolView.userInteractionEnabled = YES;
                /*
                 刷新数据  发通知
                 */
                [[NSNotificationCenter defaultCenter] postNotificationName:@"current_day_drawing_changed" object:nil];
            }
                else{
                HomeVC * vc = self.viewControllers[0];
//                Canvas * canvas = [[Canvas alloc]initWithFrame:self.view.bounds];
                    if (self.count == 0) {
                        [vc.view addSubview:self.canvas];
                    }
                self.count +=1;
                self.canvas.userInteractionEnabled = YES;
                [self.canvas bringSubviewToFront:vc.view];
                [self.canvas show];
                if (vc.drawing) {
                    self.canvas.canvas.drawing = vc.drawing;
                }else{
                    
                }
                btn.selected = YES;
                self.navView.menuBtn.userInteractionEnabled = NO;
                self.navView.shareBtn.userInteractionEnabled = NO;
                self.navView.addBtn.userInteractionEnabled = NO;
                self.navView.canlendarBtn.userInteractionEnabled = NO;
                self.navView.canlenderToolView.userInteractionEnabled = NO;
            }
            
        }
            break;
        case 14:{
            AddNoteVC * vc = [[AddNoteVC alloc]init];
            HomeVC * homevc = self.viewControllers[0];
            NSDate * day = [NSDate date];
            if ([homevc.selectDay dateDay] != [day dateDay]) {
                vc.selectDay = homevc.selectDay;
            }
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.selectedViewController presentViewController:vc animated:NO completion:nil];
            
        }
            break;;
        default:
            break;
    }
}
#pragma lazy
-(NavView *)navView{
    if (!_navView) {
        _navView = [[NavView alloc]init];
        _navView.delegate = self;
    }
    return _navView;
}
-(MenuView *)menuView{
    if (!_menuView) {
        _menuView = [[MenuView alloc]initWithFrame:CGRectMake(-320, 0, 320, ScreenH)];
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenu:)];
        [_menuView addGestureRecognizer:pan];
    }
    return _menuView;
}
-(void)hideMenu:(UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (rec.view.frame.origin.x<280) {
            rec.view.frame = CGRectMake(-320, 0, 320, ScreenH);
        }
    }
}

@end
