//
//  FBMidTableViewCell.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/29.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBMidTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *changeImageView;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *touchButton;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@end
