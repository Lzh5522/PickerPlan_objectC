//
//  AddNoteVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/4.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "AddNoteVC.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
@interface AddNoteVC ()<UITextViewDelegate,UIPickerViewDataSource,EKEventEditViewDelegate>
@property(nonatomic,strong) UIPickerView * pickerView;
@property(nonatomic,strong) UIButton * cancleBtn;
@property(nonatomic,strong) UIButton * hardTimeBtn;
@property(nonatomic,strong) UIButton * softTimeBtn;
@property(nonatomic,strong) UIButton * leftBtn;
@property(nonatomic,strong) UIButton * rightBtn;
@property(nonatomic,strong) UIView * unionView;
@property(nonatomic,strong) UITextView * textView;
@property(nonatomic,assign) CGRect oldFrame;
@property(nonatomic,assign) BOOL keyBoardlsVisible;
@property(nonatomic,strong) EKEventStore * eventStore;
@property(nonatomic,strong) EKEventEditViewController * ekEditVC;
@end

@implementation AddNoteVC
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, ScreenW, ScreenH);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    /*
     手势
     */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_textView addGestureRecognizer:pan];
    self.oldFrame = self.textView.frame;
}
#pragma mark pan
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (rec.view.frame.origin.x<60) {
            [self showTimePicker:0];
            rec.view.frame = self.oldFrame;
        }else if(rec.view.frame.origin.x+ rec.view.frame.size.width > ScreenW-60){
            [self showTimePicker:1];
            rec.view.frame = self.oldFrame;
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                rec.view.frame = self.oldFrame;
            }];
        }
    }
}

#pragma mark show time picker
-(void)showTimePicker:(NSInteger) direction{
    switch (direction) {
        case 0:{
            /*
             左  硬时间
             */
            
//            CalendarView * view = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
//
//            [popVC.view addSubview:view];

            self.ekEditVC.event.notes = self.textView.text;
            self.ekEditVC.event.startDate = self.selectDay;
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour) fromDate:self.selectDay];
            components.hour += 1;
            NSDate * endDate = [calendar dateFromComponents:components];
            self.ekEditVC.event.endDate = endDate;
            [self presentViewController:self.ekEditVC animated:NO completion:nil];

        }
            break;
        case 1:{
            /*
             右 软时间
             */
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            NSString * note = self.textView.text;
            [userInfo setObject:note forKey:@"note"];
            NSNotification *notify = [[NSNotification alloc] initWithName:@"AddNoteVC.Notes" object:nil userInfo:userInfo];
            [[NSNotificationCenter defaultCenter] postNotification:notify];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
            break;;
        default:
            break;
    }
    
}
#pragma mark EvenKitDelegate
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action;{
    switch (action) {
        case EKEventEditViewActionCanceled:
        {
            [self.ekEditVC dismissViewControllerAnimated:NO completion:nil];
        }
            break;
        case EKEventEditViewActionSaved:
        {
            //传递数据
            EKEvent * event = controller.event;
            NSDateFormatter* formatter0 = [[NSDateFormatter alloc] init];
            [formatter0 setDateFormat:@"yyyyMMddHHmmss"];
            //变为数字
            NSString* s0 = [formatter0 stringFromDate:event.startDate];
            NSString * startDateHour = [s0 substringWithRange:NSMakeRange(8, 2)];
            NSString * startDateMinute = [s0 substringWithRange:NSMakeRange(10, 2)];
            NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyyMMddHHmmss"];
            //变为数字
            NSString* s1 = [formatter1 stringFromDate:event.endDate];
            NSString * endDateHour = [s1 substringWithRange:NSMakeRange(8, 2)];
            NSString * endDateMinute = [s1 substringWithRange:NSMakeRange(10, 2)];
            NSString * title = [NSString stringWithFormat:@"%@:%@ - %@:%@  → %@",startDateHour,startDateMinute,endDateHour,endDateMinute,event.title];
            NSString * notes = event.notes;

//            NSString * startDateResult = [startDate ]
            
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:5];
            [userInfo setObject:title forKey:@"title"];
            if (notes) {
                [userInfo setObject:notes forKey:@"notes"];
            }
            [userInfo setObject:startDateHour forKey:@"startDate"];
            [userInfo setObject:endDateHour forKey:@"endDate"];
            [userInfo setObject:controller.event forKey:@"event"];
            NSNotification *notify = [[NSNotification alloc] initWithName:@"AddNoteVC.TitleAndNotes" object:nil userInfo:userInfo];
            [[NSNotificationCenter defaultCenter] postNotification:notify];
            
            
            [self.ekEditVC dismissViewControllerAnimated:NO completion:nil];
            [self dismissViewControllerAnimated:NO completion:nil];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark keyboard
-(void)keyboardDidShow{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.frame = CGRectMake(0, -(418-340), ScreenW, ScreenH);
    });
}
-(void)keyboardDidHide{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    });
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}
#pragma mark UI
-(void)setUpUI{
    /*
     unioView constraint
     */
    self.view.backgroundColor = bg_color;
    [self.view addSubview:self.hardTimeBtn];
    [self.view addSubview:self.softTimeBtn];
    [self.view addSubview:self.cancleBtn];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.textView];
    
    _hardTimeBtn.frame = CGRectMake(12, 399, 38, 38);
    _softTimeBtn.frame = CGRectMake(1143, 399, 38, 38);
    _cancleBtn.frame = CGRectMake(567, 264, 60, 60);
    _leftBtn.frame = CGRectMake(262, 399, 17, 36);
    _rightBtn.frame = CGRectMake(917, 399, 37, 36);
    _textView.frame = CGRectMake(297, 354, 600, 124);
    [_textView setCornerRadius:30 addRectCorners:UIRectCornerAllCorners];
}
#pragma mark lazy
-(EKEventStore *)eventStore{
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc]init];
    }
    return _eventStore;
}
-(EKEventEditViewController *)ekEditVC{
    if (!_ekEditVC) {
        _ekEditVC = [[EKEventEditViewController alloc]init];
        _ekEditVC.eventStore = self.eventStore;
        _ekEditVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        _ekEditVC.title = self.textView.text;
        _ekEditVC.editViewDelegate = self;
    }
    return _ekEditVC;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc]init];
        [_cancleBtn setImage:[UIImage imageNamed:@"cancle_btn"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIButton *)hardTimeBtn{
    if (!_hardTimeBtn) {
        _hardTimeBtn = [[UIButton alloc]init];
        [_hardTimeBtn setImage:[UIImage imageNamed:@"hard_time"] forState:UIControlStateNormal];
        _hardTimeBtn.userInteractionEnabled = NO;
    }
    return _hardTimeBtn;
}
-(UIButton *)softTimeBtn{
    if (!_softTimeBtn) {
        _softTimeBtn = [[UIButton alloc]init];
        [_softTimeBtn setImage:[UIImage imageNamed:@"soft_time"] forState:UIControlStateNormal];
        _softTimeBtn.userInteractionEnabled = NO;
    }
    return _softTimeBtn;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
        [_leftBtn setImage:[UIImage imageNamed:@"store_left"] forState:UIControlStateNormal];
        _leftBtn.userInteractionEnabled = NO;
    }
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setImage:[UIImage imageNamed:@"store_right"] forState:UIControlStateNormal];
        _rightBtn.userInteractionEnabled = NO;
    }
    return _rightBtn;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.textColor = font_color;
        _textView.font = [UIFont systemFontOfSize:24];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _textView;
}
-(NSDate *)selectDay{
    if (!_selectDay) {
        _selectDay = [[NSDate alloc]init];
    }
    return _selectDay;
}
#pragma mark func
-(void)cancleBtnClicked{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
