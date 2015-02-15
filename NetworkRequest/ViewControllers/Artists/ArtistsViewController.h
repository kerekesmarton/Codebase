//
//  ArtistsViewController.h
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface ArtistsViewController : UITableViewController <SettingsProtocol>

@property (nonatomic, strong) NSArray *items;

@end
