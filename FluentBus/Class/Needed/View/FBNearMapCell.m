//
//  FBNearMapCell.m
//  FluentBus
//
//  Created by 666GPS on 2017/1/7.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBNearMapCell.h"

@implementation FBNearMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected == YES) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
