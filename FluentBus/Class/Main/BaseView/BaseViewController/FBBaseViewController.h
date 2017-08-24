//
//  FBBaseViewController.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/26.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBBaseViewController : UIViewController
@property (nonatomic,strong) UIButton * rightButtonItem;
@property (nonatomic,strong) UIButton * liftButtonItem;
@property (nonatomic,strong) UserInfo * baseUserInfo;/**<获取用户的基本信息*/

@end
