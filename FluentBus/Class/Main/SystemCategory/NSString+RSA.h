//
//  NSString+RSA.h
//  FluentBus
//
//  Created by 张俊辉 on 16/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CRSA.h"
#import "Base64.h"
@interface NSString (RSA)

//传入膜和指数 得到加密后的结果
+ (NSString *)setPublicKey:(const char *)data Mod:(const char *)mod Exp:(const char *)exp;

@end
