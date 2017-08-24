//
//  FBTicketDetailListModel.h
//  FluentBus
//
//  Created by 张俊辉 on 17/1/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBTicketDetailListModel : NSObject
//订单ID
@property (nonatomic,copy) NSString *orderId;
//产品ID
@property (nonatomic,copy) NSString *productId;
//线路ID
@property (nonatomic,copy) NSString *routeId;
//classId
@property (nonatomic,copy) NSString *classId;
//起点站
@property (nonatomic,copy) NSString *staName;
//终点站
@property (nonatomic,copy) NSString *endName;
//运营范围（long）
@property (nonatomic,copy) NSString *validDate;
//天数(short)
@property (nonatomic,copy) NSString *dayCount;
//出行时间点
@property (nonatomic,copy) NSString *classTime;
//上车地点
@property (nonatomic,copy) NSString *upStationName;
//产品类型
@property (nonatomic,assign) NSInteger productType;
//产品类型名称
@property (nonatomic,copy) NSString *productTypeName;
//车牌
@property (nonatomic,copy) NSString *platNo;
//车票
@property (nonatomic,copy) NSString *ticket;
//途径站点
@property (nonatomic,copy) NSString *rdesc;
//距离（m）
@property (nonatomic,copy) NSString *ralen;
//全程用时(min)
@property (nonatomic,copy) NSString *putime;
//日期列表
@property (nonatomic,strong)NSArray *dateList;

@end
