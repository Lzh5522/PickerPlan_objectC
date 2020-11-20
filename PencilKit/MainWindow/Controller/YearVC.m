//
//  YearVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/31.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "YearVC.h"
#import "YearDetailCell.h"
#import "NSDate+Calendar.h"
#import "MonthModel.h"
@interface YearVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong) UICollectionView * collectionViewL;
@property(nonatomic,strong) UICollectionView * collectionViewM;
@property(nonatomic,strong) UICollectionView * collectionViewR;
@property(nonatomic,strong) UIScrollView * yearScrollView;
@end

@implementation YearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _arr = [NSMutableArray arrayWithCapacity:3];
    NSDate * date = [NSDate date];
    _arr = [date getThreeYearArray:date.dateYear];
    _currentDate = [NSDate date];
    [self setUpUI];
}
-(void)setUpUI{
    /*
     scrollView
     */
    _yearScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, ScreenW, ScreenH-navigationViewHeight)];
    _yearScrollView.delegate = self;
    _yearScrollView.showsVerticalScrollIndicator = NO;
    _yearScrollView.showsHorizontalScrollIndicator = NO;
    _yearScrollView.pagingEnabled = YES;
    _yearScrollView.bounces = NO;
    _yearScrollView.scrollEnabled = NO;
    _yearScrollView.backgroundColor = bg_color;
    _yearScrollView.contentSize = CGSizeMake(ScreenW, (ScreenH-navigationViewHeight)*3);
    _yearScrollView.contentOffset = CGPointMake(0, ScreenH-navigationViewHeight);
    /*
     layout
     */
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((ScreenW-15*5)/4.0, (ScreenH-15*4-70)/3.0);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    /*
     left
     */
    _collectionViewL = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-navigationViewHeight) collectionViewLayout:layout];
    _collectionViewL.delegate = self;
    _collectionViewL.dataSource = self;
    _collectionViewL.backgroundColor = bg_color;
    [_collectionViewL registerClass:[YearDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    _collectionViewL.scrollEnabled = NO;
    [self.yearScrollView addSubview:_collectionViewL];
    /*
     middle
     */
    _collectionViewM = [[UICollectionView alloc]initWithFrame:CGRectMake(0, ScreenH-70, ScreenW, ScreenH-70) collectionViewLayout:layout];
    _collectionViewM.delegate = self;
    _collectionViewM.dataSource = self;
    _collectionViewM.backgroundColor = bg_color;
    [_collectionViewM registerClass:[YearDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    _collectionViewM.scrollEnabled = NO;
    [self.yearScrollView addSubview:_collectionViewM];
    /*
     right
     */
    _collectionViewR = [[UICollectionView alloc]initWithFrame:CGRectMake(0, ScreenH*2-140, ScreenW, ScreenH-70) collectionViewLayout:layout];
    _collectionViewR.delegate = self;
    _collectionViewR.dataSource = self;
    _collectionViewR.backgroundColor = bg_color;
    [_collectionViewR registerClass:[YearDetailCell class] forCellWithReuseIdentifier:@"cellID"];
    _collectionViewR.scrollEnabled = NO;
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
    
    if (scrollView.contentOffset.y < self.yearScrollView.bounds.size.height) {
        
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
    else if (scrollView.contentOffset.y > self.yearScrollView.bounds.size.height) {
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:_currentDate];
        components.year += 1;
        components.day = 15;
        components.month = 1;
        _currentDate = [calendar dateFromComponents:components];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        [userInfo setObject:[[NSNumber alloc] initWithInteger:[_currentDate dateYear]] forKey:@"year"];
        NSNotification *notify = [[NSNotification alloc] initWithName:@"YearVC.ChangeCalendarHeaderNotification" object:nil userInfo:userInfo];
        [[NSNotificationCenter defaultCenter] postNotification:notify];
        _arr = [_currentDate getThreeYearArray:_currentDate.dateYear];
       
    }
    //发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YearVC.detailCellRefresh" object:nil];
    [_collectionViewM reloadData];
    _yearScrollView.contentOffset = CGPointMake(0, ScreenH-navigationViewHeight);
//    [_collectionViewL reloadData];
//    [_collectionViewR reloadData];
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
    return UIEdgeInsetsMake(15, 15, 15, 15);//分别为上、左、下、右
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YearDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (collectionView == _collectionViewM) {
        NSMutableArray * arr = _arr[1];
        cell.currentDate = arr[indexPath.row];
        
    }
    else if(collectionView == _collectionViewL){
//        NSMutableArray * arr = _arr[0];
//        cell.currentDate = arr[indexPath.row];
    }
    else if(collectionView == _collectionViewR){
//        NSMutableArray * arr = _arr[2];
//        cell.currentDate = arr[indexPath.row];
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

@end
