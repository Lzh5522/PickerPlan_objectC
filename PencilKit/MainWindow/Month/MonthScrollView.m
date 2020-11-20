//
//  MonthScrollView.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/4.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MonthScrollView.h"
#import "GFCalendarMonth.h"
#import "NSDate+GFCalendar.h"
#import "MonthCollectionViewCell.h"
@interface MonthScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionViewL;
@property (nonatomic, strong) UICollectionView *collectionViewM;
@property (nonatomic, strong) UICollectionView *collectionViewR;

@property (nonatomic, strong) NSDate *currentMonthDate;

@property (nonatomic, strong) NSMutableArray *monthArray;
@end
@implementation MonthScrollView
static NSString *const kCellIdentifier = @"cell";
#pragma mark - Initialiaztion

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        
        self.contentSize = CGSizeMake(3 * self.bounds.size.width, ScreenH-navigationViewHeight-30-20);
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO];
        
        _currentMonthDate = [NSDate date];
        [self setupCollectionViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentDayDrawingChanged) name:@"current_day_drawing_changed" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedMonth:) name:@"YearVC.SelectedMonth" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedMonthDetail:) name:@"YearVC.SelectedMonthDetail" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:@"DetailDayVC.RefreshUI" object:nil];
    }
    
    return self;
    
}
-(void)refreshUI{
    [self.collectionViewL reloadData];
    [self.collectionViewM reloadData];
    [self.collectionViewR reloadData];
}
-(void)selectedMonthDetail:(NSNotification *)sender{
    NSDictionary * dic = sender.userInfo;
    NSDate * date = dic[@"selectedDate"];
    self.currentMonthDate = date;
    NSLog(@"%@",self.currentMonthDate);
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    NSDate *nextMonthDate = [self.currentMonthDate nextMonthDate];
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:previousMonthDate]];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:self.currentMonthDate]];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:nextMonthDate]];
    [self.monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]];
    
    [self.collectionViewL reloadData];
    [self.collectionViewM reloadData];
    [self.collectionViewR reloadData];
}
-(void)selectedMonth:(NSNotification * )sender{
    NSDictionary * dic = sender.userInfo;
    NSDate * date = dic[@"selectedDate"];
    self.currentMonthDate = date;
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    NSDate *nextMonthDate = [self.currentMonthDate nextMonthDate];
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:previousMonthDate]];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:self.currentMonthDate]];
    [self.monthArray addObject:[[GFCalendarMonth alloc] initWithDate:nextMonthDate]];
    [self.monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]];
    [self.collectionViewL reloadData];
    [self.collectionViewM reloadData];
    [self.collectionViewR reloadData];
}
- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)currentDayDrawingChanged{
    [self.collectionViewL reloadData];
    [self.collectionViewM reloadData];
    [self.collectionViewR reloadData];
}
-(NSDate *)selectedDate{
    if (!_selectedDate) {
        _selectedDate = [[NSDate alloc]init];
    }
    return _selectedDate;
}
- (NSMutableArray *)monthArray {
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray arrayWithCapacity:4];
        
        NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
        
        [_monthArray addObject:[[GFCalendarMonth alloc] initWithDate:previousMonthDate]];
        [_monthArray addObject:[[GFCalendarMonth alloc] initWithDate:_currentMonthDate]];
        [_monthArray addObject:[[GFCalendarMonth alloc] initWithDate:nextMonthDate]];
        [_monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]]; // 存储左边的月份的前一个月份的天数，用来填充左边月份的首部
        
        // 发通知，更改当前月份标题
//        [self notifyToChangeCalendarHeader];
    }
    
    return _monthArray;
}
- (NSNumber *)previousMonthDaysForPreviousDate:(NSDate *)date {
    return [[NSNumber alloc] initWithInteger:[[date previousMonthDate] totalDaysInMonth]];
}

- (void)setupCollectionViews {
        
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width / 7.0, self.bounds.size.height / 6.0);
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat selfHeight = self.bounds.size.height;
    
    _collectionViewL = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    _collectionViewL.dataSource = self;
    _collectionViewL.delegate = self;
    _collectionViewL.backgroundColor = bg_color;
    [_collectionViewL registerClass:[MonthCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:_collectionViewL];
    
    _collectionViewM = [[UICollectionView alloc] initWithFrame:CGRectMake(selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    _collectionViewM.dataSource = self;
    _collectionViewM.delegate = self;
    _collectionViewM.backgroundColor = bg_color;
    [_collectionViewM registerClass:[MonthCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:_collectionViewM];
    
    _collectionViewR = [[UICollectionView alloc] initWithFrame:CGRectMake(2 * selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    _collectionViewR.dataSource = self;
    _collectionViewR.delegate = self;
    _collectionViewR.backgroundColor = bg_color;
    [_collectionViewR registerClass:[MonthCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:_collectionViewR];

}
#pragma mark delegate  and   datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42; // 7 * 6
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionViewM) {
        MonthCollectionViewCell * cell = (MonthCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSInteger str = [cell.todayLabel.text integerValue];
        NSDate * d = [NSDate date];
        if (cell.imgView.image == nil) {
            if (str < [d dateDay]) {
                //没有数据
                NSNotification *notify = [[NSNotification alloc] initWithName:@"MonthScrollView.NoResult" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notify];
            }else{
               GFCalendarMonth *monthInfo = self.monthArray[1];
               NSCalendar * calendar = [NSCalendar currentCalendar];
               NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:monthInfo.monthDate];
               components.day = str+1;
               NSDate * date = [calendar dateFromComponents:components];
               NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
               [userInfo setObject:date forKey:@"select_day"];
               NSNotification *notify = [[NSNotification alloc] initWithName:@"MonthScrollView.SelectedDay.tiao" object:nil userInfo:userInfo];
               [[NSNotificationCenter defaultCenter] postNotification:notify];
            }
        }else{
            GFCalendarMonth *monthInfo = self.monthArray[1];
            NSCalendar * calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:monthInfo.monthDate];
            components.day = str+1;
            NSDate * date = [calendar dateFromComponents:components];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            [userInfo setObject:date forKey:@"select_day"];
            NSNotification *notify = [[NSNotification alloc] initWithName:@"MonthScrollView.SelectedDay" object:nil userInfo:userInfo];
            [[NSNotificationCenter defaultCenter] postNotification:notify];
        }
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MonthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 0.3;
    if (collectionView == _collectionViewL) {
        
        GFCalendarMonth *monthInfo = self.monthArray[0];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.todayLabel.textColor = [UIColor darkTextColor];
            
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.todayCircle.backgroundColor = [UIColor redColor];
                    cell.todayLabel.textColor = [UIColor whiteColor];
                } else {
                    cell.todayCircle.backgroundColor = [UIColor clearColor];
                }
            } else {
                cell.todayCircle.backgroundColor = [UIColor clearColor];
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            int totalDaysOflastMonth = [self.monthArray[3] intValue];
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
        }
        
        cell.userInteractionEnabled = NO;
        
    }
    else if (collectionView == _collectionViewM) {
        
        GFCalendarMonth *monthInfo = self.monthArray[1];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.todayLabel.textColor = [UIColor darkTextColor];
            cell.userInteractionEnabled = YES;
            //图片
            UserNoteData * userNoteData = [[UserNoteData alloc]init];
            for (NSInteger i = 1; i<=monthInfo.totalDays; i++) {
                NSString * day = [NSString stringWithFormat:@"%ld年%ld月%ld日",monthInfo.year,monthInfo.month,i];
                
                //解档
                NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
                NSString *filePath = [path stringByAppendingPathComponent:day];
                userNoteData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                if (userNoteData != nil) {
                    if (indexPath.row - firstWeekday + 1 == i) {
                        cell.imgView.image = userNoteData.result;
                    }
                }else{
                }
            }
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.todayCircle.backgroundColor = [UIColor redColor];
                    cell.todayLabel.textColor = [UIColor whiteColor];
                } else {
                    cell.todayCircle.backgroundColor = [UIColor clearColor];
                }
            } else {
                cell.todayCircle.backgroundColor = [UIColor clearColor];
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            GFCalendarMonth *lastMonthInfo = self.monthArray[0];
            NSInteger totalDaysOflastMonth = lastMonthInfo.totalDays;
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            cell.userInteractionEnabled = NO;
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
            cell.userInteractionEnabled = NO;
        }
        if(indexPath.row==0||indexPath.row==6||indexPath.row==7||indexPath.row==13||indexPath.row==14||indexPath.row==20||indexPath.row==21||indexPath.row==27||indexPath.row==28||indexPath.row==34||indexPath.row==35||indexPath.row==41) {
            cell.backgroundColor = RGB(236, 228, 254, 1);
        }
    }
    else if (collectionView == _collectionViewR) {
        
        GFCalendarMonth *monthInfo = self.monthArray[2];
        NSInteger firstWeekday = monthInfo.firstWeekday;
        NSInteger totalDays = monthInfo.totalDays;
        
        // 当前月
        if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
            
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
            cell.todayLabel.textColor = [UIColor darkTextColor];
            
            // 标识今天
            if ((monthInfo.month == [[NSDate date] dateMonth]) && (monthInfo.year == [[NSDate date] dateYear])) {
                if (indexPath.row == [[NSDate date] dateDay] + firstWeekday - 1) {
                    cell.todayCircle.backgroundColor = [UIColor redColor];
                    cell.todayLabel.textColor = [UIColor whiteColor];
                } else {
                    cell.todayCircle.backgroundColor = [UIColor clearColor];
                }
            } else {
                cell.todayCircle.backgroundColor = [UIColor clearColor];
            }
            
        }
        // 补上前后月的日期，淡色显示
        else if (indexPath.row < firstWeekday) {
            GFCalendarMonth *lastMonthInfo = self.monthArray[1];
            NSInteger totalDaysOflastMonth = lastMonthInfo.totalDays;
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", totalDaysOflastMonth - (firstWeekday - indexPath.row) + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
        } else if (indexPath.row >= firstWeekday + totalDays) {
            cell.todayLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday - totalDays + 1];
            cell.todayLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            cell.todayCircle.backgroundColor = [UIColor clearColor];
        }
        
        cell.userInteractionEnabled = NO;
        
    }
    
    return cell;
    
}
#pragma mark UIscrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self) {
        return;
    }
    
    // 向右滑动
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *previousDate = [_currentMonthDate previousMonthDate];
        
        // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
        GFCalendarMonth *currentMothInfo = self.monthArray[0];
        GFCalendarMonth *nextMonthInfo = self.monthArray[1];
        
        
        GFCalendarMonth *olderNextMonthInfo = self.monthArray[2];
        
        // 复用 GFCalendarMonth 对象
        olderNextMonthInfo.totalDays = [previousDate totalDaysInMonth];
        olderNextMonthInfo.firstWeekday = [previousDate firstWeekDayInMonth];
        olderNextMonthInfo.year = [previousDate dateYear];
        olderNextMonthInfo.month = [previousDate dateMonth];
        GFCalendarMonth *previousMonthInfo = olderNextMonthInfo;
        
        NSNumber *prePreviousMonthDays = [self previousMonthDaysForPreviousDate:[_currentMonthDate previousMonthDate]];
        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        [self.monthArray addObject:currentMothInfo];
        [self.monthArray addObject:nextMonthInfo];
        [self.monthArray addObject:prePreviousMonthDays];
        
    }
    // 向左滑动
    else if (scrollView.contentOffset.x > self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate nextMonthDate];
        NSDate *nextDate = [_currentMonthDate nextMonthDate];
        
        // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
        GFCalendarMonth *previousMonthInfo = self.monthArray[1];
        GFCalendarMonth *currentMothInfo = self.monthArray[2];
        
        
        GFCalendarMonth *olderPreviousMonthInfo = self.monthArray[0];
        
        NSNumber *prePreviousMonthDays = [[NSNumber alloc] initWithInteger:olderPreviousMonthInfo.totalDays]; // 先保存 olderPreviousMonthInfo 的月天数
        
        // 复用 GFCalendarMonth 对象
        olderPreviousMonthInfo.totalDays = [nextDate totalDaysInMonth];
        olderPreviousMonthInfo.firstWeekday = [nextDate firstWeekDayInMonth];
        olderPreviousMonthInfo.year = [nextDate dateYear];
        olderPreviousMonthInfo.month = [nextDate dateMonth];
        GFCalendarMonth *nextMonthInfo = olderPreviousMonthInfo;

        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        [self.monthArray addObject:currentMothInfo];
        [self.monthArray addObject:nextMonthInfo];
        [self.monthArray addObject:prePreviousMonthDays];

        
    }
    
    [_collectionViewM reloadData]; // 中间的 collectionView 先刷新数据
    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    [_collectionViewL reloadData]; // 最后两边的 collectionView 也刷新数据
    [_collectionViewR reloadData];
    
    // 发通知，更改当前月份标题
    GFCalendarMonth *currentMonthInfo = self.monthArray[1];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.year] forKey:@"now_year"];
    [userInfo setObject:[[NSNumber alloc] initWithInteger:currentMonthInfo.month] forKey:@"now_month"];
    NSNotification *notify = [[NSNotification alloc] initWithName:@"MonthScrollView.ChangeCalendarHeaderNotification" object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
    
}
@end
