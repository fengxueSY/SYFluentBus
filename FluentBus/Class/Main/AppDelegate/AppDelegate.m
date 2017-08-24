//
//  AppDelegate.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/26.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "AppDelegate.h"

#import "FBTabBarViewController.h"
#import "AppDelegate+FBThreeLibRegister.h"
#import "FBLoginViewController.h"
#import "FBNavigationController.h"
#import "MyMD5.h"
#import "SSKeychain.h"
#import "NSString+RSA.h"
#import "AudioToolbox/AudioToolbox.h"


static NSString *kKeychainService = @"com.666GPS.FluentBus";
static NSString *kKeychainDeviceId = @"KeychainDeviceId";

@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>
{
    NSString *_RSAString;
    
    FBTabBarViewController * _TAB;
}

@end

@implementation AppDelegate
{
    // iOS 10通知中心
    UNUserNotificationCenter *_notificationCenter;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //设置登录界面为根视图
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[UIButton appearance] setExclusiveTouch:YES];
    
    //注册第三方类库
    [self registerThreeLib];
    
    //推送
    // APNs注册，获取deviceToken并上报
    [self registerAPNS:application];
    
    // 初始化SDK
    [self initCloudPush];
    // 监听推送通道打开动作
    [self listenerOnChannelOpened];
    // 监听推送消息到达
    [self registerMessageReceive];
    // 点击通知将App从关闭状态启动时，将通知打开回执上报
    [CloudPushSDK sendNotificationAck:launchOptions];

    BOOL isUserBeforeLogined = [[NSUserDefaults standardUserDefaults] boolForKey:User_IS_BEFOR_LOGIN];
    if (isUserBeforeLogined == YES) {
        
        FBTabBarViewController * TAB = [[FBTabBarViewController alloc]init];
        self.window.rootViewController = TAB;
        
        [self getSecret];
        
    }else{
        
        FBNavigationController *nav = [[FBNavigationController alloc]initWithRootViewController:[FBLoginViewController new]];
        self.window.rootViewController = nav;
    }
    
    //进程关掉时，推送后直接点app进入 要提示小红点
    if (application.applicationIconBadgeNumber != 0) {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        // 发送通知（接收到后台推送了）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetNotification" object:self userInfo:nil];
    }
    
    application.applicationIconBadgeNumber = 0;

    return YES;
}

//自动登录
-(void)autoToLogin{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserInfo userInfoWithUserDefaults].userName forKey:@"mobile"];
    [dict setValue:@"123" forKey:@"VerifyCode"];
    
    [dict setValue:_RSAString forKey:@"password"];
    

    [OCNetworkingTool POSTWithUrl:loginMyApp() withParams:dict success:^(id responseObject) {
        
         DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        
        [MBProgressHUD hideHUD];
        
        //        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        
        if ([responseObject[@"code"] integerValue] == 200) {
//            [MBProgressHUD showSuccess:@"自动登录成功"];
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_AutoFail_LOGIN];
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey: User_IS_Auto_LOGIN];
            NSDictionary *data = responseObject[@"data"];
            NSString *tokenId = data[@"TokenId"];
            NSString *defaultAppId = data[@"DefaultAppId"];
            NSString *mobile = data[@"Mobile"];
            NSString *myAppId = defaultAppId;
            NSString *userId = data[@"Uid"];
            NSString *nickName = data[@"Nickname"];
            DBLog(@"%@",tokenId);
            [CloudPushSDK bindAccount:[NSString stringWithFormat:@"%@-%@",myAppId,mobile] withCallback:^(CloudPushCallbackResult *res) {
                NSLog(@"%@",res);
            }];
            
            NSDictionary *dict = @{@"userTokenId":tokenId, @"userAppId":myAppId,@"userName":mobile,@"userId":userId,@"nickName":nickName};
            [UserInfo userInfoWithDict:dict];
            //清空单例
            [HeaderInfo tearDown];
            //在单例中存入登录信息。
            [HeaderInfo sharedHeaderInfo];
            
            // 发送通知（通知首页控制器已经拿完数据了）
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DoneNotification" object:self userInfo:nil];
            
        }else {
            [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
                DBLog(@"%@",res);
            }];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_BEFOR_LOGIN];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:  User_IS_AutoFail_LOGIN];
            FBLoginViewController *login = [[FBLoginViewController alloc]init];
            FBNavigationController *nav=[[FBNavigationController alloc]initWithRootViewController:login];
            self.window.rootViewController = nav;
            //            sleep(1.5);
            [MBProgressHUD showError:@"自动登录失败"];
        }
        
    } fail:^(NSError *error) {
        
        [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
            DBLog(@"%@",res);
        }];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_BEFOR_LOGIN];
         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:  User_IS_AutoFail_LOGIN];
        [MBProgressHUD hideHUD];
        FBLoginViewController *login = [[FBLoginViewController alloc]init];
        FBNavigationController *nav=[[FBNavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = nav;
        //        sleep(1.5);
        [MBProgressHUD showError:@"自动登录失败"];
    }];
}

//拿到膜和指数，并进行加密
-(void)getSecret
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:[UserInfo userInfoWithUserDefaults].userName forKey:@"UserName"];
    
    [OCNetworkingTool POSTWithUrl:getLoginKey() withParams:dict success:^(id responseObject) {
        
        DBLog(@"%@",responseObject);
        NSDictionary *data =responseObject[@"data"];
        NSString *myId = data[@"id"];
        NSString *secret = data[@"secret"];
        NSArray *temp=[secret componentsSeparatedByString:@"-"];
        NSLog(@"%@,%@",temp[0],temp[1]);
        
        //取密码
        NSString *localPassword = [SSKeychain passwordForService:kKeychainService account:[UserInfo userInfoWithUserDefaults].userName];
        
        NSString *md5Str;
        if (localPassword) {
            
            md5Str = [MyMD5 md5:localPassword];
        }
        //获取当前时间戳
        NSDate *currentDate = [PublicMethod getLocalCurrentDate];
        long currentSeconds = [PublicMethod getSecondsWithDate:currentDate];
        NSString *mycurrentSeconds = [NSString stringWithFormat:@"%ld000",currentSeconds];
        
        NSString *rsaStr = [NSString stringWithFormat:@"%@@%@@%@",md5Str,[UserInfo userInfoWithUserDefaults].userName,mycurrentSeconds];
        NSLog(@"%@",rsaStr);
        
        _RSAString =  [NSString setPublicKey:[rsaStr UTF8String] Mod:[temp[1] UTF8String] Exp:[temp[0] UTF8String]];
        
        _RSAString = [NSString stringWithFormat:@"%@@%@",_RSAString,myId];
        
        [self autoToLogin];
        
    } fail:^(NSError *error) {
        
        [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
            DBLog(@"%@",res);
        }];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_BEFOR_LOGIN];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:  User_IS_AutoFail_LOGIN];
        [MBProgressHUD hideHUD];
        FBLoginViewController *login = [[FBLoginViewController alloc]init];
        FBNavigationController *nav = [[FBNavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = nav;
        //        sleep(1.5);
        [MBProgressHUD showError:@"自动登录失败"];
    }];
}

/**
 *  处理iOS 10通知(iOS 10+)
 
  测试结果: iOS10app在前台 或者点击通知进程序会走这里
 */
- (void)handleiOS10Notification:(UNNotification *)notification {
    UNNotificationRequest *request = notification.request;
    UNNotificationContent *content = request.content;
    NSDictionary *userInfo = content.userInfo;
    // 通知时间
    NSDate *noticeDate = notification.date;
    // 标题
    NSString *title = content.title;
    // 副标题
    NSString *subtitle = content.subtitle;
    // 内容
    NSString *body = content.body;
    // 角标
    int badge = [content.badge intValue];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *extras = [userInfo valueForKey:@"Extras"];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    // 发送通知（接收到后台推送了）
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetNotification" object:nil userInfo:nil];
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];
    
    NSLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, extras: %@.", noticeDate, title, subtitle, body, badge, extras);
}

/**
 *  App处于前台时收到通知(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"Receive a notification in foregound.");
    // 处理iOS 10通知，并上报通知打开回执
    [self handleiOS10Notification:notification];
    // 通知不弹出
    completionHandler(UNNotificationPresentationOptionNone);
    
    // 通知弹出，且带有声音、内容和角标
    //completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

/**
 *  触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSString *userAction = response.actionIdentifier;
    // 点击通知打开
    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier]) {
        NSLog(@"User opened the notification.");
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification];
    }
    // 通知dismiss，category创建时传入UNNotificationCategoryOptionCustomDismissAction才可以触发
    if ([userAction isEqualToString:UNNotificationDismissActionIdentifier]) {
        NSLog(@"User dismissed the notification.");
    }
    NSString *customAction1 = @"action1";
    NSString *customAction2 = @"action2";
    // 点击用户自定义Action1
    if ([userAction isEqualToString:customAction1]) {
        NSLog(@"User custom action1.");
    }
    
    // 点击用户自定义Action2
    if ([userAction isEqualToString:customAction2]) {
        NSLog(@"User custom action2.");
    }
    completionHandler();
}

#pragma mark -推送

- (void)initCloudPush {
    // SDK初始化
    [CloudPushSDK asyncInit:@"23593064" appSecret:@"2e4a56d9f211c51f117b0547bf93bba2" callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

#pragma mark Notification Open
/*
 *  App处于启动状态时，通知打开回调
    测试结果: iOS9app在前台 或者点击通知进程序会走这里
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    
    NSLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], Extras = [%@]", content, (long)badge, sound, Extras);
    // iOS badge 清0
    
    application.applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    
    // 发送通知（接收到后台推送了）
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetNotification" object:nil userInfo:nil];
    
    [CloudPushSDK sendNotificationAck:userInfo];
    
}

//注册苹果推送，获取deviceToken用于推送
- (void)registerAPNS:(UIApplication *)application {
    float systemVersionNum = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersionNum >= 10.0) {
        // iOS 10 notifications
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        // 创建category，并注册到通知中心
        [self createCustomNotificationCategory];
        _notificationCenter.delegate = self;
        // 请求推送权限
        [_notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // granted
                NSLog(@"User authored notification.");
                // 向APNs注册，获取deviceToken
                [application registerForRemoteNotifications];
            } else {
                // not granted
                NSLog(@"User denied notification.");
            }
        }];
    } else if (systemVersionNum >= 8.0) {
        // iOS 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
#pragma clang diagnostic pop
    } else {
        // iOS < 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
#pragma clang diagnostic pop
    }
}

/**
 *  创建并注册通知category(iOS 10+)
 */
- (void)createCustomNotificationCategory {
    // 自定义`action1`和`action2`
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"test1" options: UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"test2" options: UNNotificationActionOptionNone];
    // 创建id为`test_category`的category，并注册两个action到category
    // UNNotificationCategoryOptionCustomDismissAction表明可以触发通知的dismiss回调
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test_category" actions:@[action1, action2] intentIdentifiers:@[] options:
                                        UNNotificationCategoryOptionCustomDismissAction];
    // 注册category到通知中心
    [_notificationCenter setNotificationCategories:[NSSet setWithObjects:category, nil]];
}

/*
 *  苹果推送注册成功回调，将苹果返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success%@",deviceToken);
        } else {
            
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}
/*
 *  苹果推送注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

#pragma mark Channel Opened
/**
 *	注册推送通道打开监听
 */
- (void)listenerOnChannelOpened {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChannelOpened:)
                                                 name:@"CCPDidChannelConnectedSuccess"
                                               object:nil];
}

/**
 *	推送通道打开回调
 */
- (void)onChannelOpened:(NSNotification *)notification {
//    [MBProgressHUD showSuccess:@"消息通道建立成功"];
}

#pragma mark Receive Message
/**
 *	@brief	注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}

/**
 *	处理到来推送消息
 */
- (void)onMessageReceived:(NSNotification *)notification {
    NSLog(@"Receive one message!");
    
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSLog(@"Receive message title: %@, content: %@.", title, body);
    
//    LZLPushMessage *tempVO = [[LZLPushMessage alloc] init];
//    tempVO.messageContent = [NSString stringWithFormat:@"title: %@, content: %@", title, body];
//    tempVO.isRead = 0;
//    
//    if(![NSThread isMainThread]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(tempVO.messageContent != nil) {
//                [self insertPushMessage:tempVO];
//            }
//        });
//    } else {
//        if(tempVO.messageContent != nil) {
//            [self insertPushMessage:tempVO];
//        }
//    }
    
}

#pragma mark 禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

//被废弃的方法. 但是在低版本中会用到.建议写上
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}
//被废弃的方法. 但是在低版本中会用到.建议写上

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

//新的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark 微信回调方法

- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付结果:";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"成功";
                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"取消";
                break;
            }
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"失败";
                break;
            }
        }
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPay" object:nil userInfo:@{@"WeiXinPay":wxPayResult}];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.、
    
    if (application.applicationIconBadgeNumber != 0) {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        // 发送通知（接收到后台推送了）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetNotification" object:self userInfo:nil];
    }
    
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
