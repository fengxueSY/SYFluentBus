//
//  FBNeedListModel.h
//  FluentBus
//
//  Created by 张俊辉 on 17/1/6.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBNeedListModel : NSObject
//起点
@property (nonatomic,copy) NSString *startStation;
//终点
@property (nonatomic,copy) NSString *endStation;
//线路id
@property (nonatomic,copy) NSString *rid;
//需求id
@property (nonatomic,copy) NSString *myId;
//出发时间
@property (nonatomic,copy) NSString *stime;
//出行类型
@property (nonatomic,assign) NSInteger dtype;
//次票价
@property (nonatomic,copy) NSString *aprice;
//越票价
@property (nonatomic,copy) NSString *mprice;
//投票数量
@property (nonatomic,copy) NSString *votedCount;
//操作者
@property (nonatomic,copy) NSString *creator;
//车票类型
@property (nonatomic,copy) NSString *ticketTypeName;

//途径点描述
@property (nonatomic,copy) NSString *describtion;

@property (nonatomic,assign) NSInteger tag;
//站线关系的模型数据
@property (nonatomic,strong)NSMutableArray *needRouteArray;

@end
