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

@implementation MapViewController (UICreation)

-(void)addMapView {
    self.mapView = [[SKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    
    self.mapView.delegate = self;
    self.mapView.skMapRotationEnabled = YES;
    self.mapView.skMapInertiaEnabled = YES;
}

-(void)addBackButton {
    UIButton *backButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 44, 44) image:[UIImage imageNamed:@"back"]];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

-(void)addPositionerButton {
    
    positionerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    positionerButton.backgroundColor = [UIColor clearColor];
    positionerButton.frame = CGRectMake(self.view.frameWidth-44, 0, 44, 44);
    positionerButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [positionerButton setImage:[UIImage imageNamed:@"target"] forState:UIControlStateNormal];
    [positionerButton addTarget:self action:@selector(compassAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:positionerButton];
}

-(void)addFloatingControl {
        
    floatingControlView = [[FMFloatingControlView alloc] init];
    floatingControlView.delegate = self;
    floatingControlView.dataSource = self;
    [floatingControlView showInView:self.view];
}

-(void)addActivityIndicator {
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.frame = self.view.frame;
    _activityIndicator.hidden = YES;
    [self.view addSubview:_activityIndicator];
}

@end
