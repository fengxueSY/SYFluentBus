//
//  DCPlaceModel.h
//  DaChe
//
//  Created by 张森明 on 16/9/20.
//  Copyright © 2016年 666GPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWUMapPlaceModel : NSObject
/// 地点名字
@property (nonatomic, copy) NSString *name;
/// 经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString * addressName;
@end