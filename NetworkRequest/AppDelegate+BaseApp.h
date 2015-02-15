//
//  AppDelegate+BaseApp.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/19/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BaseApp)

- (void)application:(UIApplication*)application performAppSpecificTasks:(NSDictionary *)launchOptions;
- (void)handleRemoteNotification:(NSDictionary*)userInfo;
@end
