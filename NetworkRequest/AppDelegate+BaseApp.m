//
//  AppDelegate+BaseApp.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/19/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AppDelegate+BaseApp.h"
#import "CustomSlideViewControllerPhone.h"
#import "VICoreDataManager.h"

@implementation AppDelegate (BaseApp)

- (void)application:(UIApplication*)application performAppSpecificTasks:(NSDictionary *)launchOptions {
    
    [[VICoreDataManager getInstance] setResource:@"Model" database:@"coreDataModel.sqlite"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[CustomSlideViewControllerPhone alloc] initWithNibName:@"SlideViewController" bundle:nil];;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

- (void)handleRemoteNotification:(NSDictionary*)userInfo
{

}

@end
