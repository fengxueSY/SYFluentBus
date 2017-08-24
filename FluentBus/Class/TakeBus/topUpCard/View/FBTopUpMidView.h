//
//  FBTopUpMidView.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FBTopUpMidViewDelegate <NSObject>

-(void)watchUserDelegate;

@end
@interface FBTopUpMidView : UIView
@property (nonatomic,assign) id <FBTopUpMidViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *button_50;
@property (weak, nonatomic) IBOutlet UIButton *button_100;
@property (weak, nonatomic) IBOutlet UIButton *button_200;
@property (weak, nonatomic) IBOutlet UIButton *goPayMoneyButton;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;
@property (weak, nonatomic) IBOutlet UIImageView *agreeButton;
@property (weak, nonatomic) IBOutlet UITextField *writeMoneyNumberTextFile;

@end