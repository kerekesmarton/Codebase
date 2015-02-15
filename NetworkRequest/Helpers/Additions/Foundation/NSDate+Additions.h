//
//  NSDate+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/30/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (int)daysUntilNowFromDate:(NSDate *)date;

- (int)numberOfDaysUntilDate:(NSDate *)date;

- (NSDate *)zeroHourNormalized;
- (NSDate *)midnightHourNormalized;

- (NSArray *)lastWeekDays;
- (int)daysToPresent;
- (int)weeksToPresent;
- (int)monthsToPresent;
- (int)yearsToPresent;

@end
