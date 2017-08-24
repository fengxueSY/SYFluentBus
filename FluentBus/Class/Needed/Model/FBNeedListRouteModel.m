//
//  FBNeedListRouteModel.m
//  FluentBus
//
//  Created by 张俊辉 on 17/1/9.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBNeedListRouteModel.h"

@implementation FBNeedListRouteModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"stationId" : @"id"};
}
+(void)getAppStationLineRid:(NSString *)rid Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:rid forKey:@"rid"];
    [OCNetworkingTool POSTWithUrl:searchRoteUrl() withParams:dict success:^(id responseObject) {
        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        //请求成功拿数据
        NSDictionary * dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] == 200) {
            NSArray *array = responseObject[@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *dic in array) {
                    FBNeedListRouteModel * model = [FBNeedListRouteModel yy_modelWithDictionary:dic];
                    [modelArray addObject:model];
                }
                //拿完数据按升序排好
                NSArray *result = [modelArray sortedArrayUsingComparator:^NSComparisonResult(FBNeedListRouteModel * obj1, FBNeedListRouteModel * obj2) {
                    return [@(obj1.staindex) compare:@(obj2.staindex)]; //升序
                }];
                seccess(result);
            }
        }else{
            fail(@"数据异常");
        }
    } fail:^(NSError *error) {
        fail(@"网络请求失败");
    }];

}
@end