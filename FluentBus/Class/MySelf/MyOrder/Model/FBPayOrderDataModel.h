//
//  FBPayOrderDataModel.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBPayOrderDataModel : NSObject
@property (nonatomic,copy) NSString * orderId;/**<订单Id*/
@property (nonatomic,copy) NSString * serialId;/**<支付流水ID*/
@end
