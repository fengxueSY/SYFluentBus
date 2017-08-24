//
//  BPHMPickerView.m
//  BasePlatform
//
//  Created by 叶杨 on 2016/12/21.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "BPHMPickerView.h"

@implementation BPHMPickerView
{
    NSArray *_hourArr;//小时
    NSArray *_minuteArr;//分钟
    UIPickerView *_picker;

}

- (instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _picker = [[UIPickerView alloc] initWithFrame:self.bounds];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.showsSelectionIndicator = YES;
        [self addSubview:_picker];
        
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH"];
        _hour = [[formatter stringFromDate:date] intValue];
        DBLog(@"hour %d",_hour);
        [formatter setDateFormat:@"mm"];
        _minute = [[formatter stringFromDate:date] intValue];
        
        //默认当前时间
        [_picker selectRow:_hour inComponent:0 animated:YES];
        [_picker selectRow:_minute inComponent:1 animated:YES];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH- 71, 90)];
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    [self addSubview:_picker];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    _hour = [[formatter stringFromDate:date] intValue];
    
    [formatter setDateFormat:@"mm"];
    _minute = [[formatter stringFromDate:date] intValue];
    
    //默认当前时间

    [_picker selectRow:_hour inComponent:0 animated:YES];
    [_picker selectRow:_minute inComponent:1 animated:YES];
    
}

#pragma mark - pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rowNum = 0;
    switch (component) {
        case 0:
        {
            rowNum = 24;
        }
            break;
        case 1:
        {
            rowNum = 60;
        }
            break;
            
        default:
            break;
    }
    
    return rowNum;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *mycom1 = [[UILabel alloc] init];
    mycom1.textAlignment = NSTextAlignmentCenter;
    mycom1.backgroundColor = [UIColor clearColor];
    mycom1.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 75 )/5.0 , 50);
    [mycom1 setFont:[UIFont boldSystemFontOfSize:14]];
    if(component == 0)
    {
        mycom1.textAlignment = NSTextAlignmentRight;
        if (row < 10) {
            mycom1.text = [NSString stringWithFormat:@"0%ld时",row];
        }else{
            mycom1.text = [NSString stringWithFormat:@"%ld时",row];
        }
    }else
    {
        if (row < 10) {
            mycom1.text = [NSString stringWithFormat:@"0%ld分",row];
        }else{
            mycom1.text = [NSString stringWithFormat:@"%ld分",row];
        }
    }
    return mycom1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat width = 0;
    if (component == 0) {
        width = (SCREEN_WIDTH - 73)/5.0;
    }else{
        width = (SCREEN_WIDTH - 73)/5.0;
    }
    return width;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    int rowh = (int)[_picker selectedRowInComponent:0];
    int rowmi = (int)[_picker selectedRowInComponent:1];
    
    _hour = (int)rowh;
    _minute = (int)rowmi;
}



@end
