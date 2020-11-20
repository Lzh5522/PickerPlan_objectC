//
//  ShareVC.m
//  PencilKit
//
//  Created by 雷源 on 2020/11/11.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "ShareVC.h"
#import "secondCell.h"
@interface ShareVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.tableFooterView = [UIView new];
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        _table.scrollEnabled = NO;
        [_table registerClass:[secondCell class] forCellReuseIdentifier:@"secondCell"];
    }
    return _table;
}
#pragma mark delegate datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }
    else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    secondCell * cell = [[secondCell alloc]init];
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:@"firstCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
                cell.imgView.image = [UIImage imageNamed:@"Recent Contacts"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
                cell.imgView.image = [UIImage imageNamed:@"Recent Apps"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            default:
                break;
        }
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:@"action_menu"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else if (indexPath.section == 1){
        return 130;
    }else{
        return 255;
    }
}
@end
