//
//  FBTakeBusCollectionViewCell.h
//  FluentBus
//
//  Created by 张俊辉 on 16/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBTicketDetailListModel.h"

@protocol FBTakeBusCollectionViewCellDelegate <NSObject>

@optional

-(void)toOpenCalendarViewWithArray:(NSMutableArray *) array;

- (void)toShowBigImageViewWithImage:(UIImage *)image;
@end

@interface FBTakeBusCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<FBTakeBusCollectionViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *endAddressLb;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLb;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *distanceLb;
@property (weak, nonatomic) IBOutlet UILabel *goThougLb;
@property (weak, nonatomic) IBOutlet UILabel *classTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *carPlatNoLb;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@property (weak, nonatomic) IBOutlet UILabel *upStationLb;
@property (weak, nonatomic) IBOutlet UILabel *tickTypeLb;


@property (nonatomic,strong) FBTicketDetailListModel *model;

@end