//
//  FBTabBarViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/26.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBTabBarViewController.h"
#import "FBNavigationController.h"

#import "FBMySelfViewController.h"
#import "FBNeedViewController.h"
#import "FBOrderViewController.h"
#import "FBTakeBusViewController.h"


#import "FBLoginViewController.h"
#import "FBNavigationController.h"
#import <CloudPushSDK/CloudPushSDK.h>
@interface FBTabBarViewController ()

@property (nonatomic,strong)NSMutableArray *tabbarbuttonArray;

@end

@implementation FBTabBarViewController

- (NSMutableArray *)tabbarbuttonArray
{
    if (_tabbarbuttonArray == nil) {
        _tabbarbuttonArray = [NSMutableArray array];
        for (UIView *tabBarButton in self.tabBar.subviews) {
            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                for (UIView *imageView in tabBarButton.subviews) {
                    if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                        [_tabbarbuttonArray addObject:imageView];
                    }
                }
            }
        }
    }
    return _tabbarbuttonArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 接收通知（接收到后台推送了）GetNotification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toAddRedView) name:@"GetNotification" object:nil];
    
    //收到touken过期，返回登录界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NSNotificationCenterClose) name:@"NSNotificationCenterClose" object:nil];
    self.tabBar.tintColor = [UIColor colorWithRed:40/255.0 green:130/255.0 blue:224/255.0 alpha:1];
    
    FBTakeBusViewController * tabkeBus = [[FBTakeBusViewController alloc]init];
    [self addOnechildVc:tabkeBus titel:@"乘车" imageName:@"tab_bycar_nor" selectedImageName:@"tab_bycar_active" TagNumber:0];
    
    FBOrderViewController * order = [[FBOrderViewController alloc]init];
    [self addOnechildVc:order titel:@"订购" imageName:@"tab_buycar_nor" selectedImageName:@"tab_buycar_active" TagNumber:1];
    
    FBNeedViewController * need = [[FBNeedViewController alloc]init];
    [self addOnechildVc:need titel:@"需求" imageName:@"tab_need_nor" selectedImageName:@"tab_need_acitve" TagNumber:2];
    
    FBMySelfViewController * mySelf = [[FBMySelfViewController alloc]init];
    [self addOnechildVc:mySelf titel:@"我的" imageName:@"tab_mine_nor" selectedImageName:@"tab_mine_actvie" TagNumber:3];
}

-(void)NSNotificationCenterClose{
    [WCAlertView showAlertWithTitle:@"提示" message:@"登录已过期，请重新登录" customizationBlock:^(WCAlertView *alertView) {
        
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 0) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:User_IS_AutoFail_LOGIN]) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_AutoFail_LOGIN];
                [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
                    DBLog(@"%@",res);
                }];
                FBLoginViewController *login = [[FBLoginViewController alloc]init];
                login.loginUserName = [UserInfo userInfoWithUserDefaults].userName;
                [UserInfo clearUserDefaults];
                [HeaderInfo tearDown];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:User_IS_BEFOR_LOGIN];
            }else{
                [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
                    DBLog(@"%@",res);
                }];
                FBLoginViewController *login = [[FBLoginViewController alloc]init];
                login.loginUserName = [UserInfo userInfoWithUserDefaults].userName;
                if ([[NSUserDefaults standardUserDefaults] boolForKey:User_IS_Auto_LOGIN]) {
                    FBNavigationController *nav=[[FBNavigationController alloc]initWithRootViewController:login];
                    [self presentViewController:nav
                                       animated:YES completion:nil];
                }else{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                [UserInfo clearUserDefaults];
                [HeaderInfo tearDown];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:User_IS_BEFOR_LOGIN];
            }
        }
    } cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
}

//推送
- (void)toAddRedView
{
    //添加红点
    [self.tabBar showBadgeOnItemIndex:3];
}

-(void)addOnechildVc:(UIViewController *)child titel:(NSString *)title imageName:(NSString*)imageName selectedImageName:(NSString *)selectedImageName TagNumber:(NSInteger)tagNumber
{
    child.navigationItem.title = title;
    child.tabBarItem.title = title;
    child.tabBarItem.image = [UIImage imageNamed:imageName];
    child.tabBarItem.tag = tagNumber;
    //    child.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    //让图片保留为原来的颜色
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:
                     UIImageRenderingModeAlwaysOriginal];
    child.tabBarItem.selectedImage =selectedImage;
    
    FBNavigationController *nav = [[FBNavigationController alloc]initWithRootViewController:child];
    [self addChildViewController:nav];
    
}

// 点击tabbarItem自动调用
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    DBLog(@"indel === %ld",index);
    [self animationWithIndex:index];
    
    // 也可以判断标题,然后做自己想做的事
    if(![item.title isEqualToString:@"设置"]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTabBarViewItem" object:self];
    }
    
}

- (void)animationWithIndex:(NSInteger) index {
    
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.5];
    [[self.tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}

/* 支持竖屏，视频播放界面强制横屏单独处理 */
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
