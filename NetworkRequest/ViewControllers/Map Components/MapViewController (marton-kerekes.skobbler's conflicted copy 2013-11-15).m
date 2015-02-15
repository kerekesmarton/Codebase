//
//  MapViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/5/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewController+MapDelegate.h"
#import "MapViewController+UICreation.h"
#import "MapViewController+FloatingControl.h"
#import "MapDefines.h"
#import <SKMaps/SKMaps.h>
#import <SKMaps/SKDefinitions.h>
#import <SKMaps/SKMapSearchObject.h>

@implementation MapViewController {
    
    FLoatingControlState _fcState;
}

@synthesize mapView;
@synthesize followerMode;

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
    // Do any additional setup after loading the view from its nib.
    [self addMapView];
    [self addBackButton];
    [self addPositionerButton];
    [self addFloatingControl];
    [self addActivityIndicator];
    
    [self setFollowerMode:SKMapFollowerModeNone];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [mapView viewWillAppear];
    
    [NSNotificationCenterInstance addObserver:self selector:@selector(gotoPOI:) name:GoToPoiNotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [mapView viewWillDissapear];
    
    [NSNotificationCenterInstance removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"slideOutWithNotification" object:nil]];
}

-(void)compassAction:(UIButton *)sender {
    
    switch (self.followerMode) {
        case SKMapFollowerModeNone:
            self.followerMode = SKMapFollowerModePosition;
            break;
        case SKMapFollowerModePosition:
            self.followerMode = SKMapFollowerModePositionPlusHeading;
            break;
        case SKMapFollowerModePositionPlusHeading:
            self.followerMode = SKMapFollowerModeNone;
            break;
        case SKMapFollowerModeNavigation:
        default:
            break;
    }
}

-(SKMapFollowerMode)followerMode {
    
    return self.mapView.sKMapFollowerMode;
}

-(void)setFollowerMode:(SKMapFollowerMode)mode {
    static NSArray *icons = nil;
    if (!icons) {
        icons = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"target"],
                 [UIImage imageNamed:@"map_pin"],
                 [UIImage imageNamed:@""], nil];
    }
    
    self.mapView.sKMapFollowerMode = mode;
    
    switch (mode) {
        case SKMapFollowerModeNone:
            mapView.skMapBearing = 0;
            [self.mapView setSkMapShowCompass:NO];
            [positionerButton setImage:[icons objectAtIndex:mode] forState:UIControlStateNormal];
            break;
        case SKMapFollowerModePosition:
            [self.mapView animateZoomLevelToZoom:16];
            [positionerButton setImage:[icons objectAtIndex:mode] forState:UIControlStateNormal];
            break;
        case SKMapFollowerModePositionPlusHeading:
            [self.mapView setSkMapShowCompass:YES];
            [positionerButton setImage:nil forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    self.mapView.sKMapFollowerMode = mode;
}

-(void)gotoPOI:(NSNotification *)notification {
    
    
    SKMapSearchObject *searchObject = notification.object;
    
    SKAnnotation *annotation = [SKAnnotation annotation];
    annotation.uniqueAnnotationId = 100;
    annotation.annotationType = SKAnnotationTypeBlue;
    annotation.location = CLLocationCoordinate2DMake(searchObject.gpsLat, searchObject.gpsLon);
    [self.mapView addAnnotation:annotation];
    
    SKCoordinateRegion region;
    region.center = annotation.location;
    region.zoomLevel = 14;
    self.mapView.mapVisibleRegion = region;
    
    [self openFloatingControlWithSearchObject:searchObject];
}

-(void)showActivityIndicator {
    _activityIndicator.hidden = NO;
    [_activityIndicator startAnimating];
}

-(void)hideActivityIdincator {    
    _activityIndicator.hidden = YES;
    [_activityIndicator stopAnimating];
}

@end
