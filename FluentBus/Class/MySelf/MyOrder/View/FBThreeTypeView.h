//
//  FBThreeTypeView.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FBThreeTypeViewDelegate <NSObject>

-(void)showCalendar:(NSArray *)calendarArray;

@end

@interface FBThreeTypeView : UIView
@property (nonatomic,strong)id<FBThreeTypeViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *validLabel;
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *startNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet UILabel *prouductNameLabel;

@end
