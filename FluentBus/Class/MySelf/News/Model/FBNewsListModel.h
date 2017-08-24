//
//  FBNewsListModel.h
//  FluentBus
//
//  Created by 张俊辉 on 17/1/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBNewsListModel : NSObject

//消息id
@property (nonatomic,copy) NSString *myId;
//消息类型：0订购，1支付，2退票，3服务信息
@property (nonatomic,assign) NSInteger  type;
//消息标题
@property (nonatomic,copy) NSString *msgTitle;
//消息内容
@property (nonatomic,copy) NSString *msg;
//手机号码
@property (nonatomic,copy) NSString *mbl;
//发送时间
@property (nonatomic,copy) NSString *ctime;

@end
