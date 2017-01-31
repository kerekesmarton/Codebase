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
        [ArtistsDataManager sharedInstance];
        SettingOption *workshopOption = [SettingsManager sharedInstance].workshopsFilter;
        NSMutableArray *items = [NSMutableArray array];
        for (NSString *obj in workshopOption.possibleValues) {
            SAFWorkshopsViewController *ws = [[SAFWorkshopsViewController alloc] init];
            ws.tabBarItem.title = [self configureTabBarItemString:obj];
            [items addObject:ws];
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
    }
    return self;
}

- (void)dealloc
{
    [self saveItemAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
