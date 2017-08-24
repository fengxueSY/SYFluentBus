//
//  OCUSelectCarTypeView.h
//  OfficialCar
//
//  Created by 张森明 on 16/9/18.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectViewCallback) (NSString *carInfo, NSInteger index);

@interface OCUCustomSelectView : UIView

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) SelectViewCallback selectViewCallback;

+ (OCUCustomSelectView *)customSelectView;
@end
