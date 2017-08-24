//
//  FBMapAllroundView.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/7.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBMapAllroundView.h"
#import "FBNearMapCell.h"
@implementation FBMapAllroundView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatBaseUI:frame];
    }
    return self;
}
-(void)reloadInTabelData{
    [_tableView reloadData];
}
-(void)creatBaseUI:(CGRect)frame{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
    _tableView.backgroundColor = whiteUnifyColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"ID";
    FBNearMapCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FBNearMapCell" owner:self options:0]lastObject];
    }
    XWUMapPlaceModel * model = _dataArray[indexPath.row];
    cell.adressNameLabel.text = model.addressName;
    cell.shopNameLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    if (_delegate) {
        XWUMapPlaceModel * model = _dataArray[indexPath.row];
        [_delegate chooseAddress:model];
    }
}
@end
