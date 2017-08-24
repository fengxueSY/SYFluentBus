//
//  FBTakeBusCollectionViewCell.m
//  FluentBus
//
//  Created by 张俊辉 on 16/12/28.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "FBTakeBusCollectionViewCell.h"

@implementation FBTakeBusCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [UIView setViewCorner:_tickTypeLb cornerRadius:2 borderWidth:1 colorRGB:(0xff4d64)];
    
    self.topImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    self.topImageView.contentMode = UIViewContentModeScaleToFill;
    [self.topImageView addGestureRecognizer:PrivateLetterTap];
}

- (void)setModel:(FBTicketDetailListModel *)model
{
    _model = model;
    _startAddressLb.text = model.staName;
    _endAddressLb.text = model.endName;
    _totalTimeLb.text = model.putime;
    _distanceLb.text = model.ralen;
    _goThougLb.text = model.rdesc;
    _classTimeLb.text = model.classTime;
    
    if (StringNotNilAndNull(model.productTypeName)) {
        
        NSString *text = [NSString stringWithFormat:@" %@ ",model.productTypeName];
        _tickTypeLb = [PublicMethod getAttributedTextWithSrting:text AndLabel:_tickTypeLb];
        
    }else{
        _tickTypeLb = [PublicMethod getAttributedTextWithSrting:@" 暂无 " AndLabel:_tickTypeLb];
    }
    
    _carPlatNoLb.text = model.platNo;
    _dateLb.text = [NSString stringWithFormat:@"%@ %@",model.validDate,model.dayCount];
    _upStationLb.text = model.upStationName;
    
    
    _topImageView.image = [self generateQrCodeWithInfo:[NSString stringWithFormat:@"#%@#",model.ticket]];
    
}

#pragma mark - 生产二维码
- (UIImage *)generateQrCodeWithInfo:(NSString *)info {
    
    // 创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *qrcodeData = [info dataUsingEncoding:NSUTF8StringEncoding];
    // 设置数据
    [filter setValue:qrcodeData forKey:@"inputMessage"];
    CIImage *outputImage = filter.outputImage;
    UIImage *qrCodeImage = [self scaleImage:outputImage];
    if (qrCodeImage == nil) {
        return nil;
    }
    return qrCodeImage;
    
}

- (UIImage *)scaleImage:(CIImage *)ciImage {
    // 创建放大的系数
    CGAffineTransform transform = CGAffineTransformMakeScale(5, 5);
    // 根据放大系数放大图片
    CIImage *newImage = [ciImage imageByApplyingTransform:transform];
    
    return [UIImage imageWithCIImage:newImage];
}

//点击日历按钮
- (IBAction)onClickCanderBtn:(id)sender {
    NSMutableArray *array = [NSMutableArray arrayWithArray:_model.dateList];
    if (_delegate && [_delegate respondsToSelector:@selector(toOpenCalendarViewWithArray:)]) {
        [_delegate toOpenCalendarViewWithArray:array];
    }
}

//二维码手势
- (void)tapAvatarView:(UITapGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(toShowBigImageViewWithImage:)]) {
        UIImageView *imageView = (UIImageView *)gesture.view;
        [_delegate toShowBigImageViewWithImage:imageView.image];
    }
}

@end