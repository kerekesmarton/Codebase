//
//  AppDelegate+SAF.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/19/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AppDelegate+SAF.h"
#import "RootViewController.h"
#import "SAFNavigationBar.h"
#import "WorkshopsDataManager.h"
#import "ArtistsDataManager.h"
#import "AFNetworking.h"

#import "SAFStartupManager.h"

#import "DownloadManager.h"

#import <SKMaps/SKMaps.h>
#import <objc/runtime.h>

@implementation AppDelegate (SAF)

-(UIImageView*)splash {
    static UIImageView *_splash;
    
    if (!_splash) {
        _splash = [[UIImageView alloc] init];
    }
    
    return _splash;
}

-(NSOperationQueue *)queue {
    
    static NSOperationQueue *_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queue = [[NSOperationQueue alloc] init];
    });
    return _queue;
}

-(void)removeSplash{
    
    [self.splash removeFromSuperview];
}

- (void)application:(UIApplication*)application performAppSpecificTasks:(NSDictionary *)launchOptions {
    
    [[VICoreDataManager getInstance] setResource:@"Model" database:@"coreDataModel8.sqlite"];
    
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UINavigationController *nav = [RootViewController navWithSuccess:^(id param) {
        if (param && [param isKindOfClass:[RootViewController class]]) {
            
            RootViewController *root = (RootViewController *)param;
            
            [[SAFStartupManager sharedInstance] startNewsRequestWithButtons:@[root.newsButton] activityIndicators:@[root.newsAI]];
            [[SAFStartupManager sharedInstance] startWorshopssRequestWithButtons:@[root.workshopsButton,root.myAgendaButton] activityIndicators:@[root.workshopsAI,root.myAgendaAI]];
            [[SAFStartupManager sharedInstance] startArtistsWithButtons:@[root.artistsButton] activityIndicators:@[root.artistsAI]];
            [[SAFStartupManager sharedInstance] startAgendaRequestWithButtons:@[root.scheduleButton] activityIndicators:@[root.scheduleAI]];
        }
    }];
    nav.navigationBar.translucent = NO;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //display splash screens
    self.splash.image = [UIImage imageNamed:@"splash"];
    self.splash.frame = self.window.frame;
    [self.window addSubview:self.splash];
#warning Change before release!!!
    [self.splash performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"splash2"] afterDelay:0.5];
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:1];
    
    //registering for APNS
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if (launchOptions != nil)
	{
		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			[self handleRemoteNotification:dictionary];
		}
	}
}

#pragma mark - push notifications

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    
#if !TARGET_IPHONE_SIMULATOR
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSString *deviceUuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSString *deviceName = [UIDevice currentDevice].name;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjects:@[
                                                                               deviceName,
                                                                               deviceUuid,
                                                                               deviceTokenStr,
                                                                               ]
                                                                     forKeys:@[
                                                                               @"name",
                                                                               @"device_id",
                                                                               @"registration_id",
                                                                               ]];

    AFHTTPClient *helper = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saf8.airedancecompany.ro"]];
    helper.parameterEncoding = AFJSONParameterEncoding;
    NSMutableURLRequest *urlRequest = [helper requestWithMethod:@"POST" path:@"/api/saf/apnsdevice/" parameters:params];    
    
    [[DownloadManager sharedInstance] performRequest:urlRequest withSuccessBlock:^(id response) {
        NSLog(@"%@",[response description]);
    } FailureBlock:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
#endif
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
#if !TARGET_IPHONE_SIMULATOR
    
	NSLog(@"Error in registration. Error: %@", err);
    
#endif
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
     
#if !TARGET_IPHONE_SIMULATOR
    
    [self handleRemoteNotification:userInfo];
    
#endif
    
}

- (void)handleRemoteNotification:(NSDictionary*)userInfo
{
    [ArtistsDataManager sharedInstance];
    [WorkshopsDataManager sharedInstance];
}

@end
