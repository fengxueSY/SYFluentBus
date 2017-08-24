//
//  OCNetworkingTool.m
//  OfficialCar
//
//  Created by 张森明 on 16/9/27.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import "OCNetworkingTool.h"

@implementation OCNetworkingTool

+ (void)GETWithUrl:(NSString *)url withParams:(id)params success:(OCSuccessCallBack)success fail:(OCFailCallBack)fail {
    
//    if (![PublicMethod isNetworkEnabled]) {
//        
//        [MBProgressHUD showError:@"网络出错!"];
//        
//        return;
//    }

    HeaderInfo *headerInfo = [HeaderInfo sharedHeaderInfo];
    
    [HYBNetworking configCommonHttpHeaders:headerInfo.headDict];
    
    [HYBNetworking getWithUrl:url refreshCache:YES params:params success:^(id response) {
        success(response);
    } fail:^(NSError *error) {
        
        fail(error);
    }];
}

+ (void)POSTWithUrl:(NSString *)url withParams:(id)params success:(OCSuccessCallBack)success fail:(OCFailCallBack)fail{
    
//    if (![PublicMethod isNetworkEnabled]) {
//        
//        [MBProgressHUD showError:@"网络出错!"];
//        return;
//    }

    HeaderInfo *headerInfo = [HeaderInfo sharedHeaderInfo];
    
    [HYBNetworking configCommonHttpHeaders:headerInfo.headDict];
    
    [HYBNetworking postWithUrl:url refreshCache:YES params:params success:^(id response) {
        if ([response[@"code"] integerValue] == 553) {
//            [MBProgressHUD showError:@"登录过期，请重新登陆！"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NSNotificationCenterClose" object:self];;
        }
        success(response);
        
    } fail:^(NSError *error) {
        
        fail(error);
        
    }];
}


@end
