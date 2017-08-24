//
//  CustomAnnotationView.m
//  DaChe
//
//  Created by 张俊辉 on 16/8/9.
//  Copyright © 2016年 666GPS. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kCalloutWidth       120.0
#define kCalloutHeight      50.0

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    if (self.selected == selected)
    {
        return;
    }

    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            NSLog(@"%@",self.annotation.title);
        }
        
        self.calloutView.title = self.annotation.title;
        NSLog(@"%@",self.annotation.title);
        if (self.annotation.title != NULL) {
            [self addSubview:self.calloutView];
        }else{
            [self.calloutView removeFromSuperview];
        }
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }

    [super setSelected:selected animated:animated];
}

@end
