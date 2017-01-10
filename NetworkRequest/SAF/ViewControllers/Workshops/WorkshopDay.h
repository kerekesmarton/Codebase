//
//  WorkshopDay.h
//  NetworkRequest
//
//  Created by Marton Kerekes on 09/01/2017.
//  Copyright © 2017 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkshopDay : NSObject

@property NSDate *day;
@property NSArray *workshops;
@property NSArray *distinctHours;

@end
