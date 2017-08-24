//
//  FBResetPasswordViewController.m
//  FluentBus
//
//  Created by 张俊辉 on 17/1/3.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBResetPasswordViewController.h"
#import "CRSA.h"
#import "Base64.h"
#import "MyMD5.h"
#import "NSString+RSA.h"
#import "FBNavigationController.h"
#import "FBLoginViewController.h"
#import <CloudPushSDK/CloudPushSDK.h>

@interface FBResetPasswordViewController ()
{
    NSInteger _second;
    NSTimer *_timer;
    
    NSString *_RSAString;
}

@property (weak, nonatomic) IBOutlet UIView *bottomBigView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *comfirPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

/* 弹出视图 */
@property (nonatomic, strong) UIAlertController *submitAlertController;

@end

@implementation FBResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomBigView.backgroundColor = backCommonlyUsedColor;
    [self setUpUI];
    [self prepareSubmitAlertController];
}

- (void)setUpUI
{
    if (_flag == YES) {
        self.title = @"找回密码";
    }else{
        self.title = @"重置密码";
        _phoneNumberTF.userInteractionEnabled = NO;
        _phoneNumberTF.text = [UserInfo userInfoWithUserDefaults].userName;
    }
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.clipsToBounds = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    
    //手势，点击结束编辑
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.bottomBigView addGestureRecognizer:tap];
}

-(void)hideKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
}

//返回按钮
-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  准备取消申请弹出视图
 */
- (void)prepareSubmitAlertController
{
    _submitAlertController = [UIAlertController alertControllerWithTitle:@"重置密码成功，请重新登录！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
            DBLog(@"%@",res);
        }];
        __strong typeof(weakSelf)strongSelf = weakSelf;
        NSLog(@"123");
        FBLoginViewController *login = [[FBLoginViewController alloc]init];
        login.loginUserName = _phoneNumberTF.text;
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_BEFOR_LOGIN];
        
        [UserInfo clearUserDefaults];
        [HeaderInfo tearDown];
        
        FBNavigationController *nav=[[FBNavigationController alloc]initWithRootViewController:login];
        [strongSelf presentViewController:nav animated:YES completion:nil];
    }];
    
    [_submitAlertController addAction:ok];
}

//提交重新登录确认
-(void)toLoginAgain
{
    [self presentViewController:_submitAlertController animated:YES completion:nil];
}


//点击验证码按钮
- (IBAction)onClickVcodeBtn:(id)sender {
    
    if (![PublicMethod isNetworkEnabled]) {
        
        [MBProgressHUD showError:@"网络出错!"];
        return;
    }
    
    [self hideKeyboard];
    
    if(!StringNotNilAndNull(_phoneNumberTF.text)) {
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    
    if (![_phoneNumberTF.text checkPhoneNumberInput] ) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    
    //网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_phoneNumberTF.text forKey:@"mobile"];
    
    WeakSelf(weakSelf);
    
    [OCNetworkingTool POSTWithUrl:getVode() withParams:params success:^(id responseObject) {
        
//        DBLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 500) {
            [MBProgressHUD showError:@"验证码已发送，请稍后再试"];
        }
        if ([[responseObject objectForKey:@"success"] intValue] == 1) {
            weakSelf.codeLabel.textColor = [UIColor lightGrayColor];
            _second = 60;
            
            if (_timer) {
                [_timer fire];
            } else {
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
            }
        }else{
            
        }
        
    } fail:^(NSError *error) {

        [MBProgressHUD showError:@"获取验证码失败,请稍后再试!"];
    }];
}

//定时器
- (void)timing
{
    _second--;                                                      // 时间递减
    NSString *title = [NSString stringWithFormat:@"%ld秒后重发", (long)_second];
    _codeLabel.text = title;      // 修改按钮文字模拟计时
    
    if (_second < 1) {
        [_timer invalidate];
        _codeLabel.text = @"获取验证码";
        _codeLabel.textColor = [UIColor colorWithRed:40/255.0 green:130/255.0 blue:224/255.0 alpha:1];
        _timer = nil;
    }                          // 倒计时到0时取消计时器
    _codeBtn.enabled = _second < 1;
}


//确认提交
- (IBAction)onClickSubmitBtn:(id)sender {
    
    if (![PublicMethod isNetworkEnabled]) {
        
        [MBProgressHUD showError:@"网络出错!"];
        return;
    }
    
    [self hideKeyboard];
    if(!StringNotNilAndNull(_phoneNumberTF.text)) {
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    if (!StringNotNilAndNull(_vCodeTF.text)) {
        [MBProgressHUD showError:@"验证码不能为空"];
        return;
    }
    if (!StringNotNilAndNull(_passwordTF.text)) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    if (!StringNotNilAndNull(_comfirPasswordTF.text)) {
        [MBProgressHUD showError:@"确认密码不能为空"];
        return;
    }
    if (![_phoneNumberTF.text checkPhoneNumberInput] ) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (![_passwordTF.text isEqualToString:_comfirPasswordTF.text])
    {
        [MBProgressHUD showError:@"密码与确认密码不一致"];
        return;
    }
    [self getSecret];
}

- (void)toResetPassword
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:_RSAString forKey:@"password"];
    [dict setValue:_phoneNumberTF.text forKey:@"mobile"];
    [dict setValue:_vCodeTF.text forKey:@"vcode"];
    WeakSelf(weakSelf);
    [OCNetworkingTool POSTWithUrl:resetPasswordUrl() withParams:dict success:^(id responseObject) {
//        DBLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 200) {
            
            if (_flag == YES) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [MBProgressHUD showSuccess:@"设置新密码成功"];
            }else{
                
                [self toLoginAgain];
            }
        }else{
            if ([responseObject[@"code"] integerValue] == 553) {
                
            }else{
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } fail:^(NSError *error) {
        
        [MBProgressHUD showError:@"设置密码失败，请检查网络"];
    }];

}

//拿到膜和指数，并进行加密
-(void)getSecret
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:_phoneNumberTF.text forKey:@"UserName"];
    [OCNetworkingTool POSTWithUrl:getLoginKey() withParams:dict success:^(id responseObject) {
        
//        DBLog(@"%@",responseObject);
        NSDictionary *data =responseObject[@"data"];
        NSString *myId = data[@"id"];
        NSString *secret = data[@"secret"];
        NSArray *temp=[secret componentsSeparatedByString:@"-"];
        
        NSString *md5Str = [MyMD5 md5:_comfirPasswordTF.text];
        //获取当前时间戳
        NSDate *currentDate = [PublicMethod getLocalCurrentDate];
        long currentSeconds = [PublicMethod getSecondsWithDate:currentDate];
        NSString *mycurrentSeconds = [NSString stringWithFormat:@"%ld000",currentSeconds];
        NSString *rsaStr = [NSString stringWithFormat:@"%@@%@@%@",md5Str,_phoneNumberTF.text,mycurrentSeconds];
        
        _RSAString =  [NSString setPublicKey:[rsaStr UTF8String] Mod:[temp[1] UTF8String] Exp:[temp[0] UTF8String]];
        _RSAString = [NSString stringWithFormat:@"%@@%@",_RSAString,myId];
        
        [self toResetPassword];
        
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"设置密码失败，请检查网络"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
