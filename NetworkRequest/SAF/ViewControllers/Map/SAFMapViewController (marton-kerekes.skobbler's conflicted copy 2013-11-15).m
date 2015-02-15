//
//  SAFMapViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFMapViewController.h"
#import "SAFPOIsViewController.h"
#import "SAFNavigationBar.h"
@interface SAFMapViewController ()

@end

@implementation SAFMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *list = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(showPOIsList)];
    self.navigationItem.rightBarButtonItem = list;
}

-(void)addBackButton {
    //keep empty when using a navigation bar. Add items to navbar.
    //call super to simulate navigation buttons when hidden.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showPOIsList {
    
    SAFPOIsViewController *pois = [[SAFPOIsViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
    nav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    nav.toolbar.barStyle = UIBarStyleBlackOpaque;
    [nav setViewControllers:@[pois]];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

@end
