//
//  FBDetailNewsViewController.m
//  FluentBus
//
//  Created by 张俊辉 on 17/2/6.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "FBDetailNewsViewController.h"

@interface FBDetailNewsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msgTitle;
@property (weak, nonatomic) IBOutlet UILabel *msgTime;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation FBDetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息详情";
    
    [self setValueForControl];
}

- (void)setValueForControl
{
    self.msgTime.text = _model.ctime;
    self.msgTitle.text = _model.msgTitle;
    self.message.text = _model.msg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
