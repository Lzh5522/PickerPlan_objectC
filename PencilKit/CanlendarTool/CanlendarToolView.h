//
//  CanlendarToolView.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CanlendarToolDelegate <NSObject>

-(void)handleBtnClicked:(NSInteger)btnTag;

@end
@interface CanlendarToolView : UIView
@property(nonatomic,strong) UIButton * dayBtn;
@property(nonatomic,strong) UIButton * weekBtn;
@property(nonatomic,strong) UIButton * monthBtn;
@property(nonatomic,strong) UIButton * yearBtn;
@property(nonatomic,strong) UIColor * bgColor;
@property(nonatomic,strong) UIColor * selectedColor;
@property(nonatomic,strong) UIColor * titleColor;
@property(nonatomic,strong) UIColor * titleSelectedColor;
@property(nonatomic,weak) id <CanlendarToolDelegate> delegate;
-(void)btnSelectDayBtn;
@end

NS_ASSUME_NONNULL_END
