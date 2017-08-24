//
//  UserInfo.m
//  OfficialCar
//
//  Created by 张俊辉 on 16/8/29.
//  Copyright © 2016年 张俊辉. All rights reserved.
//

#import "UserInfo.h"
#import "NSString+LLX.h"

@implementation UserInfo

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if(self=[super init]) {
        
        //        [self setValuesForKeysWithDictionary:dict];
        _userTokenId = [dict objectForKey:@"userTokenId"];
        _userAppId = [dict objectForKey:@"userAppId"];
        _userName = [dict objectForKey:@"userName"];
        _userId = [dict objectForKey:@"userId"];
        _nickName = [dict objectForKey:@"nickName"];
        NSLog(@"%@-%@-%@-%@",_userTokenId,_userId,_userAppId,_userName);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:[NSString checkObject:_userTokenId] forKey:@"userTokenId"];
        [userDefaults setObject:[NSString checkObject:_userId] forKey:@"userId"];
        [userDefaults setObject:[NSString checkObject:_userAppId] forKey:@"userAppId"];
         [userDefaults setObject:[NSString checkObject:_userName] forKey:@"userName"];
        [userDefaults setObject:[NSString checkObject:_nickName] forKey:@"nickName"];
        [userDefaults synchronize];
    }
    return self;
    
}


+ (instancetype)userInfoWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
    
}

- (instancetype)initWithUserDefaults {
    
    if(self = [super init]) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        _userTokenId = [userDefaults objectForKey:@"userTokenId"];
        _userId = [userDefaults objectForKey:@"userId"];
        _userAppId = [userDefaults objectForKey:@"userAppId"];
        _userName = [userDefaults objectForKey:@"userName"];
        _nickName = [userDefaults objectForKey:@"nickName"];
}
    return self;
}

+ (instancetype)userInfoWithUserDefaults {
    return [[self alloc] initWithUserDefaults];
}

+ (void)clearUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userTokenId"];
    [userDefaults removeObjectForKey:@"userId"];
    [userDefaults removeObjectForKey:@"userAppId"];
    [userDefaults removeObjectForKey:@"userName"];
    [userDefaults removeObjectForKey:@"nickName"];
}
@end