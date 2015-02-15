//
//  NSDateHelper.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/30/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+(NSDate *)begginingOfDay:(NSDate *)date;
+(NSDate *)endOfDay:(NSDate *)date;
+(NSNumber *)weekdayOfDay:(NSDate *)date;
@end
