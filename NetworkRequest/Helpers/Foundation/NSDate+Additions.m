//
//  NSDate+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/30/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+ (int)daysUntilNowFromDate:(NSDate *)date {
    NSDate *nowDate = [NSDate date];
    
    return [date numberOfDaysUntilDate:nowDate];
}

- (int)numberOfDaysUntilDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0.0];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:self toDate:[date zeroHourNormalized] options:0];
    
    return [components day];
}

- (NSArray *)lastWeekDays {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0.0];
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat secondsInADay = 86400.0;
    for (int i = 1; i < 7; i++) {
        NSDate *date = [self dateByAddingTimeInterval:-secondsInADay * i];
        NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:date];
        [array addObject:[NSNumber numberWithInt:components.weekday]];
    }
    
    return array;
}

- (NSDate *)midnightHourNormalized {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0.0];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    CGFloat time = components.hour * 3600.0 + components.minute * 60.0 + components.second;
    
    return [self dateByAddingTimeInterval:86400 - time];
}

- (NSDate *)zeroHourNormalized {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0.0];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    CGFloat time = components.hour * 3600.0 + components.minute * 60.0 + components.second;
    
    return [self dateByAddingTimeInterval:-time];
}

- (NSDateComponents *)dateComponentsToPresent:(int)components {
    NSDate *nowDate = [[NSDate date] midnightHourNormalized];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0.0];
    
    return [calendar components:components fromDate:self toDate:nowDate options:0];
}

- (int)daysToPresent {
    return [[self dateComponentsToPresent:NSDayCalendarUnit] day];
}

- (int)weeksToPresent {
    return [[self dateComponentsToPresent:NSWeekCalendarUnit] week];
}

- (int)monthsToPresent {
    return [[self dateComponentsToPresent:NSMonthCalendarUnit] month];
}

- (int)yearsToPresent {
    return [[self dateComponentsToPresent:NSYearCalendarUnit] year];
}

@end
