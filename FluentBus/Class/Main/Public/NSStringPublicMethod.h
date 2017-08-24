//
//  NSStringPublicMethod.h
//  FluentBus
//
//  Created by 666GPS on 2017/2/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringPublicMethod : NSObject
/**
 *  判断字符串为空
 *
 *  @param str 字符串
 *
 *  @return YES为空
 */
+ (BOOL)isBlankString:(NSString *)str;
/**
 *  判断字符串是否为整形
 *
 *  @param string 要判断的字符串
 *
 *  @return 是否为整形
 */
+(BOOL)isPureInt:(NSString *)string;
/**
 *  判断字符串是否为浮点型
 *
 *  @param string 要判断的字符串
 *
 *  @return 是否为浮点型
 */
+(BOOL)isPureFloat:(NSString *)string;
/**
 *  根据文字的大小和确定高度 返回宽度
 *
 *  @param content 字符串的内容
 *  @param font    字符串的font
 *  @param size    确定的高度，无限的宽度
 *
 *  @return 字符串的宽度
 */
+(float)handelWideContent:(NSString *)content AndFontsize:(NSUInteger)font AndMaxsize:(CGSize )size;
/**
 *  根据文字的大小和确定的宽度 返回高度
 *
 *  @param content 字符串的内容
 *  @param font    字符串的font
 *  @param size    确定的宽度，无限的高度
 *
 *  @return 字符串的高度
 */
+(float)handelHighContent:(NSString *)content AndFontsize:(UIFont *)font AndMaxsize:(CGSize )size;
/**
 *  根据完整的电话号码获取缩略的电话号码
 *
 *  @param mobile 完整的电话号码 13808823215
 *
 *  @return 缩略的电话号码       138****3215
 */
+ (NSString *)getThumbnailMobileWithCompleteMobile:(NSString *)mobile;
/**
 *  十六进制字符串转十六进制字节流
 *
 *  @param hex 字符串
 *
 *  @return    字节流
 */
+ (NSData *)hexStringToHexData:(NSString *)hex;
/**
 *  十六进制字节流转十六进制字符串
 *
 *  @param hex 字节流
 *
 *  @return    字符串
 */
+ (NSString *)hexDataToHexString:(NSData *)hex;
/**
 *  十六进制GBK字符串转普通字符串
 *
 *  @param string GBK字符串
 *
 *  @return       普通字符串
 */
+ (NSString *)hexGBKStringToNormalString:(NSString *)string;
/**
 *  截取字符串中间部分
 *
 *  @param string 字符串
 *  @param head   头部位置
 *  @param tail   尾部位置
 *
 *  @return       结果字符串
 */
+ (NSString *)interceptMiddleString:(NSString *)string head:(NSUInteger)head andTail:(NSUInteger)tail;
/**
 *  十六进制ASCII字符串转普通字符串
 *
 *  @param string ASCII字符串
 *
 *  @return       普通字符串
 */
+ (NSString *)hexASCIIStringToNormalString:(NSString *)string;
/**
 *  十六进制字符串转十进制字符串
 *
 *  @param string 十六进制字符串
 *
 *  @return       十进制字符串
 */
+ (NSString *)hexStringToDecimalString:(NSString *)string;
/**
 *  对两个相等长度的字符串进行异或运算
 *
 *  @param pan  任意字符串
 *  @param pinv 任意字符串
 *
 *  @return     结果字符串
 */
+ (NSString *)pinxCreator:(NSString *)pan withPinv:(NSString *)pinv;
/**
 *  二进制 -> 十进制
 *
 *  @param binary 二进制
 *
 *  @return       十进制
 */
+ (NSString *)binaryToDecimal:(NSString *)binary;
/**
 *  二进制 -> 八进制
 *
 *  @param binary 二进制
 *
 *  @return       八进制
 */
+ (NSString *)binaryToQ:(NSString *)binary;
/**
 *  二进制 -> 十六进制
 *
 *  @param binary 二进制
 *
 *  @return       十六进制
 */
+ (NSString *)binaryToHex:(NSString *)binary;
/**
 *  八进制 -> 二进制
 *
 *  @param q 八进制
 *
 *  @return       二进制
 */
+ (NSString *)qToBinary:(NSString *)q;
/**
 *  八进制 -> 十进制
 *
 *  @param q 八进制
 *
 *  @return       十进制
 */
+ (NSString *)qToDecimal:(NSString *)q;
/**
 *  八进制 -> 十六进制
 *
 *  @param q 八进制
 *
 *  @return       十六进制
 */
+ (NSString *)qToHex:(NSString *)q;
/**
 *  十进制 -> 二进制
 *
 *  @param tmpid 十进制
 *
 *  @return       二进制
 */
+ (NSString *)decimalToBinary:(NSUInteger)tmpid;
/**
 *  十进制 -> 八进制
 *
 *  @param tmpid 十进制
 *
 *  @return       八进制
 */
+ (NSString *)decimalToQ:(NSUInteger)tmpid;
/**
 *  十进制 -> 十六进制
 *
 *  @param tmpid 十进制
 *
 *  @return       十六进制
 */
+ (NSString *)decimalToHex:(NSUInteger)tmpid;
/**
 *  十六进制 -> 二进制
 *
 *  @param hex 十六进制
 *
 *  @return       二进制
 */
+ (NSString *)hexToBinary:(NSString *)hex;
/**
 *  十六进制 -> 八进制
 *
 *  @param hex 十六进制
 *
 *  @return       八进制
 */
+ (NSString *)hexToQ:(NSString *)hex;
/**
 *  十六进制 -> 十进制
 *
 *  @param hex 十六进制
 *
 *  @return       十进制
 */
+ (NSString *)hexToDecimal:(NSString *)hex;
@end
