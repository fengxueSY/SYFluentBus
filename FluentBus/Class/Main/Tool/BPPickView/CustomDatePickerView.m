//
//  CustomDatePickerView.m
//  LearnDriving
//
//  Created by 666GPS on 16/6/23.
//  Copyright © 2016年 666gps. All rights reserved.
//

#import "CustomDatePickerView.h"

@implementation CustomDatePickerView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

 
- (IBAction)dismissClick:(id)sender {

    if (_dismissBlock) {
        
         _dismissBlock();
    }
}

- (IBAction)sureClick:(id)sender {

    if (_sureBlock) {
        
         _sureBlock();
    }

}
@end
