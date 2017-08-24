//
//  FBMyOrderDetailsDownView.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBMyOrderDetailsModel.h"
@interface FBMyOrderDetailsDownView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTybeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;
@property (nonatomic,strong) FBMyOrderDetailsModel * detailsModel;
@end
