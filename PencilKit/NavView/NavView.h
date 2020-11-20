//
//  NavView.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/22.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanlendarToolView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol NavigationViewDelegate <NSObject>
-(void)handleCanlenderToolAction:(NSInteger)tag;
-(void)handleBtnAction:(UIButton *)btn;

@end
@interface NavView : UIView
@property(nonatomic,strong) UIButton * menuBtn;
@property(nonatomic,strong) UIButton * shareBtn;
@property(nonatomic,strong) UIButton * canlendarBtn;
@property(nonatomic,strong) UIButton * pkToolBtn;
@property(nonatomic,strong) UIButton * addBtn;
@property(nonatomic,strong) UIButton * okBtn;
@property(nonatomic,strong) CanlendarToolView * canlenderToolView;
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,weak) id <NavigationViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
