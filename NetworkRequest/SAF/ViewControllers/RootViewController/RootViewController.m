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
#import "SAFNewsViewController.h"
#import "SAFArtistTabsViewController.h"
#import "SAFWorkshopTabsViewController.h"
#import "SAFAgendaViewController.h"
#import "UIViewController+Shareing.h"
#import "WorkshopObject.h"
#import "SAFCreditsViewController.h"

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
        }
            break;
        case RootFunctionMyAgenda: {
            //my agenda
            viewController = [[SAFMyAgendaViewController alloc] init];            
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

    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *title = [NSString stringWithFormat:@"Version %@, Thanks to",appVersion];
    
    UIActionSheet *credits = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"AIRE Dance Company",@"Nuvo Studio",@"Advents", nil];
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
        
        SAFCreditsViewController *credits = nil;
        switch (buttonIndex) {
            case 0:
            {
                credits = [[SAFCreditsViewController
                            alloc] init];
                credits.name = @"AIRE";
            }
                break;
            case 1:
            {
                credits = [[SAFCreditsViewController alloc] init];
                credits.name = @"Nuvo";
            }
                break;
            case 2:
            {
                credits = [[SAFCreditsViewController alloc] init];
                credits.name = @"Advents";
            }
                
            default:
                break;
        }
        
        if (credits) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:credits];
            nav.navigationBar.barTintColor = [UIColor blackColor];
            nav.navigationBar.tintColor = [UIColor whiteColor];
            [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
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
    self.useMedia = kPhotoDefaultNone | kPhotoTakePicture | kPhotoTakeMovie | kPhotoChoose;
    self.postImage = nil;
    self.postText = @"I'm attending the 9th Salsa Addicted Festival! We know how to party!";
}


@end
