//
//  MenuView.h
//  PencilKit
//
//  Created by 雷源 on 2020/10/25.
//  Copyright © 2020 雷源. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * table;
@end

NS_ASSUME_NONNULL_END
