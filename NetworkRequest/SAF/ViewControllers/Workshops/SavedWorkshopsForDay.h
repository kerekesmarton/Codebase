//
//  MyWorkshops.h
//  NetworkRequest
//
//  Created by Marton Kerekes on 11/01/2017.
//  Copyright © 2017 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavedWorkshopsForDay : NSObject

@property NSDate *day;
@property NSDictionary *workshops;
@property NSArray *hours;

@end
