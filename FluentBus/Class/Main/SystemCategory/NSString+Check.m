//
//  NSString+Check.m
//  jobStudentIos
//
//  Created by RousLee on 15/11/10.
//  Copyright © 2015年 KoOtave. All rights reserved.
//

#import "NSString+Check.h"

#define PHONENUMBER_REG @"^[1][34578][0-9]{9}$"

@implementation NSString (Check)

- (BOOL)checkPhoneNumberInput {
    
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    
////    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
////    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    BOOL res1 = [regextestmobile evaluateWithObject:self];
//    BOOL res2 = [regextestcm evaluateWithObject:self];
//    BOOL res3 = [regextestcu evaluateWithObject:self];
////    BOOL res4 = [regextestct evaluateWithObject:self];
//    
//    if (res1 || res2 || res3)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    
    /*
     * 移动联通电信三个一起的正则表达式
     *
     */
    
    NSString *regExp = @"^[1][34578][0-9]{9}$";
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExp];
    if ([regextestphs evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
    }

}

- (BOOL)checkEmailInput {
    
    NSString *EMAIL = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *regextestemail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAIL];
    
    BOOL res = [regextestemail evaluateWithObject:self];
    
    if (res) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isPassword
{
//    NSString *      regex = @"(^[_A-Za-z0-9]{6,16}$)";
    NSString *      regex = @"(^[_A-Za-z0-9]{6,150}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isTelephone
{
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    
//    return  [regextestmobile evaluateWithObject:self]   ||
//    [regextestphs evaluateWithObject:self]      ||
//    [regextestct evaluateWithObject:self]       ||
//    [regextestcu evaluateWithObject:self]       ||
//    [regextestcm evaluateWithObject:self];
    
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
//     * 联通：130,131,132,152,155,156,185,186,1709
//     * 电信：133,1349,153,180,189,1700
//     */
//    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186,1709
//     17         */
//    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189,1700,181
//                * 4G段 177
//     22         */
//    NSString * CT = @"^1((77||33|53|8[091])\\d|349|700)\\d{7}$";
//    
//    
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    
//    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
//    
//    if (([regextestcm evaluateWithObject:self] == YES)
//        || ([regextestct evaluateWithObject:self] == YES)
//        || ([regextestcu evaluateWithObject:self] == YES)
//        || ([regextestphs evaluateWithObject:self] == YES) || ([regextestmobile evaluateWithObject:self] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//    
//    
//    
    
    
    /*
     * 移动联通电信三个一起的正则表达式
     *
     */

    NSString *regExp = @"^[1][34578][0-9]{9}$";
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regExp];
    if ([regextestphs evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
    }
    
}

- (BOOL)isPhone
{
    NSString *      regex = @"^(\\d{3,4}-)\\d{7,8}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}





- (BOOL)QQ{
    NSString *      regex = @"^([1-9][0-9]*)$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];

}
//没做判断的电话号码
- (BOOL)isNotJudgeIsTelePhone{
    NSString *      regex = @"^[0-9]*$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}



/**
 
 *  验证身份证号码是否正确的方法
 
 *
 
 *  @param IDNumber 传进身份证号码字符串
 
 *
 
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 
 */

- (BOOL)isCorrect:(NSString *)IDNumber

{
    
    NSMutableArray *IDArray = [NSMutableArray array];
    
    // 遍历身份证字符串,存入数组中
    
    for (int i = 0; i < 18; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        
        NSString *subString = [IDNumber substringWithRange:range];
        
        [IDArray addObject:subString];
        
    }
    
    // 系数数组
    
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3",@"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    
    // 余数数组
    
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3",@"2", nil];
    
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    
    int sum = 0;
    
    for (int i = 0; i < 17; i++) {
        
        int coefficient = [coefficientArray[i] intValue];
        
        int ID = [IDArray[i] intValue];
        
        sum += coefficient * ID;
        
    }
    
    // 这个和除以11的余数对应的数
    
    NSString *str = remainderArray[(sum % 11)];
    
    // 身份证号码最后一位
    
    NSString *string = [IDNumber substringFromIndex:17];
    
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    
    if ([str isEqualToString:string]) {
        
        return YES;
        
    } else {
        
        return NO;
        
    }
    
}

#pragma mark - 判断汉字

- (BOOL)isChinese{
    
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}


- (BOOL)includeChinese{
    
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断是否都为整型数字

- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}



@end
