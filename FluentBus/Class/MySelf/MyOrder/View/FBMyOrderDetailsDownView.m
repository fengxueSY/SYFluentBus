//
//  FBMyOrderDetailsDownView.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMyOrderDetailsDownView.h"

@implementation FBMyOrderDetailsDownView
-(void)setDetailsModel:(FBMyOrderDetailsModel *)detailsModel{
    self.orderTimeLabel.text = [PublicMethod getTimeString_13:detailsModel.createTime];
    self.orderNumberLabel.text = detailsModel.orderId;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f元",[detailsModel.orderDisAmount floatValue] / 100];
    if ([detailsModel.payStyle integerValue] == 0) {
        self.orderWayLabel.text = @"不确定";
        self.payTypeLabel.hidden = YES;
        self.orderWayLabel.hidden = YES;
    }else if ([detailsModel.payStyle integerValue] == 1){
        self.orderWayLabel.text = @"钱包";
    }else if ([detailsModel.payStyle integerValue] == 2){
        self.orderWayLabel.text = @"支付宝";
    }else if ([detailsModel.payStyle integerValue] == 3){
        self.orderWayLabel.text = @"微信";
    }else if ([detailsModel.payStyle integerValue] == 4){
        self.orderWayLabel.text = @"银联";
    }
    if ([detailsModel.orderStatus integerValue] == 0) {
        self.orderTybeLabel.text = @"待支付";
        self.orderTybeLabel.textColor = UIColorFromRGB(0xff4d64);
    }else if ([detailsModel.orderStatus integerValue] == 1){
        self.orderTybeLabel.text = @"已取消";
        self.orderTybeLabel.textColor = UIColorFromRGB(0x333333);
    }else if ([detailsModel.orderStatus integerValue] == 2){
        self.orderTybeLabel.text = @"已支付";
        self.orderTybeLabel.textColor = UIColorFromRGB(0x333333);
    }else if ([detailsModel.orderStatus integerValue] == 3){
        self.orderTybeLabel.text = @"已过期";
        self.orderTybeLabel.textColor = UIColorFromRGB(0x333333);
    }else if ([detailsModel.orderStatus integerValue] == 4){
        self.orderTybeLabel.text = @"退款中";
        self.orderTybeLabel.textColor = UIColorFromRGB(0xf3831f);
    }else if ([detailsModel.orderStatus integerValue] == 5){
        self.orderTybeLabel.text = @"已退款";
        self.orderTybeLabel.textColor = UIColorFromRGB(0xf3831f);
    }else if ([detailsModel.orderStatus integerValue] == 6){
        self.orderTybeLabel.text = @"已拒绝";
        self.orderTybeLabel.textColor = UIColorFromRGB(0xf3831f);
    }

}
@end
