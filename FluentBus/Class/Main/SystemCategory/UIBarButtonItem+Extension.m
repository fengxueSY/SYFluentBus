//
//  UIBarButtonItem+Extension.m
//  PresentSay
//
//  Created by 张俊辉 on 15/12/29.
//  Copyright © 2015年 张俊辉. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

//添加target 不能用self 如果用self就是用Button去调用action这个方法。 这里是要用传过来的控制器（target）调用。
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //根据当前（正常）状态下button图片的尺寸设置button的尺寸
    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 40, 40);
    if ([title isEqualToString:@"储值卡"]) {
        button.frame = CGRectMake(0, 0, 60, 60);
    }
    if ([title isEqualToString:@"发起新需求"]) {
        button.frame = CGRectMake(0, 0, 80, 80);
    }
    if ([title isEqualToString:@"注册"]) {
        button.titleLabel.font = [UIFont systemFontOfSize:18.0];
    }
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end