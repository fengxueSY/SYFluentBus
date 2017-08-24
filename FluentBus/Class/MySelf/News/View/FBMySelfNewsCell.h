//
//  FBMySelfNewsCell.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/3.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBNewsListModel.h"

@interface FBMySelfNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *messageLb;

@property (nonatomic ,strong) FBNewsListModel *model;

@end
