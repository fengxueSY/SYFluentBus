//
//  FBTwoTypeView.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FBTwoTypeViewDelegate <NSObject>
-(void)selectDayImage;
@end
@interface FBTwoTypeView : UIView
@property (nonatomic,assign) id <FBTwoTypeViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startGoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dayImageView;
@property (weak, nonatomic) IBOutlet UILabel *productTypeName;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
