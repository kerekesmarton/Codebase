//
//  SAFWorkshopTabsViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAFWorkshopTabsViewController : UITabBarController

@property (nonatomic) NSDate *day;
@property (nonatomic) NSDate *nextDay;
@property(nonatomic) NSArray *allDays;
@property(nonatomic) NSDateFormatter *headerDateFormatter;

@end
