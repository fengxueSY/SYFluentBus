//
//  FBOrderHeadView.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/30.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBOrderModel.h"
@interface FBOrderHeadView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vLabel;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;
@property (nonatomic,strong) FBOrderModel * listModel;
@end