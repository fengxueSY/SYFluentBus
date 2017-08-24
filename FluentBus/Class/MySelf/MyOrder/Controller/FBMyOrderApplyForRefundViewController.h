//
//  FBMyOrderApplyForRefundViewController.h
//  FluentBus
//
//  Created by 666GPS on 2017/2/8.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBMyOrderModel.h"
@interface FBMyOrderApplyForRefundViewController : FBBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,copy) NSString * orderID;
@property (nonatomic,strong) FBMyOrderModel * myOrderModel;
@property (nonatomic,copy) NSString * comeStyle;/**<标注从哪个界面跳转过来的，0--代表从订单列表界面进来，返回时只需返回一页即可。1--代表从订单详情界面跳转过来，返回时直接放到订单列表界面*/
@end
