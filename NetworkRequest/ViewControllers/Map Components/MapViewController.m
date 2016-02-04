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


-(CLLocationCoordinate2D)defaultLocation
{
    return CLLocationCoordinate2DMake(45.758722f, 21.23f);
}

-(void)gotoPOI:(id <MKAnnotation>)annotation {
            
    [self addAnnotation:annotation];
    
    MKCoordinateRegion region = [self coordinateRegionWithCenter:annotation.coordinate approximateRadiusInMeters:500];
    [self.mapView setRegion:region];
}

- (void)addAnnotation:(id <MKAnnotation>)annotation
{
    [self.mapView removeAnnotations:_mapView.annotations];
    [self.mapView addAnnotation:annotation];
}

- (void)convert:(id)annotation completionHandler:(ConversionCompletionHandler)completionHandler
{
    __block CLPlacemark *placemark = nil;
    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        placemark = [(MapAnnotation *)annotation placemark];
        completionHandler(placemark,nil);
    }
    else if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        CLLocationCoordinate2D coord = [(POIAnnotation *)annotation coordinate];
        [self search:coord completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error)
            {
                completionHandler(nil,error);
            } else
            {
                placemark = [placemarks firstObject];
                completionHandler(placemark,nil);
            }
        }];
    }
}

- (void)search:(CLLocationCoordinate2D)coord completionHandler:(CLGeocodeCompletionHandler)completionHandler
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        completionHandler(placemarks,error);
    }];
}

- (void)route:(MKPlacemark *)placemark
{
    self.currentPlacemark = placemark;
    
    UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:placemark.name delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Maps", nil];
    [actions showInView:self.view];
}

#pragma mark - Gesture Recognizers

- (void)longTapGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    CGPoint tapPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coord = [self.mapView convertPoint:tapPoint toCoordinateFromView:self.mapView];
    [self search:coord completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"There was a problem loading the address" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else
        {
            CLPlacemark *placemark = [placemarks firstObject];
            MapAnnotation *annotation = [MapAnnotation annotationWithPlacemark:placemark];
            [self addAnnotation:annotation];
        }
    }];
}

#pragma mark - UIActionSheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex && buttonIndex != actionSheet.destructiveButtonIndex)
    {
        MKMapItem *mapItemDest = [[MKMapItem alloc] initWithPlacemark:self.currentPlacemark];
        [mapItemDest openInMapsWithLaunchOptions:nil];
    }
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
