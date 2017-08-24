//
//  BPYMDPickerView.h
//  BasePlatform
//
//  Created by 叶杨 on 2016/12/21.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPYMDPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

/**
 *  年月日三项选择
 */
@property (nonatomic, readonly) int year;
@property (nonatomic, readonly) int month;
@property (nonatomic, readonly) int day;



@end
