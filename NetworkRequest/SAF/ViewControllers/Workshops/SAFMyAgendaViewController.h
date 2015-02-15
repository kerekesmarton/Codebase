//
//  SAFMyAgendaViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 8/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFWorkshopsViewController.h"
#import "SAFWorkshopTabsViewController.h"

@interface SAFMyAgendaViewController : SAFWorkshopsViewController <SAFModalDelegate>

@property (nonatomic, assign) UIViewController <SAFModalDelegate> *modalDelegate;

@property (nonatomic, retain) NSDate *day;

@end
