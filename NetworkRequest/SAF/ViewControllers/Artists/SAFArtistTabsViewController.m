//
//  SAFArtistTabsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/22/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFArtistTabsViewController.h"
#import "SettingsManager.h"
#import "SAFArtistsViewController.h"

@interface SAFArtistTabsViewController ()

@end

@implementation SAFArtistTabsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self saveItemAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SettingOption *artistsOptions = [SettingsManager sharedInstance].artistsFilter;
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *obj in artistsOptions.possibleValues) {
        SAFArtistsViewController *artists = [[SAFArtistsViewController alloc] init];
        artists.tabBarItem.title = obj;
        artists.tabBarItem.image = [UIImage imageNamed:obj];
        [items addObject:artists];
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
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:futuraCondendsedBold size:12], NSFontAttributeName,
      nil] forState:UIControlStateHighlighted];
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor redColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:futuraCondendsedBold size:12], NSFontAttributeName,
      nil] forState:UIControlStateNormal];

}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    
    NSUInteger index = [tabBar.items indexOfObject:item];
    
    [self saveItemAtIndex:index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveItemAtIndex:(NSUInteger)index {
    SettingOption *artistOption = [SettingsManager sharedInstance].artistsFilter;
    if (artistOption.possibleValues.count >= index) {
        id obj = [artistOption.possibleValues objectAtIndex:index];
        artistOption.selectedValues = @[obj];
        [artistOption save];
    }
}

@end
