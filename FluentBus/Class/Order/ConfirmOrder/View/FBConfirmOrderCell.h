//
//  FBConfirmOrderCell.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/30.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FBConfirmOrderCellDelegate <NSObject>

-(void)chooseCalendarShow;

@end

@interface FBConfirmOrderCell : UITableViewCell
@property (nonatomic,strong) id<FBConfirmOrderCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *twoHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *twoTrailImageView;
@property (weak, nonatomic) IBOutlet UILabel *oneLeadLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneTrailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *calendarImageView;

@end
