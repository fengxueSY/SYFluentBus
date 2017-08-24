//
//  UIView + CGC.m
//  jobCompany
//
//  Created by 陈广川 on 16/1/5.
//  Copyright © 2016年 liaolx. All rights reserved.
//

#import "UIView + CGC.h"

@implementation UIView (CGC)

+ (void)setCornerWithView:(UIView *)view cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:cornerRadius];
    [view.layer setBorderWidth:borderWidth];
    
    if (borderColor != nil) {
        [view.layer setBorderColor:borderColor.CGColor];
    }
    
}

+ (void)setViewCorner:(UIView *)view cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width colorRGB:(NSInteger)rgb
{
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:radius];
    [view.layer setBorderWidth:width];
    
    
    if (!rgb) {
        return;
    }
    CGColorRef colorRef = UIColorFromRGB(rgb).CGColor;
    [view.layer setBorderColor:colorRef];
}@end
