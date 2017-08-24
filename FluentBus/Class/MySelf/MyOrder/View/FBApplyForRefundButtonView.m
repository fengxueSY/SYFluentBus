//
//  FBApplyForRefundButtonView.m
//  FluentBus
//
//  Created by 666GPS on 2017/2/8.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBApplyForRefundButtonView.h"

@implementation FBApplyForRefundButtonView
-(void)awakeFromNib{
    [super awakeFromNib];
    NSString * str = @"同意《畅吧用户退款协议》";
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attStr addAttribute:NSFontAttributeName value:FONT(12) range:NSMakeRange(0,2)];
    [attStr addAttribute:NSForegroundColorAttributeName value:oneHeadingColor range:NSMakeRange(0, 2)];
    [attStr addAttribute:NSFontAttributeName value:FONT(12) range:NSMakeRange(3,8)];
    [attStr addAttribute:NSForegroundColorAttributeName value:blueUnifyColor range:NSMakeRange(3, 8)];
    self.agreeLabel.attributedText = attStr;

    [self.applyForRefundButton.layer setMasksToBounds:YES];
    [self.applyForRefundButton.layer setCornerRadius:5];
    
    [self.comButton addTarget:self action:@selector(comButtonAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)comButtonAction{
    if ([self.comButton.currentImage isEqual:[UIImage imageNamed:@"confirmorder_agree"]]) {
        [self.comButton setImage:UIImageName(@"confirmorder_agree_no") forState:UIControlStateNormal];
        self.applyForRefundButton.backgroundColor = UIColorWithRGB(230, 230, 230, 1);
        self.applyForRefundButton.userInteractionEnabled = NO;
    }else{
        [self.comButton setImage:UIImageName(@"confirmorder_agree") forState:UIControlStateNormal];
        self.applyForRefundButton.backgroundColor = greenUnifyColor;
        self.applyForRefundButton.userInteractionEnabled = YES;
    }
}
@end
