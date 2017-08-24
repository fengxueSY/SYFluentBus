//
//  FBOrderCell.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/30.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBOrderModel.h"
#import "FBOrderProductsModel.h"
#import "FBOrderProductsShiftsModel.h"
@interface FBOrderCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *upBackView;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyEveryLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyLabel;
@property (weak, nonatomic) IBOutlet UILabel *everyLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyMonthLabel;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic,strong) FBOrderModel * listModel;
@property (nonatomic,strong) void(^selectBlock)(FBOrderProductsShiftsModel * seletStr);
@property (nonatomic,strong) FBOrderProductsModel * ProductsModel;
@property (nonatomic,strong) NSArray * collectionDataArray;
@end
