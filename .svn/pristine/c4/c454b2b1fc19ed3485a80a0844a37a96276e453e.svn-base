//
//  FBMyOrderDetailsUpView.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMyOrderDetailsUpView.h"

@implementation FBMyOrderDetailsUpView
-(void)setDetailsModel:(FBMyOrderDetailsModel *)detailsModel{
    self.validityLabel.text = [NSString stringWithFormat:@"%@ %@",[[PublicMethod getTimeString_13:detailsModel.validDate] componentsSeparatedByString:@" "][0],[NSString stringWithFormat:@"共%@天",detailsModel.dayCount]];
    self.startLabel.text = detailsModel.staName;
    self.endLabel.text = detailsModel.endName;
    self.carTimeLabel.text = detailsModel.time;
//    [self.moneyLabel.layer setBorderColor:UIColorFromRGB(0xff4d64).CGColor];
//    [self.moneyLabel.layer setBorderWidth:0.8];
    self.moneyLabel.textColor = UIColorFromRGB(0xff4d64);
    
    //zjh
    if (StringNotNilAndNull(detailsModel.productTypeName)) {
        
        NSString *text = [NSString stringWithFormat:@" %@ ",detailsModel.productTypeName];
        self.moneyLabel = [PublicMethod getAttributedTextWithSrting:text AndLabel:self.moneyLabel];
        
    }else{
        self.moneyLabel = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:self.moneyLabel];
    }
    
    self.startOnlyLabel.text = detailsModel.upStationName;
    self.timeLabel.text = [NSString stringWithFormat:@"约%@分钟",detailsModel.putime];
    self.distanceLabel.text = [NSString stringWithFormat:@"约%.2f公里",[detailsModel.ralen floatValue] / 1000];
    self.passByLabel.text = [NSString stringWithFormat:@"途径:%@",detailsModel.rdesc];
}
@end
