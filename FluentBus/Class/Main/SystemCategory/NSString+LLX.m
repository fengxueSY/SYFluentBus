//
//  NSString+LLX.m
//  jobCompany
//
//  Created by liaolx on 15/12/31.
//  Copyright © 2015年 liaolx. All rights reserved.
//

#import "NSString+LLX.h"

@implementation NSString (LLX)


+ (NSString *)checkObject:(id)object {
    if (object == nil || object == NULL) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",object];
}

@end
