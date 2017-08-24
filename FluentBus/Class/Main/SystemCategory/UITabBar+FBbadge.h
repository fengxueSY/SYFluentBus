//
//  UITabBar+FBbadge.h
//  FluentBus
//
//  Created by 张俊辉 on 17/1/17.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (FBbadge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
