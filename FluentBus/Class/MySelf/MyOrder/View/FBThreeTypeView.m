//
//  FBThreeTypeView.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/5.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBThreeTypeView.h"

@implementation FBThreeTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    [UIView setViewCorner:_prouductNameLabel cornerRadius:2 borderWidth:1 colorRGB:(0xff4d64)];
    
}

@end
