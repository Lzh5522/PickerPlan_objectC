//
//  TimeVC.h
//  PencilKit
//
//  Created by 雷源 on 2020/11/13.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeVC : UIViewController
@property(nonatomic,strong) NSMutableArray * yearArr;
@property(nonatomic,strong) NSMutableArray * arr;
@property(nonatomic,strong) NSDate * currentDate;
@end

NS_ASSUME_NONNULL_END
