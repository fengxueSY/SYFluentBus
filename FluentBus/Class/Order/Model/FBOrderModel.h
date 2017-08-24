//
//  FBOrderModel.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/6.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBOrderModel : NSObject
//详细列表
@property (nonatomic,copy) NSArray * products;/**<产品信息实体数组*/
@property (nonatomic,copy) NSString * putime;/**<全程用时（分钟）*/
@property (nonatomic,copy) NSString * ralen;/**<全程距离（米）*/
@property (nonatomic,copy) NSString * rid;/**<线路ID*/
@property (nonatomic,strong) NSArray * stations;/**<站点集合，站点顺序与数组顺序一致*/

//获取所有数据
+(void)getOrderListParameter:(id)parameter Success:(void(^)(id successed))seccess Fail:(void(^)(id failed))fail;
//模糊列表
@property (nonatomic,copy) NSString * stationId;
@property (nonatomic,copy) NSString * name;

+(void)queryStationName:(NSDictionary *)stationName Success:(void(^)(id successed))seccess Fail:(void(^)(id failed))fail;

//搜索
+(void)searchOrderListParameter:(id)parameter Success:(void(^)(id successed))seccess Fail:(void(^)(id failed))fail;
@end
