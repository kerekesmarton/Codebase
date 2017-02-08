//
//  ViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDataManager.h"
#import "DetailsViewController.h"
#import "SettingsViewController.h"


@interface NewsViewController : UITableViewController <SettingsProtocol>

@property (nonatomic, strong) NSArray *items;
- (void)startRefresh;
@end
