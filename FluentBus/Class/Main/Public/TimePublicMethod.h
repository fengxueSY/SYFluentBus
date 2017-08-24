//
//  TimePublicMethod.h
//  FluentBus
//
//  Created by 666GPS on 2017/2/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimePublicMethod : NSObject
/**
 *  计算某个时间点距离当前时间的时间差
 *
 *  @param stime 要计算的某个时间
 *
 *  @return 返回时间差
 */
+ (NSString *)CalculationTimeWith:(NSString *)stime;
/**
 *  获取当前时间
 *
 *  @return 当前时间字符串
 */
+ (NSString *)getCurrentTime;
/**
 *  秒数转成本地时间 yyyy-MM-dd HH:mm:ss
 *
 *  @param totalSeconds 要转换的秒数
 *
 *  @return 转换后的时间
 */
+ (NSString *)timeFormatted:(NSInteger)totalSeconds;
/**
 *  格林尼治时间时间转本地时间
 *
 *  @param GMTDate 格林尼治时间
 *
 *  @return 转换后的本地时间
 */
+ (NSDate *)convertGMTDatetoLocalDate:(NSDate *)GMTDate;
/**
 *  根据时间日期获取时间戳
 *
 *  @param date 日期
 *
 *  @return 时间戳
 */
+(NSTimeInterval)getSecondsWithDate:(NSDate *)date;
/**
 *  日期转换为日期字符串
 *
 *  @param date 日期
 *
 *  @return 日期字符串
 */
+ (NSString *)dateToDateString:(NSDate *)date;
/**
 *  日期字符串转换为日期
 *
 *  @param time   日期字符串
 *  @param format 转为日期的格式
 *
 *  @return 日期
 */
+ (NSDate *)dateWithString:(NSString *)time format:(NSString *)format;
/**
 *  获取本地当前时间
 *
 *  @return 当前时间
 */
+ (NSDate *)getLocalCurrentDate;
/**
 *  获取当前时间戳
 *
 *  @return 当前时间戳
 */
+ (NSString *)getTimeInterval;
/**
 *  获取当前年份
 *
 *  @return 当前年份
 */
+ (NSInteger)getCurrentYear;
/**
 *  获取当前月份
 *
 *  @return 当前月份
 */
+ (NSInteger)getCurrentMonth;
/**
 *  获取毫秒数
 *
 *  @return 当前毫秒数
 */
+ (NSInteger)getCurrentMillisecond;
/**
 *  获取day天后的日期(若day为负数,则为|day|天前的日期)
 *
 *  @param day day
 *
 *  @return 时间
 */
+ (NSDate *)dateAfterDay:(int)day;
/**
 *  13位的时间戳转标准时间
 *
 *  @param timeS 13位的时间戳
 *
 *  @return 标准时间
 */
+(NSString *)getTimeString_13:(NSString *)timeS;
@end
