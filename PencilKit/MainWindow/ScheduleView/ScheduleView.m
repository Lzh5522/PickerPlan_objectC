//
//  ScheduleView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/17.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "ScheduleView.h"
#import "ScheduleCell.h"
#import "ScheduleTextViewCellTableViewCell.h"
#import "CustomSheduleCell.h"
@interface ScheduleView()<UITableViewDelegate,UITableViewDataSource,ScheduleCellDelegate>
{
    CGFloat _height;
    NSInteger _cellTag;
}
@property(nonatomic,strong) NSMutableArray * noteArr;
@end
@implementation ScheduleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scheduleTableView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleAndNotes:) name:@"AddNoteVC.Notes" object:nil];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.scheduleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
}
-(void)titleAndNotes:(NSNotification * )sender{
    NSDictionary * dic = sender.userInfo;
    NSString * note = dic[@"note"];
    [self.noteArr addObject:note];
    NSLog(@"note arr is %@",self.noteArr);
    [self.scheduleTableView reloadData];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark lazy
-(NSMutableArray *)noteArr{
    if (!_noteArr) {
        _noteArr = [NSMutableArray array];
    }
    return _noteArr;
}
-(UITableView *)scheduleTableView{
    if (!_scheduleTableView) {
        _scheduleTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scheduleTableView.delegate = self;
        _scheduleTableView.dataSource = self;
        _scheduleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _scheduleTableView.estimatedRowHeight = 100;
        _scheduleTableView.rowHeight = UITableViewAutomaticDimension;
        _scheduleTableView.backgroundColor = bg_color;
        [_scheduleTableView registerClass:[CustomSheduleCell class] forCellReuseIdentifier:@"cellID"];
    }
    return _scheduleTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noteArr.count;
//    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * ID = @"ScheduleTextViewCellTableViewCell";
//    [tableView registerNib:[UINib nibWithNibName:@"ScheduleTextViewCellTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
//    ScheduleTextViewCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
//    cell.textLabel.text = self.noteArr[indexPath.row];
    CustomSheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.timeLabel.text = @"10:30";
    cell.noteLabel.text = self.noteArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ScheduleTextViewCellTableViewCell * cell = [self.scheduleTableView cellForRowAtIndexPath:indexPath];
//    if(cell.textView.text == nil){
//        return 100;
//    }
//    else{
//        return UITableViewAutomaticDimension;
//    }
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleTextViewCellTableViewCell * cell = [self.scheduleTableView cellForRowAtIndexPath:indexPath];
    [cell.textView becomeFirstResponder];
    NSLog(@"clicked");
}

@end
