//
//  JF_CalendarView.h
//  JF_Calendar
//
//  Created by 孙建飞 on 16/5/16.
//  Copyright © 2016年 sjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JF_CalendarTools.h"
#import "JF_CalendarCell.h"

#define Blue_textColor [UIColor colorWithRed:105/255.0 green:187/255.0 blue:229/255.0 alpha:1.0]
#define Gray_textColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0]

@protocol JF_CalendarViewDelegate <NSObject>

@optional

-(void)toClosecalendarView;

@end

@interface JF_CalendarView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (weak, nonatomic) id<JF_CalendarViewDelegate> myDelegate;

@property(nonatomic,assign) int year;
@property(nonatomic,assign) int searchYear;

@property(nonatomic,assign) int month;
@property(nonatomic,assign) int searchMonth;


@property(nonatomic,assign) int day;
@property(nonatomic,assign) int searchDay;

@property(nonatomic,assign) int daysOfMonth;
@property(nonatomic,assign) int searchDaysOfMonth;

@property(nonatomic,assign) CGFloat cellWidth;

@property(nonatomic,strong) UIView *headerView;

@property(nonatomic,copy) NSMutableArray *registerArr;

@end
