//
//  FBMyTicketViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMyTicketViewController.h"
#import "FBMyTicketCell.h"
#import "FBMyTicketDetailedViewController.h"
#import "JF_CalendarView.h"
#import "FBDefaultImageView.h"
#import "FBTicketDetailListModel.h"
#import "FBRouteViewController.h"
@interface FBMyTicketViewController ()<FBMyTicketCellDelegate,JF_CalendarViewDelegate,FBDefaultImageViewDelegate>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, strong) NSMutableArray *modelArray;

@property(nonatomic,strong) JF_CalendarView *calendarView;
//自定义View
@property (nonatomic,strong) UIView *blackView;
//默认图片
@property (nonatomic,strong) FBDefaultImageView * defaultImageView;
@end

@implementation FBMyTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.liftButtonItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.liftButtonItem];
    
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.title = @"我的车票";
    [self creatBaseUI];
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//布局tableView
-(void)creatBaseUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 131;
    self.tableView.backgroundColor = backCommonlyUsedColor;
    [self.view addSubview:_tableView];
    
    
    WeakSelf(weakSelf);
    
    //头部刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        
        [weakSelf getMyTicketListWithPage:1];
    }];
    
    //底部加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.modelArray.count < 20) {
            [MBProgressHUD showError:@"已经是最后一页了"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else{
            
            NSInteger b = self.modelArray.count % 20;
            if (b == 0) {
                [self getMyTicketListWithPage:self.page+1];
                self.page = self.page + 1;
                
            }else{
                [MBProgressHUD showError:@"已经是最后一页了"];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
            
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

//网络请求车票列表
- (void)getMyTicketListWithPage:(NSInteger)page
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(page) forKey:@"PageIndex"];
    [dict setObject:@(20) forKey:@"PageSize"];
    
    [OCNetworkingTool POSTWithUrl:userTicketList() withParams:dict success:^(id responseObject) {
        
        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject[@"code"] integerValue] == 200) {
            
            if (self.page ==1) {
                
                [self.modelArray removeAllObjects];
            }
            
            NSArray *dataArray = responseObject[@"data"];
            if (dataArray.count>0) {
                for (NSDictionary *dic in dataArray) {
                    FBTicketDetailListModel *model = [FBTicketDetailListModel new];
                    model.classId = dic[@"classId"];
                    model.orderId = dic[@"orderId"];
                    model.routeId = dic[@"routeId"];
                    model.productId = dic[@"productId"];
                    model.staName = dic[@"staName"];
                    model.endName = dic[@"endName"];
                    NSString *timeStr = [NSString stringWithFormat:@"%@",dic[@"validDate"]];
                    if (timeStr.length >=10) {
                        timeStr = [timeStr substringToIndex:[timeStr length] - 3];
                    }
                    model.validDate = [self getTime:timeStr];
                    model.dayCount = [NSString stringWithFormat:@"%@",dic[@"dayCount"]];
                    model.classTime = dic[@"classTime"];
                    model.upStationName = dic[@"upStationName"];
//                    model.productType = [dic[@"productType"] integerValue];
                    model.productTypeName = dic[@"productTypeName"];
                    model.platNo = dic[@"platNo"];
                    model.ticket = dic[@"ticket"];
                    model.dateList = dic[@"dateList"];
                    [self.modelArray addObject: model];
                }
                [self hideDefaultImageView];
                [self.tableView reloadData];
                
            }else{
                if (page == 1) {
                    [self showDefaultImageView];
                    [MBProgressHUD showError:@"暂无数据"];
                }else{
                    [MBProgressHUD showError:@"已经是最后一页了"];
                }
            }
            
        }else{
            
            [self showDefaultImageView];
            [MBProgressHUD showError:@"获取车票列表失败！"];
        }
    } fail:^(NSError *error) {
        
        [self showDefaultImageView];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"获取车票列表失败！"];
    }];
}

#pragma mark -  是否显示无车票的默认界面
-(void)showDefaultImageView{
    self.defaultImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

-(void)hideDefaultImageView{
    [self.defaultImageView removeFromSuperview];
}

//修改tabbar
-(void)changeTabBar{
    self.tabBarController.selectedIndex = 1;
}

#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FBMyTicketCell * cell = [FBMyTicketCell cellTableView:tableView];
    FBTicketDetailListModel *model = self.modelArray[indexPath.row];
    
    cell.model = model;
    
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBMyTicketDetailedViewController *detailedCtl = [[FBMyTicketDetailedViewController alloc]init];
    
    FBTicketDetailListModel *model = self.modelArray[indexPath.row];
    detailedCtl.model = model;
    [self.navigationController pushViewController:detailedCtl animated:YES];
}

#pragma mark - cell代理
#pragma mark -  显示日历
-(void)showCalendar:(NSArray *)array{
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing=0;
    self.calendarView=[[JF_CalendarView alloc]initWithFrame:CGRectMake(0, 30, 300, 350) collectionViewLayout:layout];
    self.calendarView.myDelegate = self;
    NSMutableArray *calendarArray = [NSMutableArray array];
    if (ArrayNotNilAndNull(array)) {
        for (NSNumber *timeNum in array) {
            NSString *timeStr = [NSString stringWithFormat:@"%@",timeNum];
            if (timeStr.length >=10) {
                timeStr = [timeStr substringToIndex:[timeStr length] - 3];
                [calendarArray addObject: [self getTimeb:timeStr]];
            }
        }
    }
    [self.calendarView.registerArr addObjectsFromArray:[calendarArray copy]];
    //  self.calendarView.backgroundColor=[UIColor purpleColor];
    self.calendarView.center=self.view.center;
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.calendarView];
}


//日历关闭回调
-(void)toClosecalendarView
{
    [self.blackView removeFromSuperview];
    [self.calendarView removeFromSuperview];
}

//跳转地图
- (void)showMap:(FBTicketDetailListModel *)model
{
    FBRouteViewController *routeCtl = [[FBRouteViewController alloc]init];
    routeCtl.viewStyle = @"3";
    if (model.routeId == nil) {
        TTAlert1(@"数据获取失败，请刷新本页数据", self);
        return;
    }
    routeCtl.ticketListmodel = model;
    [self.navigationController pushViewController:routeCtl animated:YES];
}

#pragma mark - 私有方法
//去掉毫秒后的时间
-(NSString *)getTime:(NSString *)time{
    NSDate  *localeDate = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *strDate = [dateFormatter stringFromDate:localeDate];
    
    return strDate;
}

//去掉毫秒后的时间
-(NSString *)getTimeb:(NSString *)time{
    NSDate  *localeDate = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *strDate = [dateFormatter stringFromDate:localeDate];
    
    return strDate;
}

#pragma mark - 懒加载
- (NSMutableArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (UIView *)blackView
{
    if (_blackView ==nil) {
        
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.3;
    }
    return _blackView;
}

-(FBDefaultImageView *)defaultImageView{
    if (!_defaultImageView) {
        _defaultImageView = [[FBDefaultImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Text:@"您还没有车票,立即订购" MakeRange:0 TextColor:UIColorFromRGB(0x888888)];
        _defaultImageView.userInteractionEnabled = YES;
        _defaultImageView.delegate = self;
        [self.tableView addSubview:_defaultImageView];
    }
    return _defaultImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end