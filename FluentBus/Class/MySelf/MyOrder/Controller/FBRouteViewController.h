//
//  FBRouteViewController.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/29.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBNeedListModel.h"
#import "FBOrderProductsShiftsModel.h"
#import "FBTicketDetailListModel.h"
@interface FBRouteViewController : FBBaseViewController
@property (nonatomic,strong) NSString * viewStyle;/**<1，线路预览界面。2,订票界面。3.地图导航界面*/

//报名传值，我的订单传值
@property (nonatomic,strong)FBNeedListModel *needListModel;
//订购传值
@property (nonatomic,strong) FBOrderProductsShiftsModel * productsShiftsModel;
//我的车票传值
@property (nonatomic,strong)FBTicketDetailListModel *ticketListmodel;


@property (nonatomic) BOOL isHideDownButton;/**<我的订单界面进入不显示底部的button*/
@end
