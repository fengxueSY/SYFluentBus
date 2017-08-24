//
//  CustomAnnotationView.h
//  DaChe
//
//  Created by 张俊辉 on 16/8/9.
//  Copyright © 2016年 666GPS. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end
