//
//  TimeVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/13.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "TimeVC.h"
#import "YearDetailCell.h"
#import "NSDate+Calendar.h"
#import "MonthModel.h"
#define topPD 222
#define bottomPD 96
#define leftPD 227
#define rightPD 227
#define cellPadding 10
@interface TimeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UICollectionView * collectionViewL;
@property(nonatomic,strong) UICollectionView * collectionViewM;
@property(nonatomic,strong) UICollectionView * collectionViewR;
@property(nonatomic,strong) UIScrollView * yearScrollView;
@property(nonatomic,strong) UILabel * yearLabel;
@end

@implementation TimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = bg_color;
    _arr = [NSMutableArray arrayWithCapacity:3];
    NSDate * date = [NSDate date];
    _arr = [date getThreeYearArray:date.dateYear];
    _currentDate = [NSDate date];
    [self.view addSubview:self.yearLabel];
    [self setUpUI];
    
}
-(void)setUpUI{
    /*
     scrollView
     */
    _yearScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topPD, ScreenW, 516)];
    _yearScrollView.delegate = self;
    _yearScrollView.showsVerticalScrollIndicator = NO;
    _yearScrollView.showsHorizontalScrollIndicator = NO;
    _yearScrollView.pagingEnabled = YES;
    _yearScrollView.bounces = NO;
    _yearScrollView.backgroundColor = bg_color;
    _yearScrollView.contentSize = CGSizeMake(ScreenW+607*2, 0);
    _yearScrollView.contentOffset = CGPointMake(0, 0);
    /*
     layout
     */
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((740-cellPadding*5)/4.0, (516-cellPadding*4)/3.0);
    layout.minimumLineSpacing = cellPadding;
    layout.minimumInteritemSpacing = cellPadding;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    /*
     left
     */
    _collectionViewL = [[UICollectionView alloc]initWithFrame:CGRectMake(-607, 0, 740, 516) collectionViewLayout:layout];
    _collectionViewL.delegate = self;
    _collectionViewL.dataSource = self;
    _collectionViewL.backgroundColor = bg_color;
    [_collectionViewL registerClass:[YearDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    _collectionViewL.scrollEnabled = NO;
    _collectionViewL.layer.borderColor = [UIColor grayColor].CGColor;
    _collectionViewL.layer.borderWidth = 0.5;
    _collectionViewL.layer.cornerRadius = 10;
    _collectionViewL.layer.masksToBounds = YES;
    [self.yearScrollView addSubview:_collectionViewL];
    /*
     middle
     */
    _collectionViewM = [[UICollectionView alloc]initWithFrame:CGRectMake(227, 0, 740, 516) collectionViewLayout:layout];
    _collectionViewM.delegate = self;
    _collectionViewM.dataSource = self;
    _collectionViewM.backgroundColor = bg_color;
    [_collectionViewM registerClass:[YearDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    _collectionViewM.scrollEnabled = NO;
    _collectionViewM.layer.borderColor = [UIColor grayColor].CGColor;
    _collectionViewM.layer.borderWidth = 0.5;
    _collectionViewM.layer.cornerRadius = 10;
    _collectionViewM.layer.masksToBounds = YES;
    [self.yearScrollView addSubview:_collectionViewM];
    /*
     right
     */
    _collectionViewR = [[UICollectionView alloc]initWithFrame:CGRectMake(1061, 0, 740, 516) collectionViewLayout:layout];
    _collectionViewR.delegate = self;
    _collectionViewR.dataSource = self;
    _collectionViewR.backgroundColor = bg_color;
    [_collectionViewR registerClass:[YearDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    _collectionViewR.scrollEnabled = NO;
    _collectionViewR.layer.borderColor = [UIColor grayColor].CGColor;
    _collectionViewR.layer.borderWidth = 0.5;
    _collectionViewR.layer.cornerRadius = 10;
    _collectionViewR.layer.masksToBounds = YES;
    [self.yearScrollView addSubview:_collectionViewR];
    /*
     UI
     */
    [self.view addSubview:self.yearScrollView];
}
#pragma mark UIScrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    /*
     向下
     */
    
    if (scrollView.contentOffset.x < 740) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:_currentDate];
        components.year -= 1;
        components.day = 15;
        components.month = 1;
        _currentDate = [calendar dateFromComponents:components];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        [userInfo setObject:[[NSNumber alloc] initWithInteger:[_currentDate dateYear]] forKey:@"year"];
        NSNotification *notify = [[NSNotification alloc] initWithName:@"YearVC.ChangeCalendarHeaderNotification" object:nil userInfo:userInfo];
        [[NSNotificationCenter defaultCenter] postNotification:notify];
        _arr = [_currentDate getThreeYearArray:_currentDate.dateYear];
        
    }
    /*
     向上
     */
    else if (scrollView.contentOffset.x > 740) {
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:_currentDate];
        components.year += 1;
        components.day = 15;
        components.month = 1;
        _currentDate = [calendar dateFromComponents:components];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        [userInfo setObject:[[NSNumber alloc] initWithInteger:[_currentDate dateYear]] forKey:@"year"];
        NSNotification *notify = [[NSNotification alloc] initWithName:@"TimeVC.ChangeCalendarHeaderNotification" object:nil userInfo:userInfo];
        [[NSNotificationCenter defaultCenter] postNotification:notify];
        _arr = [_currentDate getThreeYearArray:_currentDate.dateYear];
       
    }
    //发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeVC.detailCellRefresh" object:nil];
    [_collectionViewM reloadData];
    _yearScrollView.contentOffset = CGPointMake(0, 0);
    [_collectionViewL reloadData];
    [_collectionViewR reloadData];
    //更改标题
    
}
#pragma mark UIcollectionView delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(cellPadding, cellPadding, cellPadding, cellPadding);//分别为上、左、下、右
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YearDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (collectionView == _collectionViewM) {
        NSMutableArray * arr = _arr[1];
        cell.currentDate = arr[indexPath.row];
        
        
    }
    else if(collectionView == _collectionViewL){
        NSMutableArray * arr = _arr[0];
        cell.currentDate = arr[indexPath.row];
    }
    else if(collectionView == _collectionViewR){
        NSMutableArray * arr = _arr[2];
        cell.currentDate = arr[indexPath.row];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * arr = self.arr[1];
    NSDate * currDate = arr[indexPath.row];
    NSMutableDictionary * userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
    [userInfo setObject:currDate forKey:@"selectedDate"];
    NSNotification * notify = [[NSNotification alloc]initWithName:@"YearVC.SelectedMonth" object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
}
-(NSMutableArray *)yearArr{
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
        NSDate * date = [NSDate date];
        NSDate * januaryDayOne = [date getJanuaryDayOne];
        for (int i = 0; i < 12; i++) {
            [_yearArr addObject:januaryDayOne];
            januaryDayOne = [januaryDayOne nextMonthDate];
        }
    }
    return _yearArr;
}
-(UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(227, 96, 520, 148)];
        _yearLabel.font = [UIFont boldSystemFontOfSize:200];
        _yearLabel.text = [NSString stringWithFormat:@"%ld",[self.currentDate dateYear]];
        _yearLabel.textColor = RGB(152, 138, 185, 1);
    }
    return _yearLabel;
}
@end
