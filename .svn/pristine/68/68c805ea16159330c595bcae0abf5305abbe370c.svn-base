//
//  FBSearchTableView.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBOrderModel.h"
@protocol FBSearchTableViewDelegate <NSObject>

-(void)chooseItemText:(FBOrderModel *)ietmModel;

@end
@interface FBSearchTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) id <FBSearchTableViewDelegate>delegate;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * dataArray;
-(void)reloadInTableView;
@end
