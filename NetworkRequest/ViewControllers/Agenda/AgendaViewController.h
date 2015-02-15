//
//  AgendaViewController.h
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/26/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaDataManger.h"
#import "AgendaObject.h"

@interface AgendaViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *items;
@property (nonatomic, strong) NSArray *sortedDays;

@end
