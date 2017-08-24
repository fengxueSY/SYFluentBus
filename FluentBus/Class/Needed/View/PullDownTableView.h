//
//  PullDownTableView.h
//  AutoPullDownTableView
//
//  Created by 张森明 on 16/8/18.
//  Copyright © 2016年 sonmin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedPullDownCellCallback)(NSIndexPath *indexPath, id selectedObj) ;
@interface PullDownTableView : UIView

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, copy) SelectedPullDownCellCallback selectedPullDownCellCallback;
@end
