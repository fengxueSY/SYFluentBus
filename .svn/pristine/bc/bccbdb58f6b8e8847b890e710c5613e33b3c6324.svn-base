//
//  OCNetworkingTool.h
//  OfficialCar
//
//  Created by 张森明 on 16/9/27.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  请求成功的回调
 *
 *  @param responseObject 成功后响应的内容
 */
typedef void(^OCSuccessCallBack)(id responseObject);

/**
 *  请求失败的回调
 *
 *  @param error 失败后回调的错误
 */
typedef void(^OCFailCallBack)(NSError *error);

@interface OCNetworkingTool : NSObject

@property (nonatomic, assign) NSInteger tag;
/**
 *  根据客户端类型配置Header的GET请求方法
 *
 *  @param url     URL地址
 *  @param params  参数字典
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void)GETWithUrl:(NSString *)url withParams:(id)params success:(OCSuccessCallBack)success fail:(OCFailCallBack)fail;

/**
 *  根据客户端类型配置Header的POST请求方法
 *
 *  @param url     URL地址
 *  @param params  请求参数
 *  @param success 成功回调的Block
 *  @param fail    失败回调的Block
 */
+ (void)POSTWithUrl:(NSString *)url withParams:(id)params success:(OCSuccessCallBack)success fail:(OCFailCallBack)fail;

@end
