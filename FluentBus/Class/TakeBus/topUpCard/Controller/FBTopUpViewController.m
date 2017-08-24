//
//  FBTopUpViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBTopUpViewController.h"
#import "FBTopUpCell.h"
#import "FBTopUpMidView.h"
#import "FBWeiXinPay.h"
#import "FBMoneyInfo.h"

static NSString * cellID = @"ID";
@interface FBTopUpViewController ()<FBTopUpMidViewDelegate>{
    NSArray * prefrernitalArray;/**<优惠内容*/
    NSInteger  _moneyStr;
    FBTopUpMidView * midCell;
    NSInteger oneNumer;
    FBMoneyInfo * moneyModel;
}

@end

@implementation FBTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBaseUI];
    
}
-(void)creatBaseUI{
    self.title = @"充值";
    oneNumer = 0;
    _moneyStr = 0.01;
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    [self getRechargeApp];
    prefrernitalArray = @[@"当前优惠",@"1,冲100送500",@"2,冲200送美女",@"3,冲500送广州市内三室一厅一套",@"4,本活动截止日期：2016-21-21"];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = backCommonlyUsedColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return prefrernitalArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 190;
    }else if (indexPath.section == 2) {
        return 35;
    }else{
        return 50;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isReg = NO;
    if (!isReg) {
        [_tableView registerNib:[UINib nibWithNibName:@"FBTopUpCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    FBTopUpCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = backCommonlyUsedColor;

    if (indexPath.section == 0) {
        cell.ThreeLabel.hidden = YES;
        if (oneNumer == indexPath.row) {
            cell.oneFootImageView.hidden = NO;
        }else{
            cell.oneFootImageView.hidden = YES;
        }
    }else if (indexPath.section == 1){
        cell.onePayLabel.hidden = YES;
        cell.oneHeadImageView.hidden = YES;
        cell.oneFootImageView.hidden = YES;
        cell.ThreeLabel.hidden = YES;
        cell.backView.hidden = YES;
        if (indexPath.row == 0) {
            midCell = [[[NSBundle mainBundle]loadNibNamed:@"FBTopUpMidView" owner:self options:0]lastObject];
            midCell.delegate = self;
            midCell.backgroundColor = backCommonlyUsedColor;
            midCell.userInteractionEnabled = YES;
            [midCell.goPayMoneyButton addTarget:self action:@selector(goPayMoneyButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [midCell.button_50 addTarget:self action:@selector(button_50Action) forControlEvents:UIControlEventTouchUpInside];
             [midCell.button_100 addTarget:self action:@selector(button_100Action) forControlEvents:UIControlEventTouchUpInside];
             [midCell.button_200 addTarget:self action:@selector(button_200Action) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:midCell];
        
            midCell.translatesAutoresizingMaskIntoConstraints = NO;
            midCell.goPayMoneyButton.translatesAutoresizingMaskIntoConstraints = NO;
            [midCell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.top.bottom.equalTo(cell.contentView);
            }];
#pragma mark - 根据参数判断这里是否显示金额的输入框
            midCell.writeMoneyNumberTextFile.hidden = YES;
            [midCell.goPayMoneyButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(midCell.button_50.mas_bottom).offset(30);
            }];
        }
    }else{
        cell.backView.backgroundColor = backCommonlyUsedColor;
        cell.oneFootImageView.hidden = YES;
        cell.oneHeadImageView.hidden = YES;
        cell.onePayLabel.hidden = YES;
        cell.ThreeLabel.hidden = NO;
        if (indexPath.row == 1 || indexPath.row == 2) {
            cell.ThreeLabel.textColor = [UIColor redColor];
        }
        cell.ThreeLabel.text = prefrernitalArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        FBTopUpCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//        [cell setSelected:YES animated:YES];
        oneNumer = indexPath.row;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma mark - 选中充值金额
-(void)button_50Action{
    [self setButtonBackColorOrTextColor:midCell.button_100];
    [self setButtonBackColorOrTextColor:midCell.button_200];
    [self setButtonBackColor:midCell.button_50];
    _moneyStr = 0.01;
}
-(void)button_100Action{
    [self setButtonBackColorOrTextColor:midCell.button_50];
    [self setButtonBackColorOrTextColor:midCell.button_200];
    [self setButtonBackColor:midCell.button_100];
    _moneyStr = 100;
}
-(void)button_200Action{
    [self setButtonBackColorOrTextColor:midCell.button_50];
    [self setButtonBackColorOrTextColor:midCell.button_100];
    [self setButtonBackColor:midCell.button_200];
    _moneyStr = 200;
}
-(void)setButtonBackColorOrTextColor:(UIButton *)sender{
    [sender setTitleColor:blueUnifyColor forState:UIControlStateNormal];
    sender.backgroundColor = whiteUnifyColor;
    [sender.layer setBorderColor:blueUnifyColor.CGColor];
    [sender.layer setBorderWidth:1];
}
-(void)setButtonBackColor:(UIButton *)sender{
    [sender setTitleColor:whiteUnifyColor forState:UIControlStateNormal];
    sender.backgroundColor = blueUnifyColor;
}
#pragma mark -  充值
-(void)goPayMoneyButtonAction{
    DBLog(@"查看要充值的jine   %ld",(long)_moneyStr);
    [MBProgressHUD showMessage:@"充值中" toView:self.view];
    NSDictionary * payDic = @{@"merchantId":@"100401",@"payAmount":[NSNumber numberWithInteger:_moneyStr * 100]};
    [OCNetworkingTool POSTWithUrl:orderWltrec() withParams:payDic success:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        if ([dic objectForKey:@"data"] != nil) {
            NSDictionary * dataDic = [dic objectForKey:@"data"];
            [self WeiXinPayOrderID:[dataDic objectForKey:@"orderId"] SerialId:[dataDic objectForKey:@"serialId"]];
        }else{
            TTAlert1(@"支付失败，请重新支付", self);
            [MBProgressHUD hideHUDForView:self.view];
        }
    } fail:^(NSError *error) {
        TTAlert1(@"支付失败，请重新支付", self);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}
-(void)WeiXinPayOrderID:(NSString *)orderID SerialId:(NSString *)serialId{
    if (![WXApi isWXAppInstalled]) {
        TTAlert1(@"未检测到微信，请安装微信后重试", self);
        return;
    }
    if (![WXApi isWXAppSupportApi]) {
        TTAlert1(@"您安装的微信版本暂不支持微信支付，请升级后重试", self);
        return;
    }
    [FBWeiXinPay treatWeiXinPaySerialId:serialId Success:^(id successed) {
        [MBProgressHUD hideHUDForView:self.view];

    } Fail:^(id failed) {
        TTAlert1(failed, self);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}
-(void)getOrderPayResult:(NSNotification *)sender{
    [MBProgressHUD hideHUDForView:self.view];
    NSDictionary * dic = [sender userInfo];
    if ([[dic objectForKey:@"WeiXinPay"] isEqualToString:@"成功"]) {
        TTAlert1(@"支付成功!", self);
    
    }
    if ([[dic objectForKey:@"WeiXinPay"] isEqualToString:@"失败"]) {
        TTAlert1(@"支付失败，请重新支付", self);
    }
    if ([[dic objectForKey:@"WeiXinPay"] isEqualToString:@"取消"]) {
        TTAlert1(@"支付已取消", self);
    }
}
#pragma mark - 查看用户协议
-(void)watchUserDelegate{
    TTAlert1(@"用户协议暂未发布", self);
}
-(void)getRechargeApp{
    [OCNetworkingTool POSTWithUrl:getRechargeApp() withParams:nil success:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        if ([dic objectForKey:@"data"] != nil && [[dic objectForKey:@"code"] integerValue] == 200) {
            moneyModel = [FBMoneyInfo yy_modelWithDictionary:[dic objectForKey:@"data"]];
        }else{
               
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)goBack{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WXPay" object:nil];;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
