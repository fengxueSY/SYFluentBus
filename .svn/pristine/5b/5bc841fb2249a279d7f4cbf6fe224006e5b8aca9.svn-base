//
//  FBTwoTypeView.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBTwoTypeView.h"

@implementation FBTwoTypeView
-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDayImageAction)];
    self.dayImageView.userInteractionEnabled = YES;
    [self.dayImageView addGestureRecognizer:tap];
    
    self.productTypeName.textColor = UIColorFromRGB(0xff4d64);
}
-(void)selectDayImageAction{
    if (_delegate) {
        [_delegate selectDayImage];
    }
}
@end
