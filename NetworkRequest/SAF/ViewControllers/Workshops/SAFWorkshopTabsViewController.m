//
//  SAFWorkshopTabsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFWorkshopTabsViewController.h"
#import "SAFWorkshopsViewController.h"
#import "SettingsManager.h"
#import "ArtistsDataManager.h"
#import "WorkshopObject.h"
#import "SAFNavigationBar.h"

@interface SAFWorkshopTabsViewController ()

@end

@implementation SAFWorkshopTabsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.allDays = [WorkshopObject distinctWorkshopDays];

        if (!self.day) {
            self.day = [self.allDays firstObject];
        }

        NSAssert(self.day, @"Day should have been set");

        SettingOption *workshopOption = [SettingsManager sharedInstance].workshopsFilter;
        NSMutableArray *items = [NSMutableArray array];
        for (NSString *obj in workshopOption.possibleValues) {
            SAFWorkshopsViewController *workshopsViewController = [[SAFWorkshopsViewController alloc] init];
            workshopsViewController.tabBarItem.title = [self configureTabBarItemString:obj];
            workshopsViewController.day = self.day;
            [items addObject:workshopsViewController];
        }
        self.viewControllers = items;

        [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];

        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], NSForegroundColorAttributeName,
          [UIFont fontWithName:futuraCondendsedBold size:12], NSFontAttributeName,
          nil] forState:UIControlStateSelected];
        
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor redColor], NSForegroundColorAttributeName,
          [UIFont fontWithName:futuraCondendsedBold size:12], NSFontAttributeName,
          nil] forState:UIControlStateNormal];

        self.headerDateFormatter = [NSDateFormatter new];
        _headerDateFormatter.timeStyle = NSDateFormatterNoStyle;
        _headerDateFormatter.dateFormat = @"EEEE";

        NSUInteger index = [self.allDays indexOfObject:self.day];
        if (self.allDays.count >= index+1) {
            self.nextDay = self.allDays[index+1];
            NSString *nextDayTitle = [_headerDateFormatter stringFromDate:self.nextDay];
            NSString *todayTitle = [_headerDateFormatter stringFromDate:self.day];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nextDayTitle style:UIBarButtonItemStyleDone target:self action:@selector(goToNextDay)];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:todayTitle style:UIBarButtonItemStyleDone target:nil action:nil];
        }
    }
    return self;
}

- (void)dealloc
{
    [self saveItemAtIndex:0];
}

-(NSString*)configureTabBarItemString:(NSString*)str {
    
    NSString *res = [str stringByReplacingOccurrencesOfString:@"room" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [str length])];
    res = [res stringByReplacingOccurrencesOfString:@"treatment" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [res length])];
    
    return res;
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    int index = (int)[tabBar.items indexOfObject:item];
    [self saveItemAtIndex:index];
}

-(void)saveItemAtIndex:(int)index {
    SettingOption *workshopOption = [SettingsManager sharedInstance].workshopsFilter;
    if (workshopOption.possibleValues.count && workshopOption.possibleValues.count >= index) {
        id obj = [workshopOption.possibleValues objectAtIndex:index];
        workshopOption.selectedValues = @[obj];
        [workshopOption save];
    }
}

- (void)goToNextDay {
    SAFWorkshopTabsViewController *nextVC = [[SAFWorkshopTabsViewController alloc] init];
    nextVC.allDays = self.allDays;
    nextVC.day = self.nextDay;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
