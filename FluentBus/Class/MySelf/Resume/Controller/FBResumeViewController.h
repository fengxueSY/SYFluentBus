//
//  FBResumeViewController.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBBaseViewController.h"

@protocol FBResumeViewControllerDelegate <NSObject>


@end

@interface FBResumeViewController : FBBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) id<FBResumeViewControllerDelegate>delegate;
@property (nonatomic,strong) UITableView * tableView;


@end
