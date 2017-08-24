//
//  NSStringPublicMethod.m
//  FluentBus
//
//  Created by 666GPS on 2017/2/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "NSStringPublicMethod.h"


static NSMutableDictionary *_bitHexDic;
static NSMutableDictionary *_tenHexDic;
static NSMutableDictionary *_bitQDic;


@implementation NSStringPublicMethod
#pragma mark -  判断字符串为空
+ (BOOL)isBlankString:(NSString *)str{
    if (str == nil) {
        return YES;
    }
    if (str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ==0) {
        return  YES;
    }
    return NO;
}

#pragma mark -   判断字符串是否为整形
+(BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark -   判断字符串是否为浮点型
+(BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark -  根据文字的大小和确定高度 返回宽度
+(float)handelWideContent:(NSString *)content AndFontsize:(NSUInteger)font AndMaxsize:(CGSize)size{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary * attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize h = [content boundingRectWithSize:size options:    NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return h.width;
}

#pragma mark -  根据文字的大小和确定的宽度 返回高度
+(float)handelHighContent:(NSString *)content AndFontsize:(UIFont *)font AndMaxsize:(CGSize )size{
    CGSize temp = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    return temp.height;
}

#pragma mark -  根据完整的电话号码获取缩略的电话号码
+ (NSString *)getThumbnailMobileWithCompleteMobile:(NSString *)mobile {
    return [NSString stringWithFormat:@"%@%@%@", [mobile substringToIndex:3], @"****", [mobile substringFromIndex:7]];
}

#pragma mark ===================================================
#pragma mark                       进制转换
#pragma mark ===================================================
#pragma mark - 十六进制字符串转十六进制字节流
+ (NSData *)hexStringToHexData:(NSString *)hex {
    unsigned long len = hex.length / 2;
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < hex.length / 2; i++) {
        byte_chars[0] = [hex characterAtIndex:i*2];
        byte_chars[1] = [hex characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    NSData *data = [NSData dataWithBytes:buf length:len];
    free(buf);
    return data;
}

#pragma mark - 十六进制字节流转十六进制字符串
+ (NSString *)hexDataToHexString:(NSData *)hex {
    NSUInteger len = hex.length;
    char *ch = (char *)hex.bytes;
    NSMutableString *hexString = [NSMutableString string];
    for (NSUInteger i = 0; i < len; i++ ) {
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", ch[i]]];
    }
    return hexString;
}

#pragma mark - 十六进制GBK字符串转普通字符串
+ (NSString *)hexGBKStringToNormalString:(NSString *)string {
    NSData *hexGBKData = [NSStringPublicMethod hexStringToHexData:string];
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [[NSString alloc] initWithData:hexGBKData encoding:gbkEncoding];
}

#pragma mark - 截取字符串中间部分
+ (NSString *)interceptMiddleString:(NSString *)string head:(NSUInteger)head andTail:(NSUInteger)tail {
    NSUInteger location = head;
    NSUInteger length = string.length - head - tail;
    return [string substringWithRange:NSMakeRange(location, length)];
}

#pragma mark - 十六进制ASCII字符串转普通字符串
+ (NSString *)hexASCIIStringToNormalString:(NSString *)string {
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < string.length / 2; i++) {
        char ch1 = [string characterAtIndex:i * 2];
        char ch2 = [string characterAtIndex:i * 2 + 1];
        NSString *item = [NSString stringWithFormat:@"%c", [NSStringPublicMethod hexToDecimal:[NSString stringWithFormat:@"%c%c", ch1, ch2]].intValue];
        [resultString appendString:item];
    }
    return resultString;
}

#pragma mark - 十六进制字符串转十进制字符串
+ (NSString *)hexStringToDecimalString:(NSString *)string {
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < string.length / 2; i++) {
        char ch1 = [string characterAtIndex:i * 2];
        char ch2 = [string characterAtIndex:i * 2 + 1];
        NSString *item = [NSStringPublicMethod hexToDecimal:[NSString stringWithFormat:@"%c%c", ch1, ch2]];
        [resultString appendString:item];
    }
    return [NSString stringWithFormat:@"%d", resultString.intValue];
}
#pragma mark - 对两个相等长度的字符串进行异或运算
+ (NSString *)pinxCreator:(NSString *)pan withPinv:(NSString *)pinv {
    if (pan.length != pinv.length) {
        return nil;
    }
    const char *panchar = pan.UTF8String;
    const char *pinvchar = pinv.UTF8String;
    NSString *temp = [NSString string];
    for (int i = 0; i < pan.length; i++) {
        int panValue = [self charToint:panchar[i]];
        int pinvValue = [self charToint:pinvchar[i]];
        temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%X", panValue ^ pinvValue]];
    }
    return temp;
}
+ (int)charToint:(char)tempChar {
    if (tempChar >= '0' && tempChar <='9') {
        return tempChar - '0';
    } else if (tempChar >= 'A' && tempChar <= 'F') {
        return tempChar - 'A' + 10;
    }
    return 0;
}

#pragma mark -  二进制 -> 十进制
+ (NSString *)binaryToDecimal:(NSString *)binary {
    NSUInteger decimal = 0;
    for (NSInteger index = 0; index < binary.length; index++) {
        double num = [[binary substringWithRange:(NSRange){binary.length - index - 1, 1}] doubleValue];
        decimal +=  num * pow(2, index);
    }
    return [NSString stringWithFormat:@"%ld", (long)decimal];
}

#pragma mark -  二进制 -> 八进制
+ (NSString *)binaryToQ:(NSString *)binary {
    return [self decimalToQ:[[self binaryToDecimal:binary] integerValue]];
}

#pragma mark -  二进制 -> 十六进制
+ (NSString *)binaryToHex:(NSString *)binary {
    return [self decimalToHex:[[self binaryToDecimal:binary] integerValue]];
}

#pragma mark -  八进制 -> 二进制
+ (NSString *)qToBinary:(NSString *)q {
    NSMutableString *str = [NSMutableString stringWithString:@""];
    NSUInteger count = q.length;
    for (NSInteger index = 0; index < count; index++) {
        NSString *appendStr = [[self bitQDic] objectForKey:[q substringWithRange:(NSRange){index, 1}]];
        if(index == 0) {
            appendStr = [NSString stringWithFormat:@"%ld", (long)[appendStr integerValue]];
        }
        [str appendString:appendStr];
    }
    return str;
}

#pragma mark -  八进制 -> 十进制
+ (NSString *)qToDecimal:(NSString *)q {
    return [self binaryToDecimal:[self qToBinary:q]];
}

#pragma mark -  八进制 -> 十六进制
+ (NSString *)qToHex:(NSString *)q {
    return [self binaryToHex:[self qToBinary:q]];
}

#pragma mark -  十进制 -> 二进制
+ (NSString *)decimalToBinary:(NSUInteger)tmpid {
    return [self tenToOtherWithNum:tmpid system:2];
}

#pragma mark -  十进制 -> 八进制
+ (NSString *)decimalToQ:(NSUInteger)tmpid {
    return [self tenToOtherWithNum:tmpid system:8];
}

#pragma mark -  十进制 -> 十六进制
+ (NSString *)decimalToHex:(NSUInteger)tmpid {
    NSMutableString *str = [NSMutableString stringWithString:@""];
    while (tmpid) {
        [str insertString:[[self tenHexDic] objectForKey:[NSString stringWithFormat:@"%ld", (long)(tmpid % 16)]] atIndex:0];
        tmpid /= 16;
    }
    return str;
}

#pragma mark -  十六进制 -> 二进制
+ (NSString *)hexToBinary:(NSString *)hex {
    NSMutableString *str = [NSMutableString stringWithString:@""];
    NSUInteger count = hex.length;
    for (NSInteger index = 0; index < count; index++) {
        NSString *appendStr = [[self bitHexDic] objectForKey:[hex substringWithRange:(NSRange){index, 1}]];
        if(index == 0){
            // 过滤前面的0
            appendStr = [NSString stringWithFormat:@"%ld", (long)[appendStr integerValue]];
        }
        [str appendString:appendStr];
    }
    return str;
}

#pragma mark -  十六进制 -> 八进制
+ (NSString *)hexToQ:(NSString *)hex {
    return [self binaryToQ:[self hexToBinary:hex]];
}

#pragma mark -  十六进制 -> 十进制
+ (NSString *)hexToDecimal:(NSString *)hex {
    return [self binaryToDecimal:[self hexToBinary:hex]];
}

#pragma mark -  进制转换要用到的方法
+ (NSMutableDictionary *)bitHexDic {
    if(_bitHexDic == nil) {
        
        NSMutableDictionary *hex = [[NSMutableDictionary alloc] initWithCapacity:16];
        
        [hex setObject:@"0000" forKey:@"0"];
        
        [hex setObject:@"0001" forKey:@"1"];
        
        [hex setObject:@"0010" forKey:@"2"];
        
        [hex setObject:@"0011" forKey:@"3"];
        
        [hex setObject:@"0100" forKey:@"4"];
        
        [hex setObject:@"0101" forKey:@"5"];
        
        [hex setObject:@"0110" forKey:@"6"];
        
        [hex setObject:@"0111" forKey:@"7"];
        
        [hex setObject:@"1000" forKey:@"8"];
        
        [hex setObject:@"1001" forKey:@"9"];
        
        [hex setObject:@"1010" forKey:@"A"];
        
        [hex setObject:@"1011" forKey:@"B"];
        
        [hex setObject:@"1100" forKey:@"C"];
        
        [hex setObject:@"1101" forKey:@"D"];
        
        [hex setObject:@"1110" forKey:@"E"];
        
        [hex setObject:@"1111" forKey:@"F"];
        
        _bitHexDic = hex;
    }
    return _bitHexDic;
}

+ (NSMutableDictionary *)tenHexDic {
    if(_tenHexDic == nil) {
        
        NSMutableDictionary *hex = [[NSMutableDictionary alloc] initWithCapacity:16];
        
        [hex setObject:@"0" forKey:@"0"];
        
        [hex setObject:@"1" forKey:@"1"];
        
        [hex setObject:@"2" forKey:@"2"];
        
        [hex setObject:@"3" forKey:@"3"];
        
        [hex setObject:@"4" forKey:@"4"];
        
        [hex setObject:@"5" forKey:@"5"];
        
        [hex setObject:@"6" forKey:@"6"];
        
        [hex setObject:@"7" forKey:@"7"];
        
        [hex setObject:@"8" forKey:@"8"];
        
        [hex setObject:@"9" forKey:@"9"];
        
        [hex setObject:@"A" forKey:@"10"];
        
        [hex setObject:@"B" forKey:@"11"];
        
        [hex setObject:@"C" forKey:@"12"];
        
        [hex setObject:@"D" forKey:@"13"];
        
        [hex setObject:@"E" forKey:@"14"];
        
        [hex setObject:@"F" forKey:@"15"];
        
        _tenHexDic = hex;
        
    }
    return _tenHexDic;
}
+ (NSMutableDictionary *)bitQDic {
    
    if(_bitQDic == nil) {
        NSMutableDictionary *hex = [[NSMutableDictionary alloc] initWithCapacity:8];
    
        [hex setObject:@"000" forKey:@"0"];
        
        [hex setObject:@"001" forKey:@"1"];
        
        [hex setObject:@"010" forKey:@"2"];
        
        [hex setObject:@"011" forKey:@"3"];
        
        [hex setObject:@"100" forKey:@"4"];
        
        [hex setObject:@"101" forKey:@"5"];
        
        [hex setObject:@"110" forKey:@"6"];
        
        [hex setObject:@"111" forKey:@"7"];
        _bitQDic = hex;
    }
    return _bitQDic;
}
+ (NSString *)tenToOtherWithNum:(NSUInteger)num system:(NSUInteger)system {
    NSMutableString *str = [NSMutableString stringWithString:@""];
    while (num) {
        [str insertString:[NSString stringWithFormat:@"%ld", (long)(num % system)] atIndex:0];
        num /= system;
    }
    return str;
}

#pragma mark ===================================================
#pragma mark                       进制转换
#pragma mark ===================================================
@end
