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

#import <SKMaps/SKSearchResult.h>
#import <SKMaps/SKPositionerService.h>

@interface MapViewController () <UIActionSheetDelegate>

@end

@implementation MapViewController {
    FLoatingControlState _fcState;
    
    UIActionSheet *routeActionSheet;
}

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
    [self addFloatingControl];
    
    [NSNotificationCenterInstance addObserver:self selector:@selector(gotoPOI:) name:GoToPoiNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back {
    [[SKRoutingService sharedInstance] clearCurrentRoutes];
    [NSNotificationCenterInstance removeObserver:self];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"slideOutWithNotification" object:nil]];
}


-(void)gotoPOI:(NSNotification *)notification {
    
    self.currentPOI = notification.object;
    
    [self openFloatingControlWithSearchObject:self.currentPOI];
    
    [self addAnnotationWithSearchObject:self.currentPOI];
    
    [self zoomToSearchObject:self.currentPOI];
}

- (void)addAnnotationWithSearchObject:(SKSearchResult *)searchObject {
    
    SKAnnotation *annotation = [SKAnnotation annotation];
    annotation.identifier = 100;
    annotation.annotationType = SKAnnotationTypeBlue;
    annotation.location = CLLocationCoordinate2DMake(searchObject.coordinate.latitude, searchObject.coordinate.longitude);
    
    [self.mapView addAnnotation:annotation withAnimationSettings:[SKAnimationSettings defaultAnimationSettings]];
}

- (void)zoomToSearchObject:(SKSearchResult *)searchObject {
    
    SKCoordinateRegion region;
    region.zoomLevel = self.mapView.visibleRegion.zoomLevel;
    region.center = CLLocationCoordinate2DMake(searchObject.coordinate.latitude, searchObject.coordinate.longitude);
    [self.mapView setVisibleRegion:region];
}

-(void)route {
    
    routeActionSheet = [[UIActionSheet alloc] initWithTitle:@"Routing Type" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Car fastest",@"Car efficient",@"Pedestrian", nil];
    [routeActionSheet showInView:self.view];
}

#pragma mark - UIActionSheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
 
 
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    
    SKRouteSettings *route = [SKRouteSettings routeSettings];
    route.startCoordinate = [[SKPositionerService sharedInstance] currentCoordinate];
    route.destinationCoordinate = self.currentPOI.coordinate;
    route.shouldBeRendered = YES;
    route.numberOfRoutes = 1;
    
    switch (buttonIndex) {
        case 0:
            route.routeMode = SKRouteCarFastest;
            break;
        case 1:
            route.routeMode = SKRouteCarEfficient;
            break;
        case 2:
            route.routeMode = SKRoutePedestrian;
            break;
        default:
            break;
    }
    
    [SKRoutingService sharedInstance].mapView = self.mapView;
    [[SKRoutingService sharedInstance] calculateRoute:route];
}

@end
