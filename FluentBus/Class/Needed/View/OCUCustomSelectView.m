//
//  OCUSelectCarTypeView.m
//  OfficialCar
//
//  Created by 张森明 on 16/9/18.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import "OCUCustomSelectView.h"


@interface OCUCustomSelectView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, assign) NSInteger row;
@end

@implementation OCUCustomSelectView

+ (OCUCustomSelectView *)customSelectView{
    return [[[NSBundle mainBundle] loadNibNamed:@"OCUCustomSelectView" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setTextColor:[UIColor colorWithRed:51 /255.0 green:51 /255.0 blue:51/255.0 alpha:1]];
    titleLabel.text = (NSString *)self.dataSource[row];
    return titleLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.row = row;
}


#pragma mark - Button Click

- (IBAction)buttonDidClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            // 取消
            if (self.selectViewCallback) {
                self.selectViewCallback(nil,0);
            }
        }
            break;
        case 2:
        {
            // 确定
            if (self.selectViewCallback) {
                NSString *carInfo = self.dataSource[self.row];
                self.selectViewCallback(carInfo,self.row);
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Setter & Getter
- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.pickerView reloadAllComponents];
    //  默认定位选中第一行
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
}


@end
