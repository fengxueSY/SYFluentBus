//
//  FBMapAllroundView.h
//  FluentBus
//
//  Created by 666GPS on 2017/1/7.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWUMapPlaceModel.h"
@protocol FBMapAllroundViewDelegate <NSObject>

-(void)chooseAddress:(id)address;

@end

@interface FBMapAllroundView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,assign) id<FBMapAllroundViewDelegate>delegate;
@property(nonatomic,strong) UITableView * tableView;
-(void)reloadInTabelData;
@end
