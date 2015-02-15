//
//  SettingsEnumControllerViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/15/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingsManager.h"

typedef void (^ DismissBlock)(void);

@interface SettingsEnumControllerViewController : UITableViewController

@property (nonatomic, strong) SettingOption *options;
@property (readwrite,nonatomic, copy) DismissBlock block;

@end
