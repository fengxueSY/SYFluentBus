//
//  OCUSelectPlaceFromMapViewController.h
//  OfficialCar
//
//  Created by 张森明 on 16/9/20.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 用车申请要选择的地点类型
typedef NS_ENUM(NSInteger,OCUSQPlaceType) {
    SqFromPlace = 0, // 出发地
    SqToPlace = 1,   // 目的地
};

@interface XWUSelectPlaceFromMapViewController : UIViewController
@property (nonatomic, assign) BOOL isUpdateApply;
/// 要选择地点类型
@property (nonatomic, assign) OCUSQPlaceType placeType;
@end
