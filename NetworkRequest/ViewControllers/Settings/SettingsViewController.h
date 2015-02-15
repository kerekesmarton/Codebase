//
//  SettingsViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingsManager.h"

@class SettingsViewController;

@protocol SettingsProtocol <NSObject>
@required
-(void)settingsDidDismiss:(SettingsViewController*)settingsViewController;
@end



@interface SettingsViewController : UITableViewController

@property (nonatomic, weak) id <SettingsProtocol> presenter;
@property (nonatomic, retain) SettingOptionGroup *settingOptionGroup;

+(UINavigationController *)settingsViewControllerForOption:(SettingOptionGroup*)optionGroup andPresenter:(id<SettingsProtocol>)presenter;

-(IBAction)dismissTapped:(id)sender;

@end
