//
//  FBMyTicketCell.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTicketDetailListModel.h"
@protocol FBMyTicketCellDelegate <NSObject>

@optional
/**
 *  点击出现日历
 */
- (void)showCalendar:(NSArray *)array;

//点击了地图按钮
- (void)showMap:(FBTicketDetailListModel *)model;

@end

@interface FBMyTicketCell : UITableViewCell

+(instancetype)cellTableView:(UITableView *)tableView;

@property (nonatomic,strong)id<FBMyTicketCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *ticketTypeLb;

@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *carPlatNo;
@property (weak, nonatomic) IBOutlet UILabel *visibleDataLB;
@property (weak, nonatomic) IBOutlet UILabel *upStationLB;

@property (weak, nonatomic) IBOutlet UILabel *startAddressLb;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLb;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;

@property (nonatomic,strong) FBTicketDetailListModel *model;
@end
