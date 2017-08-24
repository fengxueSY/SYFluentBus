//
//  FBNewNeedViewController.m
//  FluentBus
//
//  Created by 张俊辉 on 16/12/29.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBNewNeedViewController.h"
#import "CustomDatePickerView.h"
#import "XWUSelectPlaceFromMapViewController.h"
#import "XWUMapPlaceModel.h"
#import "OCUCustomSelectView.h"
#import "FBDefaultImageView.h"
@interface FBNewNeedViewController ()
{
    UIWindow *_window;
    double _startLongitude;
    double _startLatitude;
    double _endLongtitude;
    double _endLatitude;
}

//自定义View
@property (nonatomic,strong) UIView *blackView;
@property (weak, nonatomic) IBOutlet UITextField *startAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *endAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UIButton *onClickStartNeedBtn;



@end

@implementation FBNewNeedViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GetPlaceFromMapNotifacation" object:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _window = [UIApplication sharedApplication].keyWindow;
    
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    self.title = @"发起新需求";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPlaceFromMap:) name:@"GetPlaceFromMapNotifacation" object:nil];
    
    self.onClickStartNeedBtn.backgroundColor = greenUnifyColor;
    [self.onClickStartNeedBtn.layer setMasksToBounds:YES];
    [self.onClickStartNeedBtn.layer setCornerRadius:5];
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 选地点

//选择出发地点
- (IBAction)onClickStartBtn:(id)sender {

    XWUSelectPlaceFromMapViewController *VC = [[XWUSelectPlaceFromMapViewController alloc]init];
    VC.placeType = SqFromPlace;
    [self.navigationController pushViewController:VC animated:YES];
}

//选择目的地点
- (IBAction)onclickEndBtn:(id)sender {
    
    XWUSelectPlaceFromMapViewController *VC = [[XWUSelectPlaceFromMapViewController alloc]init];
    VC.placeType = SqToPlace;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 监听地图获取地点的回调方法
 */
- (void)getPlaceFromMap:(NSNotification *)notification  {
    // 返回的地点模型
    XWUMapPlaceModel *place = (XWUMapPlaceModel *)notification.object;
    // 预留经纬度数据
    /*NSString *data = [NSString stringWithFormat:@"%f,%f",place.coordinate.longitude,place.coordinate.latitude];*/
//    self.toPlaceTxt.text = place.name;
    
    OCUSQPlaceType type = [[notification.userInfo valueForKey:@"PlaceType"] integerValue];
    
    switch (type) {
        case SqFromPlace: // 返回的出发地
            DBLog(@"%@",place.name);
            self.startAddressTF.text = place.name;
            _startLatitude = place.coordinate.latitude;
            _startLongitude = place.coordinate.longitude;
            break;
        case SqToPlace: // 返回的目的地
            self.endAddressTF.text = place.name;
            _endLatitude = place.coordinate.latitude;
            _endLongtitude = place.coordinate.longitude;
            break;
        default:
            break;
    }
    
}

#pragma mark - 选时间
//选择出发时间
- (IBAction)onclickStartTime:(id)sender {
    
    CustomDatePickerView *pickerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomDatePickerView" owner:self options:nil] lastObject];
    pickerView.frame = CGRectMake(0, SCREEN_HEIGHT-180, SCREEN_WIDTH, 180);
    pickerView.clipsToBounds = YES;
    [_window addSubview:self.blackView];
    [_window addSubview:pickerView];
    __weak typeof(self) ws = self;
    __weak typeof (pickerView) wp = pickerView;
    pickerView.dismissBlock = ^(){
        __strong typeof(ws) ss = ws;
        __strong typeof (wp) sp = wp;
        [ss.blackView removeFromSuperview];
        [sp removeFromSuperview];
        
    };
    pickerView.sureBlock = ^(){
        __strong typeof(ws) ss = ws;
        __strong typeof (wp) sp = wp;
        //获取开始时间
        self.startTimeTF.text = [NSString stringWithFormat:@"%.2d:%.2d",sp.hmPickerView.hour,sp.hmPickerView.minute];
        [ss.blackView removeFromSuperview];
        [sp removeFromSuperview];
    };
    
}

//选择返程时间
- (IBAction)onclickEndTime:(id)sender {
    
    CustomDatePickerView *pickerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomDatePickerView" owner:self options:nil] lastObject];
    pickerView.frame = CGRectMake(0, SCREEN_HEIGHT-180, SCREEN_WIDTH, 180);
    pickerView.clipsToBounds = YES;
    [_window addSubview:self.blackView];
    [_window addSubview:pickerView];
    __weak typeof(self) ws = self;
    __weak typeof (pickerView) wp = pickerView;
    pickerView.dismissBlock = ^(){
        __strong typeof(ws) ss = ws;
        __strong typeof (wp) sp = wp;
        [ss.blackView removeFromSuperview];
        [sp removeFromSuperview];
        
    };
    pickerView.sureBlock = ^(){
        __strong typeof(ws) ss = ws;
        __strong typeof (wp) sp = wp;
        //获取返程时间
        self.endTimeTF.text = [NSString stringWithFormat:@"%.2d:%.2d",sp.hmPickerView.hour,sp.hmPickerView.minute];
        [ss.blackView removeFromSuperview];
        [sp removeFromSuperview];
    };
    
}

#pragma  mark - 选类型
//选择乘车类型
- (IBAction)onclickType:(id)sender {
    
    OCUCustomSelectView *selectLicense = [OCUCustomSelectView customSelectView];
    
    selectLicense.dataSource = [NSMutableArray arrayWithArray:@[@"上下班",@"节日出行",@"其他"]];
    
    selectLicense.frame = CGRectMake(0, SCREEN_HEIGHT-180,SCREEN_WIDTH , 180);
    [_window addSubview:self.blackView];
    [_window addSubview:selectLicense];
    __weak typeof(selectLicense)weakSelectLicense = selectLicense;
    selectLicense.selectViewCallback = ^(NSString *licenseType, NSInteger index){
        if (licenseType == nil) {
            [self.blackView removeFromSuperview];
            [weakSelectLicense removeFromSuperview];
        } else {
            DBLog(@"%@",licenseType);
            self.typeTF.text = licenseType;
            [self.blackView removeFromSuperview];
            [weakSelectLicense removeFromSuperview];
        }
    };
}

#pragma mark - 懒加载
- (UIView *)blackView
{
    if (_blackView ==nil) {
        
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.3;
    }
    return _blackView;
}

//发起需求
- (IBAction)onClickStartNeedBtn:(id)sender {
    
    if (!StringNotNilAndNull(self.startAddressTF.text)) {
        [MBProgressHUD showError:@"请选择出发地点"];
        return;
    }
    if (!StringNotNilAndNull(self.endAddressTF.text)) {
        [MBProgressHUD showError:@"请选择目的地点"];
        return;
    }
    if (!StringNotNilAndNull(self.startTimeTF.text)) {
         [MBProgressHUD showError:@"请选择出发时间"];
        return;
    }
    if (!StringNotNilAndNull(self.endTimeTF.text)) {
        [MBProgressHUD showError:@"请选择返程时间"];
        return;
    }
    if (!StringNotNilAndNull(self.typeTF.text)) {
        [MBProgressHUD showError:@"请选择出行类型"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if ([_typeTF.text isEqualToString:@"上下班"]) {
        [param setObject:@(0) forKey:@"dtype"];
    }
    if ([_typeTF.text isEqualToString:@"节日出行"]) {
        [param setObject:@(1) forKey:@"dtype"];
    }
    if ([_typeTF.text isEqualToString:@"其他"]) {
        [param setObject:@(2) forKey:@"dtype"];
    }
    
    [param setObject:_startAddressTF.text forKey:@"staname"];
    [param setObject:_endAddressTF.text forKey:@"etaname"];
    [param setObject:@(0) forKey:@"mtype"];
    [param setObject:_startTimeTF.text forKey:@"starttime"];
    [param setObject:_endTimeTF.text forKey:@"endtime"];
    [param setObject:@(_startLatitude) forKey:@"mslat"];
    [param setObject:@(_startLongitude) forKey:@"mslng"];
    [param setObject:@(_endLatitude) forKey:@"melat"];
    [param setObject:@(_endLongtitude) forKey:@"melng"];
    [param setObject:[UserInfo userInfoWithUserDefaults].userId forKey:@"creator"];
    
    [OCNetworkingTool POSTWithUrl:DemandCommitDemandUrl() withParams:param success:^(id responseObject) {
        DBLog(@"%@",responseObject);
        
        if([responseObject[@"code"] integerValue] == 200){
            [MBProgressHUD showSuccess:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发起需求失败，请稍后再试"];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end