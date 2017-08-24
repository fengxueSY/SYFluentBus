//
//  FBMySettingViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMySettingViewController.h"
#import "FBMySettingCell.h"
#import "FBChangePhoneFirstViewController.h"
#import "FBResetPasswordViewController.h"
#import "FBLoginViewController.h"
#import "FBNavigationController.h"
#import <CloudPushSDK/CloudPushSDK.h>

@interface FBMySettingViewController (){
    NSArray * headTitle;
    NSString * bufferStr;//缓存的大小
}

@end

@implementation FBMySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBaseUI];
}
-(void)creatBaseUI{
    self.title = @"设置";
//    bufferStr = [NSString stringWithFormat:@"%u.%u M",arc4random()%20,arc4random()%9];
    bufferStr = @"0.0 M";
    headTitle = @[@"重置密码",@"更换手机号",@"清除缓存",@"版本号"];
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = backCommonlyUsedColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 50;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor = backCommonlyUsedColor;
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc]init];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH / 8, 50, SCREEN_WIDTH * 6 / 8, 40);
    button.backgroundColor = blueUnifyColor;
    [button setTitle:@"退出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickExitBtn) forControlEvents:UIControlEventTouchUpInside];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5];
    [footView addSubview:button];
    return footView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"ID";
    BOOL isReg = NO;
    if (!isReg) {
        [_tableView registerNib:[UINib nibWithNibName:@"FBMySettingCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    FBMySettingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor whiteColor];
    cell.headLabel.text = headTitle[indexPath.row];
    if (indexPath.row == 3) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.footLabel.text = app_Version;
    }else if (indexPath.row == 2) {
        cell.footLabel.text = bufferStr;
    }else{
        cell.footLabel.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            [self.navigationController pushViewController:[FBResetPasswordViewController new] animated:YES];
        }
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[FBChangePhoneFirstViewController new] animated:YES];
        }
        if (indexPath.row == 2) {
            [MBProgressHUD showMessage:@"清理中" toView:self.view];
            NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
            [timer fire];
        }
    }
}
-(void)timerAction{
    bufferStr = @"0.0 M";
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showSuccess:@"清理成功"];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//退出按钮
- (void)onClickExitBtn
{
    [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
        DBLog(@"%@",res);
    }];
    FBLoginViewController *login = [[FBLoginViewController alloc]init];
    login.loginUserName = [UserInfo userInfoWithUserDefaults].userName;
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:  User_IS_BEFOR_LOGIN];
    [UserInfo clearUserDefaults];
    [HeaderInfo tearDown];
    
    FBNavigationController *nav=[[FBNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
