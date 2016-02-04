//
//  RootViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/19/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "RootViewController.h"
#import "SAFNavigationBar.h"
#import "CreditsViewController.h"
#import "SAFNewsViewController.h"
#import "SAFArtistTabsViewController.h"
#import "SAFWorkshopTabsViewController.h"
#import "SAFAgendaViewController.h"
#import "UIViewController+Shareing.h"
#import "WorkshopObject.h"


#import "SAFMyAgendaViewController.h"
#import "SAFMapViewController.h"
#import "RootViewController+UICreation.h"


#import "SAFStartupManager.h"

@interface RootViewController () <UIActionSheetDelegate>

@property (nonatomic, copy) viewDidLoadBlock block;
@end

@implementation RootViewController

+(UINavigationController *)navWithSuccess:(viewDidLoadBlock)viewDidLoadBlock
{
    
    RootViewController *viewcontroller = [[RootViewController alloc] init];
    viewcontroller.block = viewDidLoadBlock;
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.toolbar.barStyle = UIBarStyleBlackOpaque;
    navController.viewControllers = @[viewcontroller];
    
    if ([navController.navigationBar respondsToSelector:@selector(barTintColor)]) {
        navController.navigationBar.barTintColor = [UIColor blackColor];
        navController.navigationBar.tintColor = [UIColor whiteColor];
        [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        navController.navigationBar.translucent = NO;
    }    
    return navController;
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
//    this will generate the following four buttons, don't reverse their order.
    [self createUI];
    self.block(self);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openFunction:(NSInteger)functionNumber sender:(id)sender
{
    NSArray *viewcontrollers = nil;
    UIViewController *viewController = nil;
    
    switch (functionNumber) {
        case RootFunctionNews:
            //news
            viewController = [[SAFNewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
            break;
        case RootFunctionWorkshops: {
            //workshops
            viewController = [[SAFWorkshopTabsViewController alloc] init];
            NSArray *days = [WorkshopObject distinctWorkshopDays];
            if (days.count) {
                [[SettingsManager sharedInstance].selectedDay addPossibleValues:days];
                NSDate *day = [days objectAtIndex:0];
                [[SettingsManager sharedInstance].selectedDay addToSelectedValues:day];
                [(SAFWorkshopTabsViewController *)viewController setDay:day];
            }
        }
            break;
        case RootFunctionMyAgenda: {
            //my agenda
            viewController = [[SAFMyAgendaViewController alloc] init];
            NSArray *days = [WorkshopObject distinctWorkshopDays];
            if (days.count) {
                [[SettingsManager sharedInstance].selectedDay addPossibleValues:days];
                NSDate *day = [days objectAtIndex:0];
                [[SettingsManager sharedInstance].selectedDay addToSelectedValues:day];
                [(SAFMyAgendaViewController *)viewController setDay:day];
            }
        }
            break;
        case RootFunctionArtists:
            //artists
            viewController = [[SAFArtistTabsViewController alloc] init];
            break;
        case RootFunctionMap: {
            //map
            viewController = [[SAFMapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
            break;
        }
        case RootFunctionSchedule:
            //schedule
            viewController = [[SAFAgendaViewController alloc] init];
            break;
            
        case RootFunctionShare:
            //share
            [self preConfigureSharing];
            [self share:sender];
            return;
            break;
            
        case RootFunctionCredits:
            //credits
            [self credits:sender];
            return;
            break;
            
        default:
            return;//sharing is treated by an action sheet
            break;
    }
    
    if (viewcontrollers)
    {
        [self.navigationController setViewControllers:viewcontrollers animated:YES];
    } else {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

-(void)buttonPressed:(id)sender
{
    
    UIButton *buttonPressed = (UIButton*)sender;
    NSInteger tag = (NSInteger)buttonPressed.tag;
    
    [self openFunction:tag sender:sender];
}

- (void)credits:(id)sender
{
    
    UIActionSheet *credits = [[UIActionSheet alloc] initWithTitle:@"Version 7.0, Thanks to" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"AIRE Dance Company",@"Nuvo Studio",@"Advents", nil];
    credits.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    credits.tag = 2;
    [credits showInView:self.navigationController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if ([self shareActionSheet:actionSheet acionForIndex:buttonIndex]) {
        return;
    }
    if (actionSheet.tag == 2) {
        
        CreditsViewController *credits = nil;
        switch (buttonIndex) {
            case 0:
            {
                credits = [[CreditsViewController alloc] initWithName:@"AIRE"];
            }
                break;
            case 1:
            {
                credits = [[CreditsViewController alloc] initWithName:@"Nuvo"];
            }
                break;
            case 2:
            {
                credits = [[CreditsViewController alloc] initWithName:@"Advents"];
            }
                
            default:
                break;
        }
        
        if (credits) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:credits];
            nav.navigationBar.barStyle = UIBarStyleBlackOpaque;
            nav.toolbar.barStyle = UIBarStyleBlackOpaque;
            nav.modalPresentationStyle = UIModalPresentationPageSheet;
            nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self presentViewController:nav animated:YES completion:^{
                //
            }];
        }
    }
}

- (void)preConfigureSharing
{
    self.useMedia = YES;
    self.postImage = nil;
    self.postText = @"I'm attending the 7th Salsa Addicted Festival! We know how to party!";
}


@end
