//
//  FBSearchTableView.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBSearchTableView.h"
#import "FBSearchTableViewCell.h"

@implementation FBSearchTableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}
-(void)reloadInTableView{
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"ID";
    FBSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FBSearchTableViewCell" owner:self options:0]lastObject];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    FBOrderModel * model = _dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FBOrderModel * model = _dataArray[indexPath.row];
    if (_delegate) {
        [_delegate chooseItemText:model];
    }
}
@end
