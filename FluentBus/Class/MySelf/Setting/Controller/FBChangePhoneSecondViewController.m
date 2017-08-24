//
//  FBChangePhoneSecondViewController.m
//  FluentBus
//
//  Created by 张俊辉 on 17/1/3.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBChangePhoneSecondViewController.h"
#import "FBLoginViewController.h"
#import "FBNavigationController.h"

@interface FBChangePhoneSecondViewController ()
{
    NSInteger _second;
    NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation FBChangePhoneSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更换手机号";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = backCommonlyUsedColor;

    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.clipsToBounds = YES;
    
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    
    //手势，点击结束编辑
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)hideKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//获取验证码
- (IBAction)onClickCodeBtn:(id)sender {
    
    [self hideKeyboard];
    
    if (![PublicMethod isNetworkEnabled]) {
        
        [MBProgressHUD showError:@"网络出错!"];
        return;
    }
    
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
        
        DBLog(@"%@",responseObject);
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
        DBLog(@"%@",error);
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

//确认更换
- (IBAction)onClickConfirmBtn:(id)sender {
    //网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_phoneNumberTF.text forKey:@"mobile"];
    [params setValue:_vCodeTF.text forKey:@"vcode"];
    
    [OCNetworkingTool POSTWithUrl:changeMobile() withParams:params success:^(id responseObject) {
        DBLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] integerValue] ==200) {
            [MBProgressHUD showSuccess:@"更换成功，请用新号码登录"];
            [self toLoginAgain];
        }else{
            [MBProgressHUD showError:@"验证失败"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"网络出错，请稍后再试"];
    }];

}

//重新登录
- (void)toLoginAgain
{
    FBLoginViewController *login = [[FBLoginViewController alloc]init];
    login.loginUserName = _phoneNumberTF.text;
    
    [UserInfo clearUserDefaults];
    [HeaderInfo tearDown];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_BEFOR_LOGIN];
    
    FBNavigationController *nav=[[FBNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
