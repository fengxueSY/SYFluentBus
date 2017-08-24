//
//  FBMySettingViewController.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBMySettingViewController : FBBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end
