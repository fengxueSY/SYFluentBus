//
//  FBResumeModel.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/4.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBResumeModel.h"

@implementation FBResumeModel
+(void)getUserInfoSuccess:(void (^)(id))success Fail:(void (^)(id))fail{
    [OCNetworkingTool POSTWithUrl:getUserInfo() withParams:@{@"id":[UserInfo userInfoWithUserDefaults].userId} success:^(id responseObject) {
        DBLog(@"-----  %@",responseObject);
        NSDictionary * dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"data"]allKeys].count > 0 && [[dic objectForKey:@"code"] integerValue] == 200) {
            FBResumeModel * model = [FBResumeModel yy_modelWithDictionary:[dic objectForKey:@"data"]];
            success(model);
        }else{
            fail([dic objectForKey:@"message"]);
        }
    } fail:^(NSError *error) {
        DBLog(@"------ error   %@",error);
        fail(@"网络请求失败，请重试");
    }];
}
@end
