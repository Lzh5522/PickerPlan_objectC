//
//  MenuView.m
//  PencilKit
//
//  Created by 雷源 on 2020/10/25.
//  Copyright © 2020 雷源. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.table];
    }
    return self;
}
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.tableFooterView = [UIView new];
        _table.backgroundColor = [UIColor whiteColor];
        _table.showsVerticalScrollIndicator = NO;
        _table.scrollEnabled = NO;
    }
    return _table;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 7;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Large Title";
                cell.textLabel.font = [UIFont boldSystemFontOfSize:30];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
//                typedef NS_ENUM(NSInteger, UITableViewCellAccessoryType) {
//                    UITableViewCellAccessoryNone,                                                      // don't show any accessory view
//                    UITableViewCellAccessoryDisclosureIndicator,                                       // regular chevron. doesn't track
//                    UITableViewCellAccessoryDetailDisclosureButton API_UNAVAILABLE(tvos),                 // info button w/ chevron. tracks
//                    UITableViewCellAccessoryCheckmark,                                                 // checkmark. doesn't track
//                    UITableViewCellAccessoryDetailButton API_AVAILABLE(ios(7.0))  API_UNAVAILABLE(tvos) // info button. tracks
                break;
            case 4:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                cell.detailTextLabel.text = @"SubTitle";
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Section Heading";
                cell.textLabel.font = [UIFont boldSystemFontOfSize:24];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
//                typedef NS_ENUM(NSInteger, UITableViewCellAccessoryType) {
//                    UITableViewCellAccessoryNone,                                                      // don't show any accessory view
//                    UITableViewCellAccessoryDisclosureIndicator,                                       // regular chevron. doesn't track
//                    UITableViewCellAccessoryDetailDisclosureButton API_UNAVAILABLE(tvos),                 // info button w/ chevron. tracks
//                    UITableViewCellAccessoryCheckmark,                                                 // checkmark. doesn't track
//                    UITableViewCellAccessoryDetailButton API_AVAILABLE(ios(7.0))  API_UNAVAILABLE(tvos) // info button. tracks
                break;
            case 4:
                cell.imageView.image = [UIImage imageNamed:@"Symbol"];
                cell.textLabel.text = @"Title";
                cell.detailTextLabel.text = @"SubTitle";
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
                break;
            default:
                break;
        }
    }else{
        cell.textLabel.text = @"Section Heading";
        cell.textLabel.font = [UIFont boldSystemFontOfSize:24];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                return 60;
                break;
            case 1:
                return 44;
                break;
            case 2:
                return 44;
                break;
            case 3:
                return 44;
                break;
            case 4:
                return 44;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                return 60;
                break;
            case 1:
                return 44;
                break;
            case 2:
                return 44;
                break;
            case 3:
                return 44;
                break;
            case 4:
                return 44;
                break;
            default:
                break;
        }
    }else{
        return 44;
    }
    return 0;
}
@end
