//
//  FBNeedListTableViewCell.h
//  FluentBus
//
//  Created by 张俊辉 on 16/12/29.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBNeedListModel.h"
#import "FBNeedListRouteModel.h"

typedef void (^onClickonClickSignupBtnCallBack)();

@interface FBNeedListTableViewCell : UITableViewCell

+(instancetype)cellTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *gothroughAddressLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *startLB;
@property (weak, nonatomic) IBOutlet UILabel *endLB;

@property (weak, nonatomic) IBOutlet UILabel *mpriceLB;
@property (weak, nonatomic) IBOutlet UILabel *ticketTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *dayTicketLb;

@property (weak, nonatomic) IBOutlet UILabel *apriceLB;

@property (nonatomic ,strong) FBNeedListModel *model;


@property (nonatomic,copy) onClickonClickSignupBtnCallBack btnBlack;

@end
