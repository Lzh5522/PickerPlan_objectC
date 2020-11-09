//
//  YearDetailCell.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/31.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "YearDetailCell.h"
#import "YearDateCell.h"
#import "MonthModel.h"
#import "NSDate+Calendar.h"
@interface YearDetailCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation YearDetailCell
static NSString *const CELLID = @"cell";
#pragma mark init
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.monthLabel];
        NSArray * arr = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
        for(NSInteger i=0;i<7;i++){
            UILabel * weekLabel = [[UILabel alloc]init];
            weekLabel.font = [UIFont boldSystemFontOfSize:15];
            weekLabel.textColor = font_color;
            weekLabel.frame = CGRectMake((self.bounds.size.width/7.0)*i, 50, (self.bounds.size.width/7.0), 20);
            weekLabel.text = arr[i];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:weekLabel];
        }
        [self addSubview:self.monthDetailCollectionView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.equalTo(70);
        make.right.equalTo(self);
        make.height.equalTo(50);
    }];
    
    _monthLabel.text = [NSString stringWithFormat:@"%ld%@",[_currentDate dateMonth],@"月"];
}
#pragma mark delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 42;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"一共有%ld天",[_currentDate totalDaysInMonth]);
        NSLog(@"第一天%ld",[_currentDate firstWeekDayInMonth]);
    }
    YearDateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    NSInteger firstWeekday = [_currentDate firstWeekDayInMonth];
    NSInteger totalDays = [_currentDate totalDaysInMonth];
    if (indexPath.row >= firstWeekday && indexPath.row < firstWeekday + totalDays) {
           cell.label.text = [NSString stringWithFormat:@"%ld", indexPath.row - firstWeekday + 1];
           cell.userInteractionEnabled = YES;
               
    }
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    return cell;
}
#pragma mark lazy
-(UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.textColor = font_color;
        _monthLabel.textAlignment = NSTextAlignmentRight;
        _monthLabel.font = [UIFont boldSystemFontOfSize:28];
    }
    return _monthLabel;
}
-(UICollectionView *)monthDetailCollectionView{
    if (!_monthDetailCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((self.bounds.size.width)/7.0, (self.bounds.size.height-70)/6.0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _monthDetailCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 70, self.bounds.size.width, self.bounds.size.height-70) collectionViewLayout:layout];
        _monthDetailCollectionView.delegate = self;
        _monthDetailCollectionView.dataSource = self;
        _monthDetailCollectionView.backgroundColor = [UIColor clearColor];
        [_monthDetailCollectionView registerClass:[YearDateCell class] forCellWithReuseIdentifier:CELLID];
        _monthDetailCollectionView.scrollEnabled = NO;
    }
    return _monthDetailCollectionView;
}
@end
