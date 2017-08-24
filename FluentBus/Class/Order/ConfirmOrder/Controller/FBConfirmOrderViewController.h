//
//  FBConfirmOrderViewController.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/30.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBOrderProductsShiftsModel.h"
#import "FBPayOrderDataModel.h"
#import "FBNeedListRouteModel.h"
@interface FBConfirmOrderViewController : FBBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) FBOrderProductsShiftsModel * productShiftsModel;
@property (nonatomic,strong) FBPayOrderDataModel * payOrderDataModel;
@property (nonatomic,strong) FBNeedListRouteModel * needListRouteModel;
@end
