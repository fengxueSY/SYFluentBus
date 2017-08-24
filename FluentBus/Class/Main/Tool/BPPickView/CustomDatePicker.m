//
//  CustomDatePicker.m
//  LearnDriving
//
//  Created by 叶杨杨 on 16/6/11.
//  Copyright © 2016年 666gps. All rights reserved.
//

#import "CustomDatePicker.h"

@implementation CustomDatePicker
{
    NSArray *_leapMonthArr;//闰月
    NSArray *_normalMonthArr;//非闰月
    NSMutableArray *_yearsArr;//年
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
        
        _leapMonthArr = [NSArray arrayWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
        _normalMonthArr = [NSArray arrayWithObjects:@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
       
        _yearsArr = [[NSMutableArray alloc] initWithCapacity:0];
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        _year = [[formatter stringFromDate:date] intValue];
        [formatter setDateFormat:@"MM"];
        _month = [[formatter stringFromDate:date] intValue];
        [formatter setDateFormat:@"dd"];
        _day = [[formatter stringFromDate:date] intValue];
        [formatter setDateFormat:@"HH"];
        _hour = [[formatter stringFromDate:date] intValue];
        [formatter setDateFormat:@"mm"];
        _minute = [[formatter stringFromDate:date] intValue];
        
        
        //控制前后多少年
        for (int i = _year-1; i<= _year + 1; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            DBLog(@"%@",str);
            [_yearsArr addObject:str];
        }
        
        //默认当前日期
        [_picker selectRow:1 inComponent:0 animated:YES];
        [_picker selectRow:_month-1 inComponent:1 animated:YES];
        [_picker selectRow:_day-1 inComponent:2 animated:YES];
        [_picker selectRow:_hour-1 inComponent:3 animated:YES];
        [_picker selectRow:_minute inComponent:4 animated:YES];
        
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
    
    _leapMonthArr = [NSArray arrayWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    _normalMonthArr = [NSArray arrayWithObjects:@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    
    _yearsArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    _year = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    _month = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"dd"];
    _day = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"HH"];
    _hour = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"mm"];
    _minute = [[formatter stringFromDate:date] intValue];
    
    
    //控制前后多少年
    for (int i = _year-1; i<= _year + 1; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [_yearsArr addObject:str];
    }
    //默认当前日期
    [_picker selectRow:1 inComponent:0 animated:YES];
    [_picker selectRow:_month-1 inComponent:1 animated:YES];
    [_picker selectRow:_day-1 inComponent:2 animated:YES];
    [_picker selectRow:_hour inComponent:3 animated:YES];
    [_picker selectRow:_minute inComponent:4 animated:YES];

}

#pragma mark - pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rowNum = 0;
    switch (component) {
        case 0:
        {
            
            rowNum =  _yearsArr.count;
            
        }
            break;
        case 1:
        {
            
             rowNum = 12;
            
        }
            break;
            
        case 2:
        {
            
            int row = (int)[_picker selectedRowInComponent:0];
            int nowyear = [[_yearsArr objectAtIndex:row] intValue];
            int nowmonth = (int)[_picker selectedRowInComponent:1];
            
            if ((nowyear % 4 == 0 && nowyear % 100 !=0 )||(nowyear % 400 == 0)) {
                 rowNum = [[_normalMonthArr objectAtIndex:nowmonth] intValue];
            }
            else
            {
                 rowNum = [[_leapMonthArr objectAtIndex:nowmonth] intValue];
            }
            
            
        }
            break;
        case 3:
        {
            
            rowNum = 24;
            
        }
            break;
        case 4:
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
        mycom1.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 60 )/5.0 , 50);
        mycom1.text = [NSString stringWithFormat:@"%@年",[_yearsArr objectAtIndex:row]];
        
    }
    else if(component == 1){
        
        mycom1.text = [NSString stringWithFormat:@"%ld月",row+1];
        
        
    }else if(component == 2)
    {
        mycom1.text = [NSString stringWithFormat:@"%ld日",row+1];
        
    }else if(component == 3)
    {
        mycom1.textAlignment = NSTextAlignmentRight;
        mycom1.text = [NSString stringWithFormat:@"%ld时",row];
        
    }else
    {
        mycom1.text = [NSString stringWithFormat:@"%ld分",row];
        
    }

    return mycom1;

}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat width = 0;
    if (component == 0) {
        
        width = (SCREEN_WIDTH - 73)/5.0;
        
    }else if(component == 1){
        
        width = (SCREEN_WIDTH - 73)/5.0 - 10;
        
    }else if(component == 2)
    {
        width = (SCREEN_WIDTH - 73)/5.0 - 10;
        
    }else if(component == 3)
    {
        width = (SCREEN_WIDTH - 73)/5.0 + 10;
        
    }else
    {
        width = (SCREEN_WIDTH - 73)/5.0;
        
    }

    return width;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component == 0||component == 1)
    {
        //当第一个滚轮发生变化时,刷新第二个滚轮的数据
        [_picker reloadComponent:2];
        //让刷新后的第二个滚轮重新回到第一行
        [_picker selectRow:0 inComponent:2 animated:YES];
    }
    int rowy = (int)[_picker selectedRowInComponent:0];
    int rowm = (int)[_picker selectedRowInComponent:1];
    int rowd = (int)[_picker selectedRowInComponent:2];
    int rowh = (int)[_picker selectedRowInComponent:3];
    int rowmi = (int)[_picker selectedRowInComponent:4];
    
    
    _year = [[_yearsArr objectAtIndex:rowy] intValue];
    _month = (int)rowm+1;
    _day = (int)rowd+1;
    _hour = (int)rowh;
    _minute = (int)rowmi;

}






@end
