//
//  FBResumeModel.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/4.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBResumeModel : NSObject
@property (nonatomic,copy) NSString * appid;
@property (nonatomic,copy) NSString * birthday;
@property (nonatomic,copy) NSString * createTime;
@property (nonatomic,copy) NSString * mobile;
@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * uid;
@property (nonatomic,copy) NSString * updateTime;

+(void)getUserInfoSuccess:(void(^)(id successed))success Fail:(void(^)(id failed))fail;
@end
