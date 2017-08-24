//
//  FBLoginViewController.m
//  FluentBus
//
//  Created by 张俊辉 on 16/12/30.
//  Copyright © 2016年 yang. All rights reserved.
//75b7e8（浅色）208de0(深色)

#import "FBLoginViewController.h"
#import "RegisterViewController.h"
#import "FBTabBarViewController.h"
#import "SSKeychain.h"
#import "CRSA.h"
#import "Base64.h"
#import "MyMD5.h"
#import "NSString+RSA.h"
#import "FBResetPasswordViewController.h"
#import <CloudPushSDK/CloudPushSDK.h>

static NSString *kKeychainService = @"com.666GPS.FluentBus";
static NSString *kKeychainDeviceId = @"KeychainDeviceId";

@interface FBLoginViewController ()<UITextFieldDelegate>
{
    CGRect _keyboardFrame;
    CGFloat _offset;
    
    NSString *_RSAString;
    
    NSString *_userNameString;
    NSString *_passwordString;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBigView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;

@end

@implementation FBLoginViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self makeUpUI];

}

- (void)makeUpUI
{
    self.title = @"登录";
    self.userNameTF.text = _loginUserName;
    _userNameString = _loginUserName;
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.backgroundColor = UIColorFromRGB(0x75b7e8);
    self.loginBtn.userInteractionEnabled = NO;
    self.userNameTF.delegate = self;
    self.passwordTF.delegate = self;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"注册" target:self action:@selector(onClickRegisterBtn)];
    // 注册键盘弹出事件的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    // 注册键盘隐藏事件的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillHideFrame:) name:UIKeyboardWillHideNotification object:nil];
    
    //手势，点击结束编辑
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self getDeviceId];
}

//注册
-(void)onClickRegisterBtn
{
    [self hideKeyboard];
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
}

//忘记密码
- (IBAction)onCLickForgetPasswordBtn:(id)sender {
    
    [self hideKeyboard];
    
    FBResetPasswordViewController *ctl = [[FBResetPasswordViewController alloc]init];
    ctl.flag = YES;
    [self.navigationController pushViewController:ctl animated:YES];
}


#pragma mark - UITextFieldDelegate
//结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.userNameTF) {
        
        // 提取本地密码
        NSString *localPassword = [SSKeychain passwordForService:kKeychainService account:textField.text];
        if (localPassword) {
            self.passwordTF.text = localPassword;
            self.loginBtn.backgroundColor = UIColorFromRGB(0x208de0);
            self.loginBtn.userInteractionEnabled = YES;
        }
    }
}

//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.passwordTF) {
        
        // 提取本地密码
        NSString *localPassword = [SSKeychain passwordForService:kKeychainService account:self.userNameTF.text];
        if (localPassword) {
            self.passwordTF.text = localPassword;
            self.loginBtn.backgroundColor = UIColorFromRGB(0x208de0);
            self.loginBtn.userInteractionEnabled = YES;
            
        }
    }
    
}

//textField字符变动时
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _userNameTF) {
        _userNameString = string;
        
    }
    if (textField == _passwordTF) {
        _passwordString = string;
    }
//    DBLog(@"%ld",_userNameTF.text.length);
//    DBLog(@"%ld-----%ld",_userNameString.length,_passwordString.length);
    
    //前面的&&判断的是输入 后面的&&判定的是删除
    if ((_userNameString.length>0 && _passwordString.length>0) ||(_userNameTF.text.length>1 && _passwordTF.text.length>1)) {
        self.loginBtn.backgroundColor = UIColorFromRGB(0x208de0);
        self.loginBtn.userInteractionEnabled = YES;
        
    }else{
        
        self.loginBtn.backgroundColor = UIColorFromRGB(0x75b7e8);
        self.loginBtn.userInteractionEnabled = NO;
    }
    
    return YES;
}

//清空文本
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField == self.userNameTF) {
        self.passwordTF.text = nil;
    }
    
    self.loginBtn.backgroundColor = UIColorFromRGB(0x75b7e8);
    self.loginBtn.userInteractionEnabled = NO;
    
    return YES;
}

#pragma mark - 处理键盘
//隐藏键盘
-(void)hideKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
}

/**
 *  键盘弹出的监听
 */
- (void)onKeyboardWillShowFrame:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    _keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        _offset = CGRectGetMaxY(_loginBtn.frame) - _keyboardFrame.origin.y;
        //        CGFloat height = self.scrollView.contentSize.height;
        //        height = self.scrollView.bounds.size.height + keyboardFrame.size.height;
        CGSize contentSize = _bottomScrollView.contentSize;
        
        if (SCREEN_HEIGHT<500) {
            contentSize.height = _bottomScrollView.bounds.size.height + _keyboardFrame.size.height;
            _bottomScrollView.contentSize = contentSize;
            
            _bottomScrollView.contentOffset = CGPointMake(0, _offset-30);
        }else if (SCREEN_HEIGHT<600){
            contentSize.height = _bottomScrollView.bounds.size.height + _keyboardFrame.size.height-100;
            _bottomScrollView.contentSize = contentSize;
            
            _bottomScrollView.contentOffset = CGPointMake(0, _offset+15);
        }else if (SCREEN_HEIGHT>600){
            contentSize.height = _bottomScrollView.bounds.size.height+ _keyboardFrame.size.height-180;
            _bottomScrollView.contentSize = contentSize;
            
            _bottomScrollView.contentOffset = CGPointMake(0, _offset+10);
            
        }else{
            contentSize.height = _bottomScrollView.bounds.size.height+ _keyboardFrame.size.height-220;
            _bottomScrollView.contentSize = contentSize;
            
            _bottomScrollView.contentOffset = CGPointMake(0, _offset+10);
        }
    }];
}

/**
 *  键盘隐藏的监听
 */
- (void)onKeyboardWillHideFrame:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    double duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        _bottomScrollView.contentOffset = CGPointMake(0, 0);
        // 让scrollView还原
        CGSize contentSize = _bottomScrollView.contentSize;
        
        contentSize.height = 530;// _bottomScrollView.contentSize.height-_keyboardFrame.size.height/2 ;
        _bottomScrollView.contentSize = contentSize;
        
    }];
}


- (IBAction)onClickLoginBtn:(id)sender {
    
    [self hideKeyboard];
    
    if (![PublicMethod isNetworkEnabled]) {
        
        [MBProgressHUD showError:@"网络出错!"];
        return;
    }
    
    if(!StringNotNilAndNull(_userNameTF.text)) {
        [MBProgressHUD showError:@"用户名不能为空"];
        return;
    }
    
    if(!StringNotNilAndNull(_passwordTF.text)) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在登录"];
    
    [self getSecret];
}

//拿到膜和指数，并进行加密
-(void)getSecret
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    [dict setValue:_userNameTF.text forKey:@"UserName"];
    [OCNetworkingTool POSTWithUrl:getLoginKey() withParams:dict success:^(id responseObject) {
        
        DBLog(@"%@",responseObject);
        NSDictionary *data =responseObject[@"data"];
        NSString *myId = data[@"id"];
        NSString *secret = data[@"secret"];
        NSArray *temp=[secret componentsSeparatedByString:@"-"];
        NSLog(@"%@,%@",temp[0],temp[1]);
        
        NSString *md5Str = [MyMD5 md5:_passwordTF.text];
        //获取当前时间戳
        NSDate *currentDate = [PublicMethod getLocalCurrentDate];
        long currentSeconds = [PublicMethod getSecondsWithDate:currentDate];
        NSString *mycurrentSeconds = [NSString stringWithFormat:@"%ld000",currentSeconds];
        NSString *rsaStr = [NSString stringWithFormat:@"%@@%@@%@",md5Str,_userNameTF.text,mycurrentSeconds];
        NSLog(@"%@",rsaStr);
        
        _RSAString =  [NSString setPublicKey:[rsaStr UTF8String] Mod:[temp[1] UTF8String] Exp:[temp[0] UTF8String]];
        _RSAString = [NSString stringWithFormat:@"%@@%@",_RSAString,myId];
        
        [self tologin];
        
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"登录失败，请检查网络"];
    }];
}

//拿到公钥后加密登录
- (void)tologin
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_userNameTF.text forKey:@"mobile"];
    [dict setValue:@"123" forKey:@"VerifyCode"];
    
    [dict setValue:_RSAString forKey:@"password"];
    
    [OCNetworkingTool POSTWithUrl:loginMyApp() withParams:dict success:^(id responseObject) {
        
        [MBProgressHUD hideHUD];
        
        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        
        if ([responseObject[@"code"] integerValue] == 200) {
            [MBProgressHUD showSuccess:@"登录成功"];
            NSDictionary *data = responseObject[@"data"];
            NSString *tokenId = data[@"TokenId"];
            NSString *defaultAppId = data[@"DefaultAppId"];
            NSString *mobile = data[@"Mobile"];
            NSString *userId = data[@"Uid"];
            NSString *myAppId = defaultAppId;
            NSString *nickName = data[@"Nickname"];
             [CloudPushSDK bindAccount:[NSString stringWithFormat:@"%@-%@",myAppId,mobile] withCallback:^(CloudPushCallbackResult *res) {
                 NSLog(@"%d",res.success);
             }];

            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:  User_IS_BEFOR_LOGIN];
             [[NSUserDefaults standardUserDefaults] setBool:NO forKey: User_IS_Auto_LOGIN];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_AutoFail_LOGIN];
            // 保存账号密码
            [SSKeychain setPassword:self.passwordTF.text forService:kKeychainService account:self.userNameTF.text];
            //userId
            NSDictionary *dict = @{@"userTokenId":tokenId, @"userAppId":myAppId,@"userName":mobile,@"userId":userId,@"nickName":nickName};
            [UserInfo userInfoWithDict:dict];
            
//
            [HeaderInfo tearDown];
            [HeaderInfo sharedHeaderInfo];
            FBTabBarViewController *tabBarCtl = [[FBTabBarViewController alloc]init];
            [self presentViewController:tabBarCtl animated:YES completion:nil];
            
        }else if ([responseObject[@"code"] integerValue] == 1001){
            [MBProgressHUD showError:@"用户名不存在"];
        }else if ([responseObject[@"code"] integerValue] == 551){
            [MBProgressHUD showError:@"帐号或密码错误"];
        }else if ([responseObject[@"code"] integerValue] == 502){
            [MBProgressHUD showError:@"登录超时"];
        }else{
            [MBProgressHUD showError:@"登录异常"];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"登录失败，请检查网络"];
    }];
}

#pragma mark - private method

- (NSString *)getDeviceId {
    // 读取设备号
    NSString *localDeviceId = [SSKeychain passwordForService:kKeychainService account:kKeychainDeviceId];
    if (!localDeviceId) {
        // 保存设备号
        CFUUIDRef deviceId = CFUUIDCreate(NULL);
        assert(deviceId != NULL);
        CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceId);
        [SSKeychain setPassword:[NSString stringWithFormat:@"%@", deviceIdStr] forService:kKeychainService account:kKeychainDeviceId];
        localDeviceId = [NSString stringWithFormat:@"%@", deviceIdStr];
    }
    
    return localDeviceId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
