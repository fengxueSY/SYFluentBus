//
//  FBMySelfCell.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBMySelfCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
+(instancetype)cellTableView:(UITableView *)tableView;
@end
