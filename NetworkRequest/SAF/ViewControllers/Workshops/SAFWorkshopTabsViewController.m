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
@synthesize modalDelegate;
@synthesize day;

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
        
        CGSize imageSize = CGSizeMake(40, 40);
        UIColor *fillColor = [UIColor blackColor];
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [fillColor setFill];
        CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.tabBar setBackgroundImage:image];
        
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor], UITextAttributeTextColor,
          [UIFont fontWithName:@"edo" size:12], UITextAttributeFont,
          nil] forState:UIControlStateHighlighted];
        
        [[UITabBarItem appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor orangeColor], UITextAttributeTextColor,
          [UIFont fontWithName:@"edo" size:12], UITextAttributeFont,
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configureNavigation];
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
    if (workshopOption.possibleValues.count >= index) {
        id obj = [workshopOption.possibleValues objectAtIndex:index];
        workshopOption.selectedValues = @[obj];
        [workshopOption save];
    }
}

-(void)configureNavigation {
    
    //decide if there is a day before this.
    
    
    if ([self.day compare: [[SettingsManager sharedInstance].selectedDay.possibleValues firstObject]]==NSOrderedSame) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sunday" style:UIBarButtonItemStylePlain target:self action:@selector(nextDay:)];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(flipAndPop)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Saturday" style:UIBarButtonItemStylePlain target:self action:@selector(previousDay:)];
    }
    
}

-(void)previousDay:(UIBarButtonItem *)sender {
    
    NSArray *days = [WorkshopObject distinctWorkshopDays];
    
    if (days.count) {
        NSDate *firstDay = [days firstObject];
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:firstDay];
    }
    [self flip];
    
}

-(void)nextDay:(UIBarButtonItem *)sender {
    
    NSArray *days = [WorkshopObject distinctWorkshopDays];
    
    if (days.count) {
        NSDate *lastDay = [days lastObject];
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:lastDay];
        
        SAFWorkshopTabsViewController *next = [[SAFWorkshopTabsViewController alloc] init];
        next.day = lastDay;
        next.modalDelegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        navController.toolbar.barStyle = UIBarStyleBlackOpaque;
        navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        navController.viewControllers = @[next];
        
        [self.navigationController presentViewController:navController animated:YES completion:^{
            
        }];
    }
}

-(void)flipAndPop {
    if (self.modalDelegate && [self.modalDelegate respondsToSelector:@selector(popModalWithCompletion:)]) {
        [self.modalDelegate popModalWithCompletion:^{
            [self.modalDelegate.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)flip {
    if (self.modalDelegate && [self.modalDelegate respondsToSelector:@selector(popModalWithCompletion:)]) {
        [self.modalDelegate popModalWithCompletion:^{
            //
        }];
    }
}

-(void)popModalWithCompletion:(void (^)(void))block {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        block();
    }];
}

@end
