//
//  FBTakeBusViewController.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBTakeBusViewController.h"
#import "FBTakeBusCollectionViewCell.h"
#import "FBRouteViewController.h"
#import "FBTopUpCardViewController.h"
#import "JF_CalendarView.h"
#import "FBTicketDetailListModel.h"
#import "FBDefaultImageView.h"

@interface FBTakeBusViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,FBTakeBusCollectionViewCellDelegate,JF_CalendarViewDelegate,FBDefaultImageViewDelegate>
{
    float _value;
    NSInteger _page;
}

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong) NSMutableArray *collectionDataSource;

@property (nonatomic,strong) FBDefaultImageView * defaultImageView;

@property(nonatomic,strong) JF_CalendarView *calendarView;

@property (nonatomic,strong) UIImageView *imageView;
//自定义View
@property (nonatomic,strong) UIView *blackView;

@property (nonatomic,strong) UIView *whiteView;

@end

@implementation FBTakeBusViewController

static NSString *Identifier = @"mytakeBusCell";

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _value = [UIScreen mainScreen].brightness;
    
    [self getTicketDetailsList];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIScreen mainScreen] setBrightness:_value];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"common_icon_nav" target:self action:@selector(toMap)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"储值卡" target:self action:@selector(toStoredValueCard)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toGetTicketList) name:@"DoneNotification" object:nil];
    
    
    [self setCollectionView];
    
}

#pragma mark - 监听自动登录拿完数据了

- (void)toGetTicketList
{
    [self getTicketDetailsList];
}

//地图跳转
-(void)toMap
{
    FBRouteViewController * route = [[FBRouteViewController alloc]init];
    route.viewStyle = @"3";
    if (self.collectionDataSource.count>0) {
        FBTicketDetailListModel *model = self.collectionDataSource[_page];
        route.ticketListmodel = model;
        [self.navigationController pushViewController:route animated:YES];
    }else{
        [MBProgressHUD showError:@"暂无数据"];
    }
}

//储值卡跳转
-(void)toStoredValueCard
{
    FBTopUpCardViewController * topUp = [[FBTopUpCardViewController alloc]init];
    [self.navigationController pushViewController:topUp animated:YES];
}

//网络请求TicketDetailsList
- (void)getTicketDetailsList
{
    [OCNetworkingTool POSTWithUrl:userTicketDetailsList() withParams:nil success:^(id responseObject) {
        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        if ([responseObject[@"code"] integerValue] == 200) {
            [self.collectionDataSource removeAllObjects];
            NSArray *data = responseObject[@"data"];
            if (ArrayNotNilAndNull(data)) {
                for (NSDictionary *dic in data) {
                    FBTicketDetailListModel *model = [FBTicketDetailListModel new];
                    model.orderId = dic[@"orderId"];
                    model.productId = dic[@"productId"];
                    model.routeId = dic[@"routeId"];
                    model.classId = dic[@"classId"];
                    model.staName = dic[@"staName"];
                    model.endName = dic[@"endName"];
                    NSString *timeStr = [NSString stringWithFormat:@"%@",dic[@"validDate"]];
                    if (timeStr.length >=10) {
                        timeStr = [timeStr substringToIndex:[timeStr length] - 3];
                    }
                    model.validDate = [self getTime:timeStr];
                    model.dayCount = [NSString stringWithFormat:@"共%@天",dic[@"dayCount"]];
                    model.classTime = dic[@"classTime"];
                    model.upStationName =dic[@"upStationName"];
                    model.productType = [dic[@"productType"] integerValue];
                    model.productTypeName = dic[@"productTypeName"];
                    model.platNo = dic[@"platNo"];
                    model.ticket = dic[@"ticket"];
                    model.rdesc = [NSString stringWithFormat:@"途径:%@",dic[@"rdesc"]];
                    model.ralen = [NSString stringWithFormat:@"约%.2f公里",[dic[@"ralen"] integerValue]/1000.0];
                    model.putime = [NSString stringWithFormat:@"约%@分钟",dic[@"putime"]];
                    model.dateList = dic[@"dateList"];
                    [self.collectionDataSource addObject:model];

                }
                [self hideDefaultImageView];
                [self.collectionView reloadData];

            }else{
                [self showDefaultImageView];
            }
        }else{
            [MBProgressHUD showError:@"获取车票失败"];
            [self showDefaultImageView];
        }
        
    } fail:^(NSError *error) {
        
        [MBProgressHUD showError:@"获取车票失败"];
        [self showDefaultImageView];
    }];
}

- (void)setCollectionView
{
    // 设置flowLayout
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    
    self.collectionView.backgroundColor = backCommonlyUsedColor;
    
    self.collectionView.pagingEnabled = YES;
    // 设置collectionView
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FBTakeBusCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:Identifier];
    [self.view addSubview:self.collectionView];
    
    //约束_taskTableView
    WeakSelf(weakSelf);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weakSelf.view);
        
    }];
}

#pragma mark - cell的代理方法
//点击打开日历
- (void)toOpenCalendarViewWithArray:(NSMutableArray *)array
{
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

//放大二维码
- (void)toShowBigImageViewWithImage:(UIImage *)image
{
    self.whiteView.alpha =0;
    _imageView.alpha =0;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-10, 100, 10, 10)];
    _imageView.image = image;
    [UIView animateWithDuration:0.5 animations:^{
        _imageView.height = 250;
        _imageView.width =250;
        self.whiteView.alpha =1;
        _imageView.alpha =1;
        _imageView.center = self.view.center;
        [[UIScreen mainScreen] setBrightness:1];
    }];
    [self.view addSubview:self.whiteView];
    [self.view addSubview: _imageView];
}

//缩小二维码
- (void)tapWhiteView
{
    [UIView animateWithDuration:0.5 animations:^{
         _imageView.frame =CGRectMake(SCREEN_WIDTH/2-10, 100, 10, 10);
        _imageView.alpha = 0;
        self.whiteView.alpha = 0;
        [[UIScreen mainScreen] setBrightness:_value];

//        DBLog(@"%ld",_value);
    } completion:^(BOOL finished) {
        [_imageView removeFromSuperview];
        [_whiteView removeFromSuperview];
    }];
}


#pragma mark - collectionView代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBTakeBusCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.backgroundColor = backCommonlyUsedColor;
    FBTicketDetailListModel *model = self.collectionDataSource[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算页号
    _page =  (CGFloat)scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    if (_page<0) {
        _page = 0;
    }
}


#pragma - mark 懒加载
-(NSMutableArray *)collectionDataSource
{
    if (_collectionDataSource == nil) {
        _collectionDataSource = [NSMutableArray array];
    }
    return _collectionDataSource;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
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


- (UIView *)whiteView
{
    if (_whiteView ==nil) {
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.userInteractionEnabled = YES;
        UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWhiteView)];
        PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
        PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
        
        [_whiteView addGestureRecognizer:PrivateLetterTap];
    }
    return _whiteView;
}



-(FBDefaultImageView *)defaultImageView{
    if (!_defaultImageView) {
        _defaultImageView = [[FBDefaultImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Text:@"您还没有车票,立即订购" MakeRange:0 TextColor:UIColorFromRGB(0x888888)];
        _defaultImageView.userInteractionEnabled = YES;
        _defaultImageView.delegate = self;
        [self.collectionView addSubview:_defaultImageView];
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
//修改tabbar
-(void)changeTabBar{
    self.tabBarController.selectedIndex = 1;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end