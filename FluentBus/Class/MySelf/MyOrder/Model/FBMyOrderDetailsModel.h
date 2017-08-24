//
//  FBMyOrderDetailsModel.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/13.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBMyOrderDetailsModel : NSObject
@property (nonatomic,copy) NSString * classId;/**<班次id*/
@property (nonatomic,copy) NSString * createTime;/**<下单时间*/
@property (nonatomic,copy) NSString * dayCount;/**<天数*/
@property (nonatomic,copy) NSString * endName;/**<终点站*/
@property (nonatomic,copy) NSString * orderAmount;/**<订单原金额*/
@property (nonatomic,copy) NSString * orderDisAmount;/**<订单折扣后金额*/
@property (nonatomic,copy) NSString * orderId;/**<订单ID*/
@property (nonatomic,copy) NSString * orderStatus;/**<0,待支付,1:已取消,2:已支付,3:已过期,4:办理退款，5：退款成功 6：退款失败*/
@property (nonatomic,copy) NSString * payAmount;/**<支付金额*/
@property (nonatomic,copy) NSString * paySerialId;/**<支付流水ID，订单未支付的时候。可以拿去支付*/
@property (nonatomic,copy) NSString * payStyle;/**<支付类型  0 not sure 不确定, 1 wallet 钱包, 2 zhifubao 支付宝, 3 weixin 微信, 4 yinlian 银联*/
@property (nonatomic,copy) NSString * productId;/**<产品ID*/
@property (nonatomic,copy) NSString * productType;/**<产品类型1周票，2月票，3季票，4次票*/
@property (nonatomic,copy) NSString * productTypeName;/**<产品类型周票月票等名称*/

@property (nonatomic,copy) NSString * routeId;/**<线路ID*/
@property (nonatomic,copy) NSString * staName;/**<起始站*/
@property (nonatomic,copy) NSString * time;/**<出行时间点*/
@property (nonatomic,copy) NSString * upStationName;/**<上车地点*/
@property (nonatomic,copy) NSString * validDate;/**<运营范围*/
@property (nonatomic,copy) NSString * rdesc;/**<线路的描述*/
@property (nonatomic,copy) NSString * ralen;/**<总里程*/
@property (nonatomic,copy) NSString * putime;/**<总时间*/
//获取订单详情
+(void)userOrderDetailsOrderID:(NSString *)orderID Success:(void(^)(id successed))seccess Fail:(void(^)(id failed))fail;
@end
