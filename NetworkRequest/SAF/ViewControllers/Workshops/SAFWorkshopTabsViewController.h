//
//  SAFWorkshopTabsViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAFModalDelegate <NSObject>

-(void)popModalWithCompletion:(void (^) (void))block;

@end

@interface SAFWorkshopTabsViewController : UITabBarController <SAFModalDelegate>

@property (nonatomic, assign) UIViewController <SAFModalDelegate> *modalDelegate;

@property (nonatomic, retain) NSDate *day;

@end
