//
//  FBMoneyInfo.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/20.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBMoneyInfo : NSObject
@property (nonatomic,copy) NSString * EndTime;/**<截止时间*/
@property (nonatomic,copy) NSString * Free;/**<是否自由充值（2.不自由，1自由）*/
@property (nonatomic,copy) NSString * MaxAmount;/**<最大额度*/
@property (nonatomic,copy) NSString * Name;/**<名称*/
@property (nonatomic,strong) NSArray * Template;/**<充值模板*/
@property (nonatomic,strong) NSArray * Discount;/**<优惠信息*/
@end
