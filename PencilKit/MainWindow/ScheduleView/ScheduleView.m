//
//  ScheduleView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/17.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "ScheduleView.h"
#import "CustomSheduleCell.h"
@interface ScheduleView()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _height;
    NSInteger _cellTag;
}
@property(nonatomic,strong) NSMutableArray * noteArr;
@property(nonatomic,strong) NSMutableArray * timeArr;
@property(nonatomic,copy) NSString * changingNote;
@end
@implementation ScheduleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scheduleTableView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleAndNotes:) name:@"AddNoteVC.Notes" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leanCloudTime:) name:@"AddNoteVC.Time" object:nil];
        
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
-(void)leanCloudTime:(NSNotification *)sender{
    NSDictionary * dic = sender.userInfo;
    NSString * time = dic[@"time"];
    [self.timeArr addObject:time];
    [self.scheduleTableView reloadData];
}
-(void)titleAndNotes:(NSNotification * )sender{
    NSDictionary * dic = sender.userInfo;
    NSString * note = dic[@"note"];
    [self.noteArr addObject:note];
    [self.scheduleTableView reloadData];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark lazy
-(NSString *)changingNote{
    if (!_changingNote) {
        _changingNote = [NSString string];
    }
    return _changingNote;
}
-(NSMutableArray *)noteArr{
    if (!_noteArr) {
        _noteArr = [NSMutableArray array];
    }
    return _noteArr;
}
-(NSMutableArray *)timeArr{
    if(!_timeArr){
        _timeArr = [NSMutableArray array];
    }
    return _timeArr;
}
-(UITableView *)scheduleTableView{
    if (!_scheduleTableView) {
        _scheduleTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scheduleTableView.delegate = self;
        _scheduleTableView.dataSource = self;
        _scheduleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomSheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    if (self.timeArr.count !=0) {
        cell.timeLabel.text = self.timeArr[indexPath.row];
    }
    if (self.noteArr.count != 0) {
        cell.noteLabel.text = self.noteArr[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}
@end
