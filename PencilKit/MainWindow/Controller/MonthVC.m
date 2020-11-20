//
//  MonthVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/27.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MonthVC.h"
#import "MonthView.h"
@interface MonthVC ()

@end

@implementation MonthVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    MonthView * monthView = [[MonthView alloc]initWithFrame:self.view.bounds];
    monthView.backgroundColor = bg_color;
    [self.view addSubview:monthView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
