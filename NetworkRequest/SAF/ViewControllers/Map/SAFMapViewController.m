//
//  SAFMapViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFMapViewController.h"
#import "SAFPOIsViewController.h"
#import "MapViewController+FloatingControl.h"

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
    
    UIBarButtonItem *list = [[UIBarButtonItem alloc] initWithTitle:@"Locations" style:UIBarButtonItemStylePlain target:self action:@selector(showPOIsList)];
    self.navigationItem.rightBarButtonItem = list;
//    [self setAutomaticallyAdjustsScrollViewInsets:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        SKPosition position = [[SKPositionerService sharedInstance] currentPosition];
        SKCoordinateRegion region;
        region.zoomLevel = 14;
        
        if (position.latY == 0.0000 && position.lonX == 0.0000) {
            
            //present Timisoara 45.759722, 21.23
            region.center = CLLocationCoordinate2DMake(45.758722f, 21.23f);
        } else {
            
            // present current pos
            region.center = CLLocationCoordinate2DMake(position.latY, position.lonX);
        }
        
        self.mapView.visibleRegion
        = region;
        
    } else {
        //present Timisoara
        
        SKCoordinateRegion region;
        region.zoomLevel = 14;
        region.center = CLLocationCoordinate2DMake(45.758722f, 21.23f);
        self.mapView.visibleRegion = region;
    }
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
    
    [self hideFloatingControl];
    
    [self presentViewController:[SAFPOIsViewController modalNavigationController] animated:YES completion:^{ }];
}

@end
