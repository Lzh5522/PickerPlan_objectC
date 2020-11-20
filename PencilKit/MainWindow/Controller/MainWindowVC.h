//
//  MainWindowVC.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MainWindowVCDelegate <NSObject>

-(void)handleBtnAction;

@end
@interface MainWindowVC : UITabBarController
@property(nonatomic,strong) Canvas * canvas;
@property(nonatomic,assign) NSInteger count;

@end

NS_ASSUME_NONNULL_END
