//
//  FBMyTicketViewController.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBMyTicketViewController : FBBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;

@end
