//
//  FBApplyForRefundFirstView.m
//  FluentBus
//
//  Created by 666GPS on 2017/2/8.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBApplyForRefundFirstView.h"

@implementation FBApplyForRefundFirstView
-(void)setDetailsModel:(FBMyOrderDetailsModel *)detailsModel{
    self.startLabel.text = detailsModel.staName;
    self.endLabel.text = detailsModel.endName;
    self.allTimeLabel.text = [NSString stringWithFormat:@"约%.0f分钟",[detailsModel.putime floatValue]];
    self.vLabel.text = [NSString stringWithFormat:@"约%.2f公里",[detailsModel.ralen floatValue] / 1000];
    self.comLabel.text = [NSString stringWithFormat:@"途径:%@",detailsModel.rdesc];
}
@end
