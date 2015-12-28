//
//  MapViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/5/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//
#import "MapAnnotation.h"


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface MapViewController : UIViewController

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property(nonatomic,strong) CLGeocoder *geocoder;

@property (nonatomic, strong) MKMapItem *currentPOI;

- (void)addAnnotationWithSearchObject:(MKMapItem *)searchObject;
- (void)zoomToSearchObject:(MKMapItem *)searchObject;
- (void)route;

///utils
- (MKCoordinateRegion)coordinateRegionWithCenter:(CLLocationCoordinate2D)centerCoordinate approximateRadiusInMeters:(CLLocationDistance)radiusInMeters;
@end
