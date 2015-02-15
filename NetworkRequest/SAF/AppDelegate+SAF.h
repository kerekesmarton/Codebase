//
//  AppDelegate+SAF.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/19/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AppDelegate.h"

@class RootViewController;

@interface AppDelegate (SAF)

@property (nonatomic, readonly) UIImageView   *splash;
@property (nonatomic, readonly) NSOperationQueue *queue;

- (void)application:(UIApplication*)application performAppSpecificTasks:(NSDictionary *)launchOptions;
- (void)handleRemoteNotification:(NSDictionary*)userInfo;
@end
