//
//  TimePublicMethod.m
//  FluentBus
//
//  Created by 666GPS on 2017/2/16.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "TimePublicMethod.h"

@implementation TimePublicMethod
#pragma mark -   计算某个时间点距离当前时间的时间差
+ (NSString *)CalculationTimeWith:(NSString *)stime
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    // 截止时间字符串格式
    NSString *expireDateStr = stime;
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    NSLog(@"%ld-%ld-%ld-%ld",(long)dateCom.day,(long)dateCom.hour,dateCom.minute,dateCom.second);
    NSString *timeStr = [NSString stringWithFormat:@"%ld天%ld小时%ld分",dateCom.day,dateCom.hour,dateCom.minute];
    
    return timeStr;
}
#pragma mark -   获取当前时间
+ (NSString *)getCurrentTime {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateformatter stringFromDate:now];
}
#pragma mark -   秒数转具体本地日期
+ (NSString *)timeFormatted:(NSInteger)totalSeconds{
    NSDate  *localeDate = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *strDate = [dateFormatter stringFromDate:localeDate];
    return strDate;
}
#pragma mark -   获取时间戳
+ (NSString *)getTimeInterval {
    
    return [NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970] * 1000];
    
}
#pragma mark -   根据时间日期获取时间戳
+ (NSTimeInterval)getSecondsWithDate:(NSDate *)date
{
    //    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    //    // 在 GMT 时间基础上追加时间差值，得到本地时间
    date = [date dateByAddingTimeInterval:-interval];
    NSTimeInterval timeStamp= [date timeIntervalSince1970];
    return timeStamp;
}

#pragma mark -   获取当前年份
+ (NSInteger)getCurrentYear {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return [dateComponent year];
    
}

#pragma mark -   获取当前月份
+ (NSInteger)getCurrentMonth {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return [dateComponent month];
    
}

#pragma mark -   获取毫秒数
+ (NSInteger)getCurrentMillisecond{
    
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    
    return recordTime;
}

#pragma mark -   日期转换为日期字符串
+ (NSString *)dateToDateString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}
#pragma mark -   获取本地当前时间
+ (NSDate *)getLocalCurrentDate {
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    NSDate *currentDate = [[NSDate date] dateByAddingTimeInterval:interval];
    return currentDate;
}
#pragma mark -  根据时间字符串和格式转换成日期
+ (NSDate *)dateWithString:(NSString *)time format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    NSDate *date = [inputFormatter dateFromString:time];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    date = [date dateByAddingTimeInterval:interval];
    return date;
}
#pragma mark -  获取day天后的日期(若day为负数,则为|day|天前的日期)
+ (NSDate *)dateAfterDay:(int)day {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    
    return [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    
}
#pragma mark -  13位的时间戳转标准时间
+(NSString *)getTimeString_13:(NSString *)timeS{
    if (timeS.length == 13) {
        NSString *timeStrStart = [NSString stringWithFormat:@"%@",timeS];
        timeStrStart = [timeStrStart substringToIndex:[timeStrStart length] - 3];
        NSDate  *localeDate = [NSDate dateWithTimeIntervalSince1970:[timeStrStart floatValue]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        NSString *startDate = [dateFormatter stringFromDate:localeDate];
        return startDate;
    }else{
        return @"暂无";
    }
}
#pragma mark -  格林尼治时间时间转本地时间
+ (NSDate *)convertGMTDatetoLocalDate:(NSDate *)GMTDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *gmtDateStr = [dateFormatter stringFromDate:GMTDate];
    NSTimeZone *gmt = [NSTimeZone systemTimeZone];
    
    [dateFormatter setTimeZone:gmt];
    
    NSDate *GMTTime = [dateFormatter dateFromString:gmtDateStr];
    
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    //    NSLog(@"%@",tz);
    NSInteger seconds = [tz secondsFromGMTForDate: GMTTime];
    //    NSLog(@"%ld",(long)seconds);
    //    NSLog(@"%@",[NSDate dateWithTimeInterval: seconds sinceDate: GMTTime]);
    return [NSDate dateWithTimeInterval: seconds sinceDate: GMTTime];
    
}
@end
