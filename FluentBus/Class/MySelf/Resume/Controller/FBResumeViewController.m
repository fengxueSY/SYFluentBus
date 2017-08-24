//
//  FBResumeViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBResumeViewController.h"
#import "FBMySettingCell.h"
#import "FBAlterNameViewController.h"
#import "FBResumeModel.h"
@interface FBResumeViewController ()<UIActionSheetDelegate,ZHPickViewDelegate,FBAlterNameViewControllerDelegate>{
    NSArray * headTitle;
    NSString * sexStr;
    NSString * nameStr;
    NSString * birthSty;
}
@property (nonatomic,strong) UIButton * disButton;
@end

@implementation FBResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBaseUI];
    [self https];
}
-(void)https{
    [MBProgressHUD showMessage:@"获取数据中" toView:self.view];
    [FBResumeModel getUserInfoSuccess:^(id successed) {
        FBResumeModel * model = successed;
        nameStr = model.nickname;
        if ([model.sex integerValue] == 0) {
            sexStr = @"女";
        }else if ([model.sex integerValue] == 1){
            sexStr = @"男";
        }else{
            sexStr = @"保密";
        }
        birthSty = model.birthday;
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view];
    } Fail:^(id failed) {
        [MBProgressHUD showError:failed];
        [MBProgressHUD hideHUDForView:self.view];
    }];
}
-(void)creatBaseUI{
    self.title = @"个人资料";
    headTitle = @[@"昵称",@"性别",@"生日"];
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = backCommonlyUsedColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return headTitle.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor = backCommonlyUsedColor;
    return headView;
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
    cell.backgroundColor = whiteUnifyColor;
    cell.headLabel.text = headTitle[indexPath.row];
    if (indexPath.row == 0) {
        cell.footLabel.text = nameStr;
    }else if (indexPath.row == 1){
        cell.footLabel.text = sexStr;
    }else{
        cell.footLabel.text = birthSty;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FBAlterNameViewController * alterName = [[FBAlterNameViewController alloc]init];
        alterName.delegate = self;
        alterName.sexStr = sexStr;
        alterName.birthStr = birthSty;
        [self.navigationController pushViewController:alterName animated:YES];
    }
    if (indexPath.row == 1) {
        UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",@"保密", nil];
        [sheet showInView:self.view];
    }
    if (indexPath.row == 2) {
        [self showDisButton];
        ZHPickView * pick = [[ZHPickView alloc]initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        pick.delegate = self;
        [pick show];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([sexStr isEqualToString:@"男"]) {

        }else{
            sexStr = @"男";
            [self alterResumeHttps];
        }
    }
    if (buttonIndex == 1){
        if ([sexStr isEqualToString:@"女"]) {
            
        }else{
            sexStr = @"女";
            [self alterResumeHttps];
        }
    }
    if (buttonIndex == 2){
        if ([sexStr isEqualToString:@"保密"]) {
            
        }else{
            sexStr = @"保密";
            [self alterResumeHttps];
        }
    }
}
-(UIButton *)disButton{
    if (!_disButton) {
        _disButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _disButton.backgroundColor = [UIColor blackColor];
        _disButton.alpha = 0.2;
        [self.view addSubview:_disButton];
    }
    return _disButton;
}
-(void)showDisButton{
    self.disButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
-(void)hideDisButton{
    self.disButton.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSArray * dateA = [resultString componentsSeparatedByString:@" "];
    if ([birthSty isEqualToString:dateA[0]]) {
        [self hideDisButton];
    }else{
        birthSty = dateA[0];
        [self alterResumeHttps];
        [self hideDisButton];
    }
}
-(void)cancanlButton{
    [self hideDisButton];
}
-(void)alterName:(NSString *)name{
    nameStr = name;
    [_tableView reloadData];
}
#pragma mark - 修改个人资料
-(void)alterResumeHttps{
    [MBProgressHUD showMessage:@"修改中" toView:self.view];
    NSString * sex;
    if ([sexStr isEqualToString:@"男"]) {
        sex = @"1";
    }else if ([sexStr isEqualToString:@"女"]){
        sex = @"0";
    }else{
        sex = @"2";
    }

    
//    NSDictionary *  sendDic = @{@"uid":self.baseUserInfo.userId,@"sex":sex,@"birthday":birthSty,@"nickname":nameStr};

    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc]init];
    [dataDic setValue:self.baseUserInfo.userId forKey:@"uid"];
    [dataDic setValue:sex forKey:@"sex"];
    [dataDic setValue:birthSty forKey:@"birthday"];
    [dataDic setValue:nameStr forKey:@"nickname"];
    
    NSDictionary *  sendDic = [[NSDictionary alloc]initWithDictionary:dataDic];;

    [OCNetworkingTool POSTWithUrl:alterUserInfo() withParams:sendDic success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [_tableView reloadData];
        }else{
            TTAlert1(@"修改失败，请重新修改", self);
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        TTAlert1(@"网络错误，请重新修改", self);
    }];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
