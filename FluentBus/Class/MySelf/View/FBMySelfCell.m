//
//  FBMySelfCell.m
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBMySelfCell.h"

@implementation FBMySelfCell
+(instancetype)cellTableView:(UITableView *)tableView{
    static NSString * cellID = @"ID";
    BOOL isReg = NO;
    if (!isReg) {
        [tableView registerNib:[UINib nibWithNibName:@"FBMySelfCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    FBMySelfCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    FBMySelfCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:0]lastObject];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
