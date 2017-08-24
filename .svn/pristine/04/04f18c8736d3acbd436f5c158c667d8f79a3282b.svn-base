//
//  HeaderInfo.m
//  OfficialCar
//
//  Created by 666GPS on 16/9/27.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import "HeaderInfo.h"

@implementation HeaderInfo

static dispatch_once_t onceToken;

static HeaderInfo *headerInfo =nil;

+ (HeaderInfo *)sharedHeaderInfo{
    
    dispatch_once(&onceToken, ^{
       
        headerInfo = [[HeaderInfo alloc] init];
    });
    
    return headerInfo;
}

- (id)init{
    
    if (self =[super init]) {
        
        NSDictionary *headerDict = @{@"appid":[UserInfo userInfoWithUserDefaults].userAppId ? [UserInfo userInfoWithUserDefaults].userAppId : @"103905" ,@"sid":@"101879", @"sign":@"",@"tag":@"",@"tokenid":[UserInfo userInfoWithUserDefaults].userTokenId ? [UserInfo userInfoWithUserDefaults].userTokenId : @"",@"version":@"1"};

            NSString *string  =[PublicMethod jsonEncapsulateWithDictionary:headerDict];
            
            _headDict = [NSMutableDictionary dictionary];
            
            [_headDict setValue:string forKey:@"rqs-header"];
        
    }
    
    return self;
}

+ (void)tearDown{
    
    headerInfo=nil;
    onceToken=0l;
}


@end
