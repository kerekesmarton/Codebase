//
//  SAFSettingsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFSettingsViewController.h"
#import "SAFNavigationBar.h"

@interface SAFSettingsViewController ()

@end

@implementation SAFSettingsViewController

+(UINavigationController *)settingsViewControllerForOption:(SettingOptionGroup*)optionGroup andPresenter:(id<SettingsProtocol>)presenter{
    
    SettingsViewController *settings = [[SettingsViewController alloc] initWithNibName:NSStringFromClass([SettingsViewController class]) bundle:nil];
    settings.presenter = presenter;
    settings.settingOptionGroup = optionGroup;
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.toolbar.barStyle = UIBarStyleBlackOpaque;
    navController.navigationBar.translucent = NO;
    navController.viewControllers = @[settings];
    
    if ([navController.navigationBar respondsToSelector:@selector(barTintColor)]) {
        navController.navigationBar.barTintColor = [UIColor blackColor];
        navController.navigationBar.tintColor = [UIColor whiteColor];
        [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        navController.navigationBar.translucent = NO;
    }
    
    return navController;
}

@end
