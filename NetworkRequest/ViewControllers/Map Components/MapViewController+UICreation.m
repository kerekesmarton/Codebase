//
//  MapViewController+UICreation.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController+UICreation.h"
#import "MapViewController+MapDelegate.h"
#import "MapViewController+FloatingControl.h"
#import "MapViewController+RoutingDelegate.h"

@implementation MapViewController (UICreation)

-(void)addMapView {
    self.mapView = [[SKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    
    self.mapView.delegate = self;
    self.mapView.settings.rotationEnabled = YES;
    self.mapView.settings.inertiaEnabled = YES;
    
    [SKRoutingService sharedInstance].routingDelegate = self;
}

-(void)addBackButton {
    UIButton *backButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 44, 44) image:[UIImage imageNamed:@"back"]];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

-(void)addFloatingControl {
        
    self.floatingControlView = [[FMFloatingControlView alloc] init];
    self.floatingControlView.delegate = self;
    self.floatingControlView.dataSource = self;
    [self.floatingControlView showInView:self.view];
}

@end
