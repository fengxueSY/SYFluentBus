//
//  FBRefundByOrderModel.h
//  FluentBus
//
//  Created by 666GPS on 2017/2/14.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBRefundByOrderModel : NSObject
@property (nonatomic,copy) NSString * refundStatus;/**<退款状态(1:待审核,2:处理中,3:已退款,4:已拒绝)*/
@property (nonatomic,copy) NSString * ActualAmount;/**<应退金额*/
@property (nonatomic,copy) NSString * refundTime;/**<退款支付时间*/
@property (nonatomic,copy) NSString * refundType;/**<退款账户类型（支付类型1:原路退回,2:退回钱包）*/
@property (nonatomic,copy) NSString * amount;/**<退款订单金额*/
@property (nonatomic,copy) NSString * refuseReason;/**<退款拒绝原因*/

+(void)getRefundByOrderId:(NSString *)orderId Success:(void(^)(id successed))seccess Fail:(void(^)(id failed))fail;
@end
