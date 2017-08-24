//
//  FBConfirmPayView.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBConfirmPayViewDelegate <NSObject>

-(void)showUserDelegate;

@end



@interface FBConfirmPayView : UIView

@property (nonatomic,strong)id<FBConfirmPayViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *chooseHeadButton;
@property (weak, nonatomic) IBOutlet UILabel *delegateLabel;
@property (weak, nonatomic) IBOutlet UIButton *goPayButton;

@end
