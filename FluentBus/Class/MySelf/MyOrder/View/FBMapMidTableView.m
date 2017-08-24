//
//  FBMapMidTableView.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/29.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMapMidTableView.h"
#import "FBMidTableViewCell.h"
#import "FBFirstTypeView.h"
#import "FBThreeTypeView.h"
#import "FBNeedListRouteModel.h"

@implementation FBMapMidTableView
-(instancetype)initWithFrame:(CGRect)frame StyleView:(NSString *)styleView Parameter:(id)parameter TableViewArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        _needListModel = parameter;
        _tableViewHeadH = 20;
        _viewStyle = styleView;
        _viewH = frame.size.height;
        _viewW = frame.size.width;
        _isShow = YES;
        _dataArray = dataArray;
        _arrayCount = _dataArray.count;
        
        if ([_viewStyle integerValue] == 1) {
            _needListModel = (FBNeedListModel *)parameter;
            [self getAppLineByRid:_needListModel.rid];
        }else if ([_viewStyle integerValue] == 2){
            _productsShiftsModel = (FBOrderProductsShiftsModel *)parameter;
            [self getAppLineByRid:_productsShiftsModel.stationRid];
        }else{
            _ticketListmodel = (FBTicketDetailListModel *)parameter;
            [self getAppLineByRid:_ticketListmodel.routeId];
        }
        [self creatBaseUI];

    }
    return self;
}
-(void)creatBaseUI{
    [self creatFirstViewWithSpeed:@"暂无" andTotalTime:@"暂无"];
    [self creatSedView];
    [self creatThreeView];
    [self creatFourView];
    
}
-(void)creatFirstViewWithSpeed:(NSString *)speed andTotalTime:(NSString *) totalTime{
    if (_firstBackView) {
        [_firstBackView removeFromSuperview];
    }
    _firstBackView = [[UIView alloc]init];
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = UIColorWithRGB(200,200, 200, 1);
    [_firstBackView addSubview:lineLabel];
    NSString *startStr = nil;
    NSString *endStr = nil;
    if ([_viewStyle integerValue] == 3) {
        _firstBackView.frame = CGRectMake(0, 0, _viewW, 40);
        lineLabel.frame = CGRectMake(0, 39, _viewW, 1);
        startStr = _ticketListmodel.staName;
        endStr = _ticketListmodel.endName;
    }else{
        if ([_viewStyle integerValue] == 1) {
            startStr = _needListModel.startStation;
            endStr = _needListModel.endStation;
        }else{
            startStr = _productsShiftsModel.startStation;
            endStr = _productsShiftsModel.endStation;
        }
        
        lineLabel.frame = CGRectMake(0, 64, _viewW, 1);
        _firstBackView.frame = CGRectMake(0, 0, _viewW, 65);
        
        UIImageView * timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 45, 10, 10)];
        timeImageView.image = [UIImage imageNamed:@"common_route＿time"];
        float timeLabelW = [PublicMethod handelWideContent:totalTime AndFontsize:12 AndMaxsize:CGSizeMake(10000, 20)];
        float vLabelW = [PublicMethod handelWideContent:speed AndFontsize:12 AndMaxsize:CGSizeMake(1000, 20)];
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Max_X(timeImageView) + 3, 40, timeLabelW, 20)];
        timeLabel.text = totalTime;
        timeLabel.font = [UIFont systemFontOfSize:12];
        UIImageView * vImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Max_X(timeLabel) + 5, 45, 10, 10)];
        vImageView.image = [UIImage imageNamed:@"common_route＿place"];
        UILabel * vLabel = [[UILabel alloc]initWithFrame:CGRectMake(Max_X(vImageView) + 3, 40, vLabelW, 20)];
        vLabel.text = speed;
        vLabel.font = [UIFont systemFontOfSize:12];
        
        [_firstBackView addSubview:timeImageView];
        [_firstBackView addSubview:timeLabel];
        [_firstBackView addSubview:vLabel];
        [_firstBackView addSubview:vImageView];

    }
    _firstBackView.backgroundColor = whiteUnifyColor;
    //高度为40的时候，只出现一行车站名字
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(16, 0, _viewW, 38)];
    UIImageView * startImage = [[UIImageView alloc]initWithFrame:CGRectMake(2, 15, 10, 10)];
    startImage.image = [UIImage imageNamed:@"common_route_start"];
    float startLabelW = [PublicMethod handelWideContent:startStr AndFontsize:12 AndMaxsize:CGSizeMake(10000, 30)];
    float endLabelW = [PublicMethod handelWideContent:endStr AndFontsize:12 AndMaxsize:CGSizeMake(10000, 00)];
    UILabel * startLabel = [[UILabel alloc]initWithFrame:CGRectMake(Max_X(startImage) + 3, 5, startLabelW, 30)];
    startLabel.font = [UIFont systemFontOfSize:12];
    startLabel.text = startStr;
    UIImageView * midImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Max_X(startLabel) + 6, 18, 15, 4)];
    midImageView.image = [UIImage imageNamed:@"common_route_arrow"];
    UIImageView * endImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Max_X(midImageView) + 6, 15, 10, 10)];
    endImageView.image = [UIImage imageNamed:@"common_route_end"];
    UILabel * endLabel = [[UILabel alloc]initWithFrame:CGRectMake(Max_X(endImageView) + 3, 5, endLabelW, 30)];
    endLabel.text = endStr;
    endLabel.font = [UIFont systemFontOfSize:12];

    [scrollView addSubview:startImage];
    [scrollView addSubview:startLabel];
    [scrollView addSubview:midImageView];
    [scrollView addSubview:endImageView];
    [scrollView addSubview:endLabel];
    
    scrollView.contentSize = CGSizeMake(View_Width(startImage) + View_Width(startLabel) + View_Width(midImageView) + View_Width(endImageView) + View_Width(endLabel) + _viewW / 32 + 18, 0);
    [_firstBackView addSubview:scrollView];
    
    [self addSubview:_firstBackView];
}
-(void)creatSedView{
    UIView * backView = [[UIView alloc]init];
    if ([_viewStyle integerValue] == 1) {
        backView.frame = CGRectMake(0, 65, _viewW, 40);
        FBFirstTypeView * first = [[[NSBundle mainBundle]loadNibNamed:@"FBFirstTypeView" owner:self options:0]lastObject];
        
        first.productTypeNameLabel.textColor = UIColorFromRGB(0xff4d64);
        
        if (StringNotNilAndNull(_needListModel.ticketTypeName)) {
            
            NSString *text = [NSString stringWithFormat:@" %@ ",_needListModel.ticketTypeName];
            first.productTypeNameLabel = [PublicMethod getAttributedTextWithSrting:text AndLabel:first.productTypeNameLabel];
            
        }else{
           first.productTypeNameLabel = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:first.productTypeNameLabel];
        }
        
        
        first.timeLabel.text = _needListModel.stime;
        first.moneyLabel.text = [NSString stringWithFormat:@"￥%@",_needListModel.mprice];
        first.moneyLabel.textColor = UIColorFromRGB(0xDA5757);
        [backView addSubview:first];
        first.translatesAutoresizingMaskIntoConstraints = NO;
        [first mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(backView);
            make.top.equalTo(backView);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(_viewW);
        }];
    }else if ([_viewStyle integerValue] == 2){
        backView.frame = CGRectMake(0, 65, _viewW, 65);
        FBTwoTypeView * two1 = [[[NSBundle mainBundle]loadNibNamed:@"FBTwoTypeView" owner:self options:0]lastObject];
        NSString *timeStrStart = [NSString stringWithFormat:@"%@",_productsShiftsModel.startTime];
        timeStrStart = [timeStrStart substringToIndex:[timeStrStart length] - 3];
        NSString *timeStrEnd = [NSString stringWithFormat:@"%@",_productsShiftsModel.endTime];
        timeStrEnd = [timeStrEnd substringToIndex:[timeStrEnd length] - 3];
        NSString * startDate = [PublicMethod timeFormatted:[timeStrStart doubleValue]];
        NSString * downTime = [PublicMethod timeFormatted:[timeStrEnd doubleValue]];
        two1.startGoLabel.text = [NSString stringWithFormat:@"%@开行",[startDate componentsSeparatedByString:@" "][0]];
        two1.startTimeLabel.text = [NSString stringWithFormat:@"%@停售",[downTime componentsSeparatedByString:@" "][0]];
        two1.timeLabel.text = _productsShiftsModel.time;
        two1.leftNumberLabel.text = [NSString stringWithFormat:@"余%@座",_productsShiftsModel.left];
        two1.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[_productsShiftsModel.moneyPrice floatValue] / 100];
        
        if (StringNotNilAndNull(_productsShiftsModel.productTypeName)) {
            
            NSString *text = [NSString stringWithFormat:@" %@ ",_productsShiftsModel.productTypeName];
            two1.productTypeName = [PublicMethod getAttributedTextWithSrting:text AndLabel:two1.productTypeName];
            
        }else{
            two1.productTypeName = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:two1.productTypeName];
        }
        
        two1.delegate = self;
        [backView addSubview:two1];
        two1.translatesAutoresizingMaskIntoConstraints = NO;
        [two1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(backView);
            make.top.equalTo(backView);
            make.width.mas_equalTo(_viewW);
            make.height.mas_equalTo(65);
        }];
    }else{
        backView.frame = CGRectMake(0, 40, _viewW, 85);
        FBThreeTypeView * three = [[[NSBundle mainBundle]loadNibNamed:@"FBThreeTypeView" owner:self options:0]lastObject];
        three.validTimeLabel.text = [NSString stringWithFormat:@"%@ %@",_ticketListmodel.validDate,[NSString stringWithFormat:@"%@",_ticketListmodel.dayCount]];
        
        if (StringNotNilAndNull(_ticketListmodel.productTypeName)) {
            
            NSString *text = [NSString stringWithFormat:@" %@ ",_ticketListmodel.productTypeName];
            three.prouductNameLabel = [PublicMethod getAttributedTextWithSrting:text AndLabel:three.prouductNameLabel];
            
        }else{
            three.prouductNameLabel = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:three.prouductNameLabel];
        }
        
        three.timeLabel.text = _ticketListmodel.classTime;
        three.carNumberLabel.text = _ticketListmodel.platNo;
        three.startNameLabel.text = _ticketListmodel.upStationName;
        [three.calendarButton addTarget:self action:@selector(threeCalendarButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:three];
        three.translatesAutoresizingMaskIntoConstraints = NO;
        [three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(backView);
            make.top.equalTo(backView);
            make.height.mas_equalTo(85);
            make.width.mas_equalTo(_viewW);
        }];
    }
    [self addSubview:backView];
}
-(void)creatThreeView{
    float tableViewH;
    if (20 + _arrayCount * 30 > 170) {
        tableViewH = 170;
    }else{
        tableViewH = 5 + _arrayCount * 30;
    }
    float TH;
    if ([_viewStyle integerValue] == 1) {
        if (tableViewH + 15 <= SCREEN_HEIGHT / 2 - 105) {
            TH = tableViewH;
        }else{
            TH = SCREEN_HEIGHT / 2 - 120;
        }
    }else if ([_viewStyle integerValue] == 2){
        if (tableViewH + 15 <= SCREEN_HEIGHT / 2 - 130) {
            TH = tableViewH;
        }else{
            TH = SCREEN_HEIGHT / 2 - 145;
        }
    }else{
        if (tableViewH + 15 <= SCREEN_HEIGHT / 2 - 125) {
            TH = tableViewH;
        }else{
            TH = SCREEN_HEIGHT / 2 - 140;
        }
    }
   
    _tableView = [[UITableView alloc]init];
    if ([_viewStyle integerValue] == 1) {
        _tableView.frame = CGRectMake(0, 105, _viewW, TH);
    }else if ([_viewStyle integerValue] == 2){
        _tableView.frame = CGRectMake(0, 130, _viewW, TH);
    }else{
        _tableView.frame = CGRectMake(0, 125, _viewW, TH);
    }

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}
-(void)creatFourView{
    _showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _showButton.frame = CGRectMake((_viewW - 25) / 2, Max_Y(_tableView), 25, 15);
    _showButton.backgroundColor = whiteUnifyColor;
    [_showButton setImage:UIImageName(@"map_icon_up") forState:UIControlStateNormal];
    [_showButton addTarget:self action:@selector(footButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_showButton];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _tableViewHeadH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor = UIColorWithRGB(230, 230, 230, 1);
    UILabel * tetLabel = [[UILabel alloc]initWithFrame:CGRectMake(_viewW / 32, 0, _viewW * 31 / 32, 20)];
    if ([_viewStyle integerValue] == 1) {
         tetLabel.text = @"途径站点";
    }else if ([_viewStyle integerValue] == 2){
         tetLabel.text = @"选择上车站点";
    }else{
         tetLabel.text = @"";
    }
    tetLabel.font = [UIFont systemFontOfSize:12];
    [headView addSubview:tetLabel];
    return headView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayCount;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 31;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"ID";
    BOOL ISRig = NO;
    if (!ISRig) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FBMidTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    }
    FBMidTableViewCell * cell = (FBMidTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FBNeedListRouteModel * model = _dataArray[indexPath.row];
    cell.backgroundColor = whiteUnifyColor;
    if (indexPath.row == _arrayCount - 1) {
        cell.changeImageView.image = [UIImage imageNamed:@"common_route_end001"];
        cell.lineLabel.frame = CGRectMake(17.5, 0, 1, 15);
    }else{
        if ([model.isUpStation integerValue] == 1) {
            if (indexPath.row == _selectIndex) {
                cell.changeImageView.image = [UIImage imageNamed:@"confirmorder_zhifufangshi"];
            }else{
                cell.changeImageView.image = [UIImage imageNamed:@"common_route_start"];
            }
        }else{
            cell.changeImageView.image = UIImageName(@"book_xuanzeshangchezhan3");
        }
       
        if (indexPath.row == 0) {
            cell.lineLabel.frame = CGRectMake(17.5, 15, 1, 15);
        }else{
            cell.lineLabel.frame = CGRectMake(17.5, 0, 1, 30);
        }
    }
    cell.startLabel.text = model.sname;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_viewStyle integerValue] == 2) {
        FBNeedListRouteModel * model = _dataArray[indexPath.row];
        if (indexPath.row == _arrayCount - 1) {
            if (_delegate) {
                [_delegate SelectIndex:indexPath.row];
            }
        }else{
            if ([model.isUpStation integerValue] == 1) {
                _selectIndex = indexPath.row;
                FBNeedListRouteModel * model = _dataArray[indexPath.row];
                if (_delegate) {
                    [_delegate chooseStationSid:model];
                }
                [_tableView reloadData];
            }else{
                [MBProgressHUD showError:@"该站点不可选择，请选择其他站点"];
            }
        }
    }
}
//点击button收起数据
-(void)footButtonAction:(UIButton *)sender{
    float tableViewH;
    if (20 + _arrayCount * 30 > 170) {
        tableViewH = 170;
    }else{
        tableViewH = 5 + _arrayCount * 30;
    }

    float TH;
    if ([_viewStyle integerValue] == 1) {
        if (tableViewH + 15 <= SCREEN_HEIGHT / 2 - 105) {
            TH = tableViewH;
        }else{
            TH = SCREEN_HEIGHT / 2 - 120;
        }
    }else if ([_viewStyle integerValue] == 2){
        if (tableViewH + 15 <= SCREEN_HEIGHT / 2 - 130) {
            TH = tableViewH;
        }else{
            TH = SCREEN_HEIGHT / 2 - 145;
        }
    }else{
        if (tableViewH + 15 <= SCREEN_HEIGHT / 2 - 125) {
            TH = tableViewH;
        }else{
            TH = SCREEN_HEIGHT / 2 - 140;
        }
    }

    if (_isShow == NO) {
        _isShow = YES;
        _showButton.frame = CGRectMake((_viewW - 25) / 2, Max_Y(_tableView), 25, 15);
        [_showButton setImage:UIImageName(@"map_icon_up") forState:UIControlStateNormal];
        _arrayCount = _dataArray.count;
        _tableView.scrollEnabled = YES;
        _tableViewHeadH = 20;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView reloadData];
        if (_delegate) {
            [_delegate isShowTableView:YES];
        }
    }else{
        _isShow = NO;
        _showButton.frame = CGRectMake((_viewW - 25) / 2, Max_Y(_tableView) - TH, 25, 15);
         [_showButton setImage:UIImageName(@"map_icon_down") forState:UIControlStateNormal];
        _arrayCount = 0;
        _tableView.scrollEnabled = NO;
        _tableViewHeadH = 0;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView reloadData];
        if (_delegate) {
            [_delegate isShowTableView:NO];
        }
    }
}
//显示日历
-(void)selectDayImage{
    if (_delegate) {
        [_delegate showCalender];
    }
}
//3显示日历
-(void)threeCalendarButtonAction{
    if (_delegate) {
        [_delegate showCalenderThree:_ticketListmodel];
    }
}
//查看路线信息(主要是获取报名时 显示的速度 跟总时间)
-(void)getAppLineByRid:(NSString * )rid{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:rid forKey:@"rid"];
    [OCNetworkingTool POSTWithUrl:getAppLineByRidUrl() withParams:dic success:^(id responseObject) {
        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
        if ([responseObject[@"code"] integerValue] == 200) {
            NSDictionary *data = responseObject[@"data"];
            NSString *speed = [NSString stringWithFormat:@"约%.2f公里",[data[@"ralen"] floatValue] / 1000];
            NSString *totalTime = [NSString stringWithFormat:@"约%@分钟",data[@"putime"]];
            [self creatFirstViewWithSpeed:speed andTotalTime:totalTime];
        }
    } fail:^(NSError *error) {
    }];
}

@end
