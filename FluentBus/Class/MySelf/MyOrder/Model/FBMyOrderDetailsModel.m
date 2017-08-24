//
//  FBMyOrderDetailsModel.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/13.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBMyOrderDetailsModel.h"
#import "FBTicketDetailListModel.h"
#import "FBNeedListModel.h"
@implementation FBMyOrderDetailsModel
+(void)userOrderDetailsOrderID:(NSString *)orderID Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    [OCNetworkingTool POSTWithUrl:userOrderDetails() withParams:@{@"orderId":orderID} success:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        DBLog(@"dic ==== %@",dic);
        
        FBMyOrderDetailsModel * model = [FBMyOrderDetailsModel yy_modelWithDictionary:[dic objectForKey:@"data"]];
#pragma mark - 后面有可能要修改进入地图的模式。在这添加数据
        //显示余票的信息
        FBTicketDetailListModel * ticketListModel = [FBTicketDetailListModel yy_modelWithDictionary:[dic objectForKey:@"data"]];
        
        //仅仅显示时间
        FBNeedListModel * needListModel = [[FBNeedListModel alloc]init];
        needListModel.startStation = model.staName;
        needListModel.endStation = model.endName;
        needListModel.stime = model.time;
        needListModel.mprice = [NSString stringWithFormat:@"%.2f",[model.orderDisAmount floatValue] / 100.0];
        needListModel.rid = model.routeId;
        needListModel.ticketTypeName = model.productTypeName;
        
        NSDictionary * seccessDic = @{@"FBMyOrderDetailsModel":model,@"FBTicketDetailListModel":ticketListModel,@"FBNeedListModel":needListModel};
        seccess(seccessDic);
    } fail:^(NSError *error) {
        fail(@"数据请求失败");
    }];
    
   }
@end
