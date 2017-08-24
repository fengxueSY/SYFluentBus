//
//  FBBaseViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/26.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBBaseViewController.h"
#import <UShareUI/UShareUI.h>

@interface FBBaseViewController ()

@end

@implementation FBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseData];
}
-(void)baseData{
    self.view.backgroundColor = backCommonlyUsedColor;
    self.navigationItem.hidesBackButton = YES;
    _liftButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    _liftButtonItem.frame = CGRectMake(0, 0, 20, 19);
    [_liftButtonItem setImage:[UIImage imageNamed:@"common_nav_back"] forState:UIControlStateNormal];
    
    _rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButtonItem.frame = CGRectMake(0, 0, SCREEN_WIDTH / 8, 44);
    _rightButtonItem.titleLabel.textAlignment = NSTextAlignmentRight;
    _rightButtonItem.titleLabel.font = [UIFont systemFontOfSize:16];
    
    _baseUserInfo = [UserInfo userInfoWithUserDefaults];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD hideHUD];
}
//微博分享
-(void)shareWeiBo{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
