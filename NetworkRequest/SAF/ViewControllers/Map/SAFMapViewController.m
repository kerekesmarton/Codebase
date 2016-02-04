//
//  SAFMapViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFMapViewController.h"
#import "SAFPOIsViewController.h"

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
    MKUserTrackingBarButtonItem *userTrackingButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    UIBarButtonItem *list = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showPOIsList)];
    self.navigationItem.rightBarButtonItems = @[userTrackingButton,list];
//    [self setAutomaticallyAdjustsScrollViewInsets:YES];
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
    
    [self presentViewController:[SAFPOIsViewController modalNavigationControllerWithCompletion:^(POIAnnotation *annotation) {
        
        [self gotoPOI:annotation];        
    }] animated:YES completion:^{ }];
}


-(CLLocationCoordinate2D)defaultLocation
{
    return CLLocationCoordinate2DMake(45.758722f, 21.23f);
}

@end
