//
//  MapViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/5/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewController+MapDelegate.h"

@interface MapViewController () <UIActionSheetDelegate>

@end

@implementation MapViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startMonitoringSignificantLocationChanges];

        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        self.geocoder = [[CLGeocoder alloc] init];
        
        // Observe the application going in and out of the background, so we can toggle location tracking.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleUIApplicationDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleUIApplicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.locationManager stopMonitoringSignificantLocationChanges];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mapView.delegate = self;
    
    MKUserTrackingBarButtonItem *userTrackingButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = userTrackingButton;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.mapView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapGesture:)];
    [self.mapView addGestureRecognizer:longTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"slideOutWithNotification" object:nil]];
}


-(void)gotoPOI:(NSNotification *)notification {
    
    self.currentPOI = notification.object;
    
//    [self openFloatingControlWithSearchObject:self.currentPOI];
    
    [self addAnnotationWithSearchObject:self.currentPOI];
    
    [self zoomToSearchObject:self.currentPOI];
}

//- (void)addAnnotationWithSearchObject:(SKSearchResult *)searchObject {
//    
//    SKAnnotation *annotation = [SKAnnotation annotation];
//    annotation.identifier = 100;
//    annotation.annotationType = SKAnnotationTypeBlue;
//    annotation.location = CLLocationCoordinate2DMake(searchObject.coordinate.latitude, searchObject.coordinate.longitude);
//    
//    [self.mapView addAnnotation:annotation withAnimationSettings:[SKAnimationSettings defaultAnimationSettings]];
//}
//
//- (void)zoomToSearchObject:(SKSearchResult *)searchObject {
//    
//    SKCoordinateRegion region;
//    region.zoomLevel = self.mapView.visibleRegion.zoomLevel;
//    region.center = CLLocationCoordinate2DMake(searchObject.coordinate.latitude, searchObject.coordinate.longitude);
//    [self.mapView setVisibleRegion:region];
//}

-(void)route {
    
}

#pragma mark - UIActionSheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
 
 
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    
//    SKRouteSettings *route = [SKRouteSettings routeSettings];
//    route.startCoordinate = [[SKPositionerService sharedInstance] currentCoordinate];
//    route.destinationCoordinate = self.currentPOI.coordinate;
//    route.shouldBeRendered = YES;
//    route.numberOfRoutes = 1;
//    
//    switch (buttonIndex) {
//        case 0:
//            route.routeMode = SKRouteCarFastest;
//            break;
//        case 1:
//            route.routeMode = SKRouteCarEfficient;
//            break;
//        case 2:
//            route.routeMode = SKRoutePedestrian;
//            break;
//        default:
//            break;
//    }
//    
//    [SKRoutingService sharedInstance].mapView = self.mapView;
//    [[SKRoutingService sharedInstance] calculateRoute:route];
}

#pragma mark - gesture recognizers

- (void)tapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    
}

- (void)longTapGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint tapPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coord = [self.mapView convertPoint:tapPoint toCoordinateFromView:self.mapView];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MapAnnotation *annotation = [MapAnnotation annotationWithPlacemark:placemark];
        
        [_mapView.annotations firstObject]
        if ()
        {
            [self.mapView removeAnnotations:_mapView.annotations];
            [self.mapView addAnnotation:annotation];
        }
        
        
    }];
}

- (void)removeAnnotation:(id <MKAnnotation>)annotation
{
    
}

#pragma mark - Utils

- (void)handleUIApplicationDidEnterBackgroundNotification:(NSNotification *)note
{
    [self switchToBackgroundMode:YES];
}

- (void)handleUIApplicationWillEnterForegroundNotification :(NSNotification *)note
{
    [self switchToBackgroundMode:NO];
}

// called when the app is moved to the background (user presses the home button) or to the foreground
//
- (void)switchToBackgroundMode:(BOOL)background
{
    if (background)
    {
        [self.locationManager stopUpdatingLocation];
    }
    else
    {
        [self.locationManager startUpdatingLocation];
    }
}

- (MKCoordinateRegion)coordinateRegionWithCenter:(CLLocationCoordinate2D)centerCoordinate approximateRadiusInMeters:(CLLocationDistance)radiusInMeters
{
    // Multiplying by MKMapPointsPerMeterAtLatitude at the center is only approximate, since latitude isn't fixed
    //
    double radiusInMapPoints = radiusInMeters*MKMapPointsPerMeterAtLatitude(centerCoordinate.latitude);
    MKMapSize radiusSquared = {radiusInMapPoints,radiusInMapPoints};
    
    MKMapPoint regionOrigin = MKMapPointForCoordinate(centerCoordinate);
    MKMapRect regionRect = (MKMapRect){regionOrigin, radiusSquared}; //origin is the top-left corner
    
    regionRect = MKMapRectOffset(regionRect, -radiusInMapPoints/2, -radiusInMapPoints/2);
    
    // clamp the rect to be within the world
    regionRect = MKMapRectIntersection(regionRect, MKMapRectWorld);
    
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(regionRect);
    return region;
}

@end
