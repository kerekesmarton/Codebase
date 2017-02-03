//
//  SAGWorkshopsViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WorkshopsViewController.h"

@interface SAFWorkshopsViewController : WorkshopsViewController

- (instancetype)init __attribute__((unavailable("use initWithDay")));
- (instancetype)initWithDay:(NSDate *)day;

@end
