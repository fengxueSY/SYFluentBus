//
//  DCTextField.m
//  DaChe
//
//  Created by 张森明 on 16/8/19.
//  Copyright © 2016年 666GPS. All rights reserved.
//

#import "XWUTextField.h"

@interface XWUTextField ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *leftImgView;
@end

@implementation XWUTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTextField];
    }
    return self;
}

/// 设置
- (void)setUpTextField {
    // 光标颜色
    self.tintColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor whiteColor];
    self.placeholder = @"请输入关键字";
    self.font = [UIFont systemFontOfSize:14];
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    leftView.frame = CGRectMake(0, 0, 15, 15);
    self.leftView = leftView;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.returnKeyType = UIReturnKeySearch;
}
  
// 设置leftView的位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    leftRect.origin.x += 10; //右边偏10
    return leftRect;
}

// 设置rightView的位置
- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rightRect = [super rightViewRectForBounds:bounds];
    rightRect.origin.x -= 10; //左边偏10
    return rightRect;
}

// 占位文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    if (self.leftView) {
        return CGRectInset(bounds, 30, 0);
    }
    return CGRectInset(bounds, 10, 0);
    
}

//控制编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    if (self.leftView) {
        return CGRectInset(bounds, 30, 0);
    }
    return CGRectInset(bounds, 10, 0);
}
@end
