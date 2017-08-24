//
//  FBMyOrderCell.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMyOrderCell.h"

@implementation FBMyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.goPayButton.layer setCornerRadius:5];
    [self.cancalButton.layer setCornerRadius:5];
    
    [self.tickeType.layer setBorderColor:UIColorFromRGB(0xff4d64).CGColor];
    [self.tickeType.layer setBorderWidth:0.8];
}
-(void)setMyOrderModel:(FBMyOrderModel *)myOrderModel{
    _myOrderModel = myOrderModel;
    [self.calendarButton addTarget:self action:@selector(cancalButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.effectiveTimeLabel.text = [NSString stringWithFormat:@"%@ %@",[[PublicMethod getTimeString_13:myOrderModel.validDate] componentsSeparatedByString:@" "][0],[NSString stringWithFormat:@"共%@天",myOrderModel.dayCount]];
    
    self.startLabel.text = myOrderModel.staName;
    self.endLabel.text = myOrderModel.endName;
    self.orderNmuberLabel.text = myOrderModel.orderId;
    self.nowTimeLabel.text = myOrderModel.time;
    self.orderTimeLabel.text = [PublicMethod getTimeString_13:myOrderModel.createTime];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[myOrderModel.orderDisAmount floatValue] / 100];
    
    //zjh
    if (StringNotNilAndNull(myOrderModel.productTypeName)) {
        
        NSString *text = [NSString stringWithFormat:@" %@ ",myOrderModel.productTypeName];
        self.tickeType = [PublicMethod getAttributedTextWithSrting:text AndLabel:self.tickeType];
        
    }else{
        self.tickeType = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:self.tickeType];
    }
    
    
    self.startStationLabel.text = myOrderModel.upStationName;
    if ([myOrderModel.orderStatus integerValue] == 0) {
        self.goPayButton.hidden = NO;
        self.cancalButton.hidden = NO;
        self.payStyleLabel.text = @"待支付";
        self.payStyleLabel.textColor = UIColorFromRGB(0xff4d64);
        self.styleImageView.image = UIImageName(@"myorder_nopayment");
        [self.cancalButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.cancalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.cancalButton.layer setMasksToBounds:YES];
        [self.cancalButton.layer setBorderColor:UIColorWithRGB(220, 220, 220, 1).CGColor];
        [self.cancalButton.layer setBorderWidth:0.5];
        [self.cancalButton addTarget:self action:@selector(buttonActionCancal) forControlEvents:UIControlEventTouchUpInside];
        [self.goPayButton setTitle:@"去支付" forState:UIControlStateNormal];
        [self.goPayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.goPayButton.backgroundColor = greenUnifyColor;
        [self.goPayButton addTarget:self action:@selector(buttonActionGoPay) forControlEvents:UIControlEventTouchUpInside];
    }else if ([myOrderModel.orderStatus integerValue] == 1){
        self.payStyleLabel.text = @"已取消";
        self.payStyleLabel.textColor = UIColorFromRGB(0x333333);
        self.styleImageView.image = nil;
        self.goPayButton.hidden = YES;
        self.cancalButton.hidden = YES;
    }else if ([myOrderModel.orderStatus integerValue] == 2){
        self.payStyleLabel.text = @"已支付";
        self.payStyleLabel.textColor = UIColorFromRGB(0x333333);
        self.styleImageView.image = nil;
        self.cancalButton.hidden = YES;
#pragma mark - 申请退款按钮暂时隐藏
        self.goPayButton.hidden = NO;
        [self.goPayButton setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.goPayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.goPayButton.backgroundColor = greenUnifyColor;
        [self.goPayButton addTarget:self action:@selector(buttonActionRefund) forControlEvents:UIControlEventTouchUpInside];
    }else if ([myOrderModel.orderStatus integerValue] == 3){
        self.payStyleLabel.text = @"已过期";
        self.payStyleLabel.textColor = UIColorFromRGB(0x333333);
        self.styleImageView.image = nil;
        self.cancalButton.hidden = YES;
        self.goPayButton.hidden = YES;
    }else if ([myOrderModel.orderStatus integerValue] == 4) {
        self.payStyleLabel.text = @"退款中";
        self.payStyleLabel.textColor = UIColorFromRGB(0xf3831f);
        self.styleImageView.image = nil;
        self.styleImageView.image = UIImageName(@"myorder_tuikuan");
        self.cancalButton.hidden = YES;
        self.goPayButton.hidden = YES;
    }else if ([myOrderModel.orderStatus integerValue] == 5){
        self.payStyleLabel.text = @"退款成功";
        self.payStyleLabel.textColor = UIColorFromRGB(0x333333);
        self.styleImageView.image = nil;
        self.styleImageView.image = nil;
        self.cancalButton.hidden = YES;
        self.goPayButton.hidden = YES;
    }else if ([myOrderModel.orderStatus integerValue] == 6){
        self.payStyleLabel.text = @"退款失败";
        self.payStyleLabel.textColor = UIColorFromRGB(0x333333);
        self.styleImageView.image = nil;
        self.styleImageView.image = nil;
        self.cancalButton.hidden = YES;
        self.goPayButton.hidden = YES;
    }

}
//取消
-(void)buttonActionCancal{
    if (_delegate) {
        [_delegate cancalOrder:_myOrderModel];
    }
}
//去支付
-(void)buttonActionGoPay{
    if (_delegate) {
        [_delegate goPayOrder:_myOrderModel];
    }
}
//申请退款
-(void)buttonActionRefund{
    if (_delegate) {
        [_delegate applyForRefund:_myOrderModel];
    }
}
//显示日历
-(void)cancalButtonAction{
    if (_delegate) {
        [_delegate showCalendar:_myOrderModel.dateList];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
