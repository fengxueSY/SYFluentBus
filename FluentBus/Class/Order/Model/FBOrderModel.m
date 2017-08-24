//
//  FBOrderModel.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/6.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBOrderModel.h"
#import "FBOrderProductsModel.h"
#import "FBOrderProductsShiftsModel.h"
@implementation FBOrderModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"stationId" : @"id"};
}
+(void)getOrderListParameter:(id)parameter Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    NSDictionary * sendDic = @{@"PageIndex":parameter,@"PageSize":[NSNumber numberWithInt:20]};
    [OCNetworkingTool POSTWithUrl:getOrderList() withParams:sendDic success:^(id responseObject) {
        DBLog(@"%@",responseObject);
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * dataDic = [dic objectForKey:@"data"];
        if ([[dic objectForKey:@"code"] integerValue] == 200 && [dataDic allKeys].count > 0) {
            NSArray * arralDataList = [dataDic objectForKey:@"dataList"];
            if (arralDataList.count > 0) {
                NSMutableArray * dataArray = [[NSMutableArray alloc]init];
                [arralDataList enumerateObjectsUsingBlock:^(NSDictionary * dicList, NSUInteger idx, BOOL * _Nonnull stop) {
                    FBOrderModel * model = [FBOrderModel yy_modelWithDictionary:dicList];
                    NSMutableArray * prodousArray = [[NSMutableArray alloc]init];
                    [model.products enumerateObjectsUsingBlock:^(NSDictionary * productsDic, NSUInteger idx, BOOL * _Nonnull stop) {
                        FBOrderProductsModel * prodousModel = [FBOrderProductsModel yy_modelWithDictionary:productsDic];
                        NSMutableArray * shiftsAarray = [[NSMutableArray alloc]init];
                        [prodousModel.shifts enumerateObjectsUsingBlock:^(NSDictionary * shifsDic, NSUInteger idx, BOOL * _Nonnull stop) {
                            FBOrderProductsShiftsModel * shiftsModel = [FBOrderProductsShiftsModel yy_modelWithDictionary:shifsDic];
                            shiftsModel.stationRid = model.rid;
                            shiftsModel.startStation = model.stations[0];
                            shiftsModel.endStation = model.stations.lastObject;
                            shiftsModel.startTime = prodousModel.startDate;
                            shiftsModel.endTime = prodousModel.downTime;
                            shiftsModel.moneyPrice = prodousModel.price;
                            shiftsModel.stationPid = prodousModel.pid;
                            shiftsModel.productName = prodousModel.productName;
                            shiftsModel.productTypeName = prodousModel.typeName;
                            shiftsModel.days = prodousModel.days;
                            [shiftsAarray addObject:shiftsModel];
                        }];
                        prodousModel.shifts = shiftsAarray;
                        [prodousArray addObject:prodousModel];
                    }];
                    model.products = prodousArray;
                    [dataArray addObject:model];
                }];
                seccess(dataArray);
            }else{
                fail(@"暂无数据信息");
            }
            DBLog(" *************************  %@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        }else{
            fail([dic objectForKey:@"message"]);
        }
    } fail:^(NSError *error) {
        fail(@"网络请求失败,请重试");
    }];
}
//模糊搜索
+(void)queryStationName:(NSDictionary *)stationName Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    [OCNetworkingTool POSTWithUrl:queryStation() withParams:stationName success:^(id responseObject) {
        DBLog(@"---------%@",responseObject);
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSArray * dataArray = [dic objectForKey:@"data"];
        if ([[dic objectForKey:@"code"] integerValue] == 200 && dataArray.count > 0) {
            NSMutableArray * array = [[NSMutableArray alloc]init];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * numberDic, NSUInteger idx, BOOL * _Nonnull stop) {
                FBOrderModel * model = [FBOrderModel yy_modelWithDictionary:numberDic];
                [array addObject:model];
            }];
            seccess(array);
        }else{
            fail(@"暂无数据");
        }
    } fail:^(NSError *error) {
        fail(@"网络请求错误，请重新请求");
    }];
}
//搜索
+(void)searchOrderListParameter:(id)parameter Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    [OCNetworkingTool POSTWithUrl:searchOrderList() withParams:parameter success:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSArray * dataArray = [dic objectForKey:@"data"];
        if ([[dic objectForKey:@"code"] integerValue] == 200 && dataArray.count > 0) {
            NSMutableArray * dataArrayReturn = [[NSMutableArray alloc]init];
            [dataArray enumerateObjectsUsingBlock:^(NSDictionary * dicList, NSUInteger idx, BOOL * _Nonnull stop) {
                FBOrderModel * model = [FBOrderModel yy_modelWithDictionary:dicList];
                NSMutableArray * prodousArray = [[NSMutableArray alloc]init];
                [model.products enumerateObjectsUsingBlock:^(NSDictionary * productsDic, NSUInteger idx, BOOL * _Nonnull stop) {
                    FBOrderProductsModel * prodousModel = [FBOrderProductsModel yy_modelWithDictionary:productsDic];
                    NSMutableArray * shiftsAarray = [[NSMutableArray alloc]init];
                    [prodousModel.shifts enumerateObjectsUsingBlock:^(NSDictionary * shifsDic, NSUInteger idx, BOOL * _Nonnull stop) {
                        FBOrderProductsShiftsModel * shiftsModel = [FBOrderProductsShiftsModel yy_modelWithDictionary:shifsDic];
                        shiftsModel.stationRid = model.rid;
                        shiftsModel.startStation = model.stations[0];
                        shiftsModel.endStation = model.stations.lastObject;
                        shiftsModel.startTime = prodousModel.startDate;
                        shiftsModel.endTime = prodousModel.downTime;
                        shiftsModel.moneyPrice = prodousModel.price;
                        shiftsModel.stationPid = prodousModel.pid;
                        shiftsModel.productName = prodousModel.productName;
                        shiftsModel.productTypeName = prodousModel.typeName;
                        shiftsModel.days = prodousModel.days;

                        [shiftsAarray addObject:shiftsModel];
                    }];
                    prodousModel.shifts = shiftsAarray;
                    [prodousArray addObject:prodousModel];
                }];
                model.products = prodousArray;
                [dataArrayReturn addObject:model];
            }];
            seccess(dataArrayReturn);
            DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        }else{
//            [MBProgressHUD showSuccess:@"暂无改站点信息，请确认站点是否正确"];
            fail(@"暂无该站点信息，请确认站点是否正确");
        }
       
    } fail:^(NSError *error) {
        DBLog(@"shibai   %@",error);
        fail(@"网络请求失败,请重试");
    }];

}
@end
