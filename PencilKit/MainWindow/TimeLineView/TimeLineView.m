//
//  TimeLineView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/22.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "TimeLineView.h"
#import "TimeLineCell.h"
#import "HalfCell.h"
#import "UITextField+AddCorners.h"
#import "TimeLineLabel.h"
#import "TimeLineTextView.h"
#import "UIView+AddCorners.h"

@interface TimeLineView()<UITableViewDataSource,UITableViewDelegate,TimeLineTextViewDelegate>
@property(nonatomic,strong) NSArray * timeArr;
@property(nonatomic,strong) NSArray * cellNameArr;
@end

@implementation TimeLineView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.timeLineTableView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.timeArr = [NSArray arrayWithObjects:
                    @"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",
                    @"00:60",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",
                    @"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",
                    @"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",
                    @"00:00",
                    nil];
    [self.timeLineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleAndNotes:) name:@"AddNoteVC.TitleAndNotes" object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark TimeLineTextView Delegate
-(void)showDetailView:(id)textView{
    
}
-(void)titleAndNotes:(NSNotification * )sender{
    NSDictionary *dic = sender.userInfo;
    NSString * title = dic[@"title"];
    NSString * notes = dic[@"notes"];
    NSString * startDate = dic[@"startDate"];
    NSString * endDate = dic[@"endDate"];
    EKEvent * event = dic[@"event"];
    NSInteger startIndex = [[startDate substringWithRange:NSMakeRange(0, 2)] integerValue];
    NSInteger endIndex = [[endDate substringWithRange:NSMakeRange(0, 2)] integerValue];
    if (endIndex<=6) {
        TimeLineLabel * titleLabel = [[TimeLineLabel alloc]initWithFrame:CGRectMake(40, 20*(endIndex-startIndex)+10, (self.bounds.size.width-40)/2.0, 20*(endIndex-startIndex))];
        titleLabel.label.backgroundColor = RGB(247, 244, 255, 1);
        titleLabel.label.text = title;
        titleLabel.label.textColor = font_color;
        titleLabel.label.numberOfLines = 0;
        titleLabel.label.font = [UIFont systemFontOfSize:8];
        [titleLabel setCornerRadius:5 addRectCorners:UIRectCornerAllCorners];
        titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
        TimeLineTextView * notesTextView = [[TimeLineTextView alloc]initWithFrame:CGRectMake((self.bounds.size.width-40)/2.0+40, 20*(endIndex-startIndex)+10, (self.bounds.size.width-40)/2.0, 20*(endIndex-startIndex))];
        notesTextView.textView.text = notes;
    
        notesTextView.textView.textColor = font_color;
        notesTextView.textView.backgroundColor = RGB(247, 244, 255, 1);
        [notesTextView setCornerRadius:5 addRectCorners:UIRectCornerAllCorners];
        notesTextView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:titleLabel];
        [self addSubview:notesTextView];
    }else if(startIndex >= 6){
        TimeLineLabel * titleLabel = [[TimeLineLabel alloc]initWithFrame:CGRectMake(40, 20*6+32*(startIndex-6)+10, (self.bounds.size.width-40)/2.0, 32*(endIndex-startIndex))];
        titleLabel.label.backgroundColor = RGB(247, 244, 255, 1);
        titleLabel.label.text = title;
        titleLabel.label.textColor = font_color;
        titleLabel.label.numberOfLines = 0;
        titleLabel.label.font = [UIFont systemFontOfSize:8];
        [titleLabel setCornerRadius:5 addRectCorners:UIRectCornerAllCorners];
        titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
        TimeLineTextView * notesTextView = [[TimeLineTextView alloc]initWithFrame:CGRectMake((self.bounds.size.width-40)/2.0+40, 20*6+32*(startIndex-6)+10, (self.bounds.size.width-40)/2.0, 32*(endIndex-startIndex))];
        notesTextView.delegate = self;
        notesTextView.textView.text = notes;
        notesTextView.textView.textColor = font_color;
        notesTextView.textView.backgroundColor = RGB(247, 244, 255, 1);
        notesTextView.event = event;
        [notesTextView setCornerRadius:5 addRectCorners:UIRectCornerAllCorners];
        notesTextView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:titleLabel];
        [self addSubview:notesTextView];
       
        
    }else{
        TimeLineLabel * titleLabel = [[TimeLineLabel alloc]initWithFrame:CGRectMake(40, 20*(6-startIndex)+10, (self.bounds.size.width-40)/2.0, 20*(6-startIndex)+32*(endIndex-6))];
        titleLabel.label.backgroundColor = RGB(247, 244, 255, 1);
        titleLabel.label.text = title;
        titleLabel.label.textColor = font_color;
        titleLabel.label.numberOfLines = 0;
        titleLabel.label.font = [UIFont systemFontOfSize:8];
        [titleLabel setCornerRadius:5 addRectCorners:UIRectCornerAllCorners];
        titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
        TimeLineTextView * notesTextView = [[TimeLineTextView alloc]initWithFrame:CGRectMake((self.bounds.size.width-40)/2.0+40, 20*(6-startIndex)+10, (self.bounds.size.width-40)/2.0, 20*(6-startIndex)+32*(endIndex-6))];
        notesTextView.textView.text = notes;
        notesTextView.textView.textColor = font_color;
        notesTextView.textView.backgroundColor = RGB(247, 244, 255, 1);
        [notesTextView setCornerRadius:5 addRectCorners:UIRectCornerAllCorners];
        notesTextView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:titleLabel];
        [self addSubview:notesTextView];
    }
    
}

+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}
-(UITableView *)timeLineTableView{
    if (!_timeLineTableView) {
        _timeLineTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _timeLineTableView.delegate = self;
        _timeLineTableView.dataSource = self;
        _timeLineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _timeLineTableView.tableFooterView = [UIView new];
        _timeLineTableView.backgroundColor = bg_color;
        _timeLineTableView.showsVerticalScrollIndicator = NO;
        _timeLineTableView.scrollEnabled = NO;
    }
    return _timeLineTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeArr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    return footView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TimeLineCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[TimeLineCell alloc]init];
        
    }
    cell.timeLabel.text = self.timeArr[indexPath.row];
  
    return cell;

    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 6) {
        return 20;
    }else{
        return 32;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
////    UITextField * textfiled = [[UITextField alloc]initWithFrame:CGRectMake(rect.origin.x+40, rect.origin.y+10, rect.size.width-40, rect.size.height)];
////    textfiled.backgroundColor = [UIColor blueColor];
////    [textfiled setCornerRadius:7 addRectCorners:UIRectCornerAllCorners];
////    [tableView addSubview:textfiled];
//    EKEventViewController * vc = [[EKEventViewController alloc]init];
//    vc.modalPresentationStyle = UIModalPresentationPopover;
//        // 弹出视图的大小
//    vc.preferredContentSize = CGSizeMake(300, 200);
//
//        // 弹出视图设置
//    UIPopoverPresentationController *popver = vc.popoverPresentationController;
////    popver.delegate = self;
//        //弹出时参照视图的大小，与弹框的位置有关
//    popver.sourceRect = rect;
//        //弹出时所参照的视图，与弹框的位置有关
//    TimeLineCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    popver.sourceView = cell;
//        //弹框的箭头方向
//    popver.permittedArrowDirections = UIPopoverArrowDirectionLeft;
//
//    popver.backgroundColor = [UIColor whiteColor];
////    [self.inputViewController presentViewController:vc animated:YES completion:nil];
}

@end
