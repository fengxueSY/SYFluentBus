//
//  FBWeiXinPay.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/16.
//  Copyright © 2017年 yang. All rights reserved.

//

#import "FBWeiXinPay.h"
#import <WXApi.h>
#import "MyMD5.h"

@implementation FBWeiXinPay

+(void)treatWeiXinPaySerialId:(NSString *)serialId Success:(void (^)(id))seccess Fail:(void (^)(id))fail{
    [OCNetworkingTool POSTWithUrl:WeiXinPay() withParams:@{@"serialid":serialId,@"merchantid":@"100401",@"paytype":@(3)} success:^(id responseObject) {
        
        DBLog(@"%@",responseObject);
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * dataDic = [dic objectForKey:@"data"];

        //发起微信支付
        PayReq * request = [[PayReq alloc]init];
        request.partnerId = [dataDic objectForKey:@"partnerid"];
        request.prepayId= [dataDic objectForKey:@"prepayid"];
        request.package = @"Sign=WXPay";
        request.nonceStr= [dataDic objectForKey:@"noncestr"];
        request.timeStamp= [[dataDic objectForKey:@"timestamp"] intValue];
        request.sign= [dataDic objectForKey:@"sign"];
        [WXApi sendReq:request];
        seccess(@"支付成功");
    } fail:^(NSError *error) {
        fail(@"支付失败");
    }];
}
@end