//
//  FBMyOrderDetailsUpView.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBMyOrderDetailsModel.h"
@protocol FBMyOrderDetailsUpViewDelegate <NSObject>

-(void)showCanlendar;

@end
@interface FBMyOrderDetailsUpView : UIView
@property (nonatomic,strong)id<FBMyOrderDetailsUpViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *passByLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *validityLabel;
@property (weak, nonatomic) IBOutlet UILabel *startOnlyLabel;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (nonatomic,strong) FBMyOrderDetailsModel * detailsModel;
@end
