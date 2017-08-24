//
//  FBNeedListTableViewCell.m
//  FluentBus
//
//  Created by 张俊辉 on 16/12/29.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBNeedListTableViewCell.h"

@implementation FBNeedListTableViewCell

+(instancetype)cellTableView:(UITableView *)tableView{
    
    static NSString * cellID = @"needCell";
    FBNeedListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:0]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *text = @" 次票 ";
    _dayTicketLb = [PublicMethod getAttributedTextWithSrting:text AndLabel:_dayTicketLb];
}

//报名按钮
- (IBAction)onClickSignupBtn:(id)sender {
    if (_btnBlack) {
        _btnBlack();
    }
}

-(void)setModel:(FBNeedListModel *)model
{
    _model = model;
    _timeLB.text = model.stime;
    
    _numberLB.text = [NSString stringWithFormat:@"已有%@人报名",model.votedCount];
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已有%@人报名",model.votedCount]];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"已有"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range1];
    
    NSRange range2=[[hintString string]rangeOfString:@"人报名"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range2];
    
    _numberLB.attributedText=hintString;
    
    _startLB.text = model.startStation;
    _endLB.text = model.endStation;
    _mpriceLB.text = [NSString stringWithFormat:@"￥%@",model.mprice];
    _apriceLB.text = [NSString stringWithFormat:@"￥%@",model.aprice];
    if (StringNotNilAndNull(model.ticketTypeName)) {
        
        NSString *text = [NSString stringWithFormat:@" %@ ",model.ticketTypeName];
        _ticketTypeLb = [PublicMethod getAttributedTextWithSrting:text AndLabel:_ticketTypeLb];
        
    }else{
        _ticketTypeLb = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:_ticketTypeLb];
    }
    
    //获取途径点
    if (StringNotNilAndNull(model.describtion)) {
        
        _gothroughAddressLb.text = model.describtion;
        
    }else{
        _gothroughAddressLb.text = @"暂无";
    }
    
}

//-(void)getRouteWithRid:(NSString *)rid
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:rid forKey:@"rid"];
//    
//    [OCNetworkingTool POSTWithUrl:searchRoteUrl() withParams:dict success:^(id responseObject) {
////        DBLog("%@",[PublicMethod jsEncapsulateWithDictionary:(NSDictionary *)responseObject]);
//        //请求成功拿数据
//        NSArray *array = responseObject[@"data"];
//        NSMutableArray *modelArray = [NSMutableArray array];
//        if (array.count > 0) {
//            for (NSDictionary *dic in array) {
//                FBNeedListRouteModel *model = [FBNeedListRouteModel new];
//                model.staindex = [dic[@"staindex"] integerValue];
//                model.sname = dic[@"sname"];
//                [modelArray addObject:model];
//            }
//            
//            //拿完数据按升序排好
//            NSArray *result = [modelArray sortedArrayUsingComparator:^NSComparisonResult(FBNeedListRouteModel * obj1, FBNeedListRouteModel * obj2) {
//                
//                return [@(obj1.staindex) compare:@(obj2.staindex)]; //升序
//            }];
//            
//            //取出升序排列后数组内的sname并拼接成字符串
//            NSMutableArray *snameArray =[NSMutableArray array];
//            for (FBNeedListRouteModel *routeModel in result) {
//                NSString *sname = routeModel.sname;
//                [snameArray addObject:sname];
//            }
//            NSString *describtion = [snameArray componentsJoinedByString:@"→"];
//            _gothroughAddressLb.text = describtion;
//            
//            //给模型返回请求到的数据
//            _model.describtion = describtion;
//            [_model.needRouteArray addObjectsFromArray:result];
//            
//            if (_callBack) {
//                _callBack(_model);
//            }
//        }
//    } fail:^(NSError *error) {
//        
//    }];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
