//
//  FBRefundByOrderModel.m
//  FluentBus
//
//  Created by 666GPS on 2017/2/14.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBRefundByOrderModel.h"

@implementation FBRefundByOrderModel
+(void)getRefundByOrderId:(NSString *)orderId Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    [OCNetworkingTool POSTWithUrl:getRefundByOrderId() withParams:@{@"orderId":orderId} success:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] == 200) {
            if ([dic[@"data"] allKeys].count > 0) {
                FBRefundByOrderModel * model = [FBRefundByOrderModel yy_modelWithDictionary:dic[@"data"]];
                seccess(model);
            }else{
                fail(@"获取信息失败");
            }
        }else{
           fail(@"获取信息失败");
        }
    } fail:^(NSError *error) {
        fail(@"获取信息失败,请检查网络");
    }];
}
@end
