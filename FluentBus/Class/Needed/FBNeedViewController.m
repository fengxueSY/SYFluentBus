//
//  FBNeedViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBNeedViewController.h"
#import "FBNeedListTableViewCell.h"
#import "FBNewNeedViewController.h"
#import "FBNeedListModel.h"
#import "FBRouteViewController.h"
#import "FBDefaultImageView.h"

@interface FBNeedViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property(nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) FBDefaultImageView * defaultImageView;


@end

@implementation FBNeedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发起新需求" target:self action:@selector(toMakeNewNeed)];
    //布局tableView
    [self creatBaseUI];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
//发起新需求
- (void)toMakeNewNeed
{
     [self.navigationController pushViewController:[FBNewNeedViewController new] animated:YES];
}

//布局tableView
-(void)creatBaseUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 139;
    self.tableView.backgroundColor = backCommonlyUsedColor;
    [self.view addSubview:_tableView];
    
    //约束_taskTableView
    WeakSelf(weakSelf);
    
    //头部刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        
        [weakSelf getNeedListWithPage:0];
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
                [self getNeedListWithPage:self.page+1];
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

//获取列表数据
- (void)getNeedListWithPage:(NSInteger)page
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(page) forKey:@"PageIndex"];
    [dict setObject:@(20) forKey:@"PageSize"];
    
    [OCNetworkingTool POSTWithUrl:getNeedListUrl() withParams:dict success:^(id responseObject) {
        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject[@"code"] integerValue] == 200) {
            
            NSArray *array = responseObject[@"data"];
            if (self.page ==0) {
                
                [self.modelArray removeAllObjects];
            }
            
            if (array.count == 0) {
                if (page == 0) {
                     [self showDefaultImageView];
//                    [MBProgressHUD showError:@"暂无数据"];
                }else{
                    [MBProgressHUD showError:@"已经是最后一页了"];
                }
            }else{
                
                for (NSDictionary *dict in array) {
                    FBNeedListModel *model =[FBNeedListModel new];
                    model.startStation = dict[@"startStation"];
                    model.endStation = dict[@"endStation"];
                    model.stime = dict[@"stime"];
                    model.mprice = [NSString stringWithFormat:@"%.2f",[dict[@"mprice"] floatValue]/100];
                    model.aprice = [NSString stringWithFormat:@"%.2f",[dict[@"aprice"] floatValue]/100];
                    model.votedCount = [NSString stringWithFormat:@"%@",dict[@"votedCount"]];
                    model.myId = dict[@"id"];
                    model.rid = dict[@"rid"];
                    model.ticketTypeName = dict[@"ticketTypeName"];
                    //拿路径数组
                    NSArray *array = dict[@"routeDescArry"];
                    NSMutableArray *modelArr = [NSMutableArray array];
                    if (array.count > 0) {
                        for (NSDictionary *dic in array) {
                            FBNeedListRouteModel *model = [FBNeedListRouteModel new];
                            model.staindex = [dic[@"staindex"] integerValue];
                            model.sname = dic[@"sname"];
                            [modelArr addObject:model];
                        }
                        
                        //拿完数据按升序排好
                        NSArray *result = [modelArr sortedArrayUsingComparator:^NSComparisonResult(FBNeedListRouteModel * obj1, FBNeedListRouteModel * obj2) {
                            
                            return [@(obj1.staindex) compare:@(obj2.staindex)]; //升序
                        }];
                        
                        //取出升序排列后数组内的sname并拼接成字符串
                        NSMutableArray *snameArray =[NSMutableArray array];
                        for (FBNeedListRouteModel *routeModel in result) {
                            NSString *sname = routeModel.sname;
                            [snameArray addObject:sname];
                        }

                        NSString *describtion = [snameArray componentsJoinedByString:@"-"];
                        //给model赋值
                        model.describtion = describtion;
                        [model.needRouteArray addObjectsFromArray:result];
                    }
                    [self.modelArray addObject:model];
                }
//                if (self.modelArray.count <= 0) {
//                    [self showDefaultImageView];
//                }else{
//                    [self hideDefaultImageView];
//                }
                 [self hideDefaultImageView];
                [self.tableView reloadData];
                
            }
        }else{
            [self showDefaultImageView];
        }
        
    } fail:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"请求列表失败，请稍后再试"];
    }];
}

//报名请求
- (void)toSignupRequestWithIndexRow:(NSInteger) indexPathRow{
    
    DBLog(@"%ld",indexPathRow);
    FBNeedListModel *model = self.modelArray[indexPathRow];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:model.myId forKey:@"did"];
    [param setValue:[UserInfo userInfoWithUserDefaults].userId forKey:@"userid"];
    
    
    [OCNetworkingTool POSTWithUrl:DemandvotedDemandUrl() withParams:param success:^(id responseObject) {
        DBLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 200) {
            
            TTAlert1(@"报名成功!", self);
        }
        if ([responseObject[@"code"] integerValue] == 1000) {
            
             TTAlert1(@"已经报过名了!", self);
        }
        
    } fail:^(NSError *error) {
        
        TTAlert1(@"报名失败，请稍后再试!", self);
    }];
}

#pragma mark - tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FBNeedListTableViewCell * cell = [FBNeedListTableViewCell cellTableView:tableView];
    
    FBNeedListModel *model = self.modelArray[indexPath.row];
    cell.model = model;
    
    //点击报名回调
    cell.btnBlack = ^(){
        [self toSignupRequestWithIndexRow:indexPath.row];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBNeedListModel *model = self.modelArray[indexPath.row];
    FBRouteViewController *routeCtl = [[FBRouteViewController alloc]init];
    routeCtl.viewStyle = @"1";
    if (model.rid == nil) {
        TTAlert1(@"数据获取失败，请刷新本页数据", self);
        return;
    }
    routeCtl.needListModel = model;
    [self.navigationController pushViewController:routeCtl animated:YES];
}
#pragma mark -  默认图标
-(FBDefaultImageView *)defaultImageView{
    if (!_defaultImageView) {
        _defaultImageView = [[FBDefaultImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Text:@"暂时没有新的需求" MakeRange:0 TextColor:UIColorFromRGB(0x888888)];
        _defaultImageView.userInteractionEnabled = YES;
        [self.tableView addSubview:_defaultImageView];
    }
    return _defaultImageView;
}
#pragma mark -  是否显示无车票的默认界面
-(void)showDefaultImageView{
    self.defaultImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

-(void)hideDefaultImageView{
    [self.defaultImageView removeFromSuperview];
}

#pragma mark - 懒加载
- (NSMutableArray *)modelArray
{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
