//
//  FBMyTicketCell.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMyTicketCell.h"

@implementation FBMyTicketCell
+(instancetype)cellTableView:(UITableView *)tableView{
    static NSString * cellID = @"ID";
    FBMyTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:0]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [UIView setViewCorner:_ticketTypeLb cornerRadius:2 borderWidth:1 colorRGB:(0xff4d64)];
}

-(void)setModel:(FBTicketDetailListModel *)model
{
    _model = model;
    
    [self.calendarButton addTarget:self action:@selector(calendarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _startAddressLb.text = model.staName;
    _endAddressLb.text = model.endName;
    _timeLB.text = model.classTime;
    _upStationLB.text = model.upStationName;
    _carPlatNo.text = model.platNo;
    _visibleDataLB.text = [NSString stringWithFormat:@"%@ 共%@天",model.validDate,model.dayCount];
    
    if (StringNotNilAndNull(model.productTypeName)) {
        
        NSString *text = [NSString stringWithFormat:@" %@ ",model.productTypeName];
        _ticketTypeLb = [PublicMethod getAttributedTextWithSrting:text AndLabel:_ticketTypeLb];
        
    }else{
        _ticketTypeLb = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:_ticketTypeLb];
    }
    
}

//点击地图按钮
- (IBAction)onClickMapBtn:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(showMap:)]) {
        
        [_delegate showMap:_model];
    }
}

//点击日历按钮
-(void)calendarButtonAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(showCalendar:)]) {
        
        [_delegate showCalendar:_model.dateList];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
