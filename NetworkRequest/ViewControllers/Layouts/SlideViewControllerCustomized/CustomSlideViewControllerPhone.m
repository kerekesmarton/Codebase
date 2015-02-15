//
//  CustomSlideViewControllerPhone.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/8/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "CustomSlideViewControllerPhone.h"
#import "CustomSlideMenuDataSourceFactory.h"
#import "MenuViewController.h"

@interface CustomSlideViewControllerPhone ()

@property (nonatomic, strong) CustomSlideMenuDataSourceFactory *dataModel;

@end

@implementation CustomSlideViewControllerPhone

@synthesize dataModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.dataModel = [CustomSlideMenuDataSourceFactory mainMenuData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addFunctionsTableController];
    
    [self prepareNavigation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openWithNotification:) name:@"slideOutWithNotification"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private UI creation

-(void)addFunctionsTableController {
    MenuViewController *controller = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    controller.delegate = self;
    _fixedNavigationController = [[UINavigationController alloc] initWithNavigationBarClass:[CustomNavigationBar class] toolbarClass:[UIToolbar class]];
    _fixedNavigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen-texture"]];
    _fixedNavigationController.viewControllers = @[controller];
    [self addChildViewController:_fixedNavigationController];
    [self.view addSubview:_fixedNavigationController.view];
    [self.view sendSubviewToBack:_fixedNavigationController.view];
}

-(void)prepareNavigation {
    _slideNavigationController.view.frame = self.view.frame;
    _slideNavigationController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _fixedNavigationController.view.frame = self.view.frame;
    _fixedNavigationController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)configureViewController:(UIViewController *)viewController {
    
    UIButton *backBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 25, 25) image:[UIImage imageNamed:@"back"]];
    [backBtn addTarget:self action:@selector(menuBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

-(void)selectItem:(CustomSlideMenuDataModel *)item {
    UIViewController *functionsViewController;
    if (item.requiresNib) {
        functionsViewController = [[item.functionsViewControllerClass alloc] initWithNibName:item.nibName bundle:nil];
    } else {
        functionsViewController = [[item.functionsViewControllerClass alloc] init];
    }
    
    [_slideNavigationController setNavigationBarHidden:item.requiresTransparentNavigationBar animated:YES];
    
    [self configureViewController:functionsViewController];
    [_slideNavigationController setViewControllers:@[functionsViewController]];
    [_slideNavigationController.navigationBar setNeedsDisplay];
    [self slideInSlideNavigationControllerView];
}

- (void)openWithNotification:(NSNotification *)notification {
    [self menuBarButtonItemClicked];
}
@end
