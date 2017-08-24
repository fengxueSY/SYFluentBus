//
//  FBMyOrderDetailsRefundSuccessView.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/18.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBRefundByOrderModel.h"


@interface FBMyOrderDetailsRefundSuccessView : UIView
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *refundSuccessLabel;
@property (nonatomic,strong) FBRefundByOrderModel * refundByOrderModel;
@end
