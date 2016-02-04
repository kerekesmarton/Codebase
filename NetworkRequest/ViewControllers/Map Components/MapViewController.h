//
//  MapViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/5/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//
#import "MapAnnotation.h"
#import "POIAnnotation.h"

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef void (^ConversionCompletionHandler)(CLPlacemark *, NSError *);


@interface MapViewController : UIViewController

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property(nonatomic,strong) CLGeocoder *geocoder;

@property(nonatomic,strong) MKPlacemark *currentPlacemark;

- (void)gotoPOI:(id <MKAnnotation>)annotation;
- (void)addAnnotation:(id <MKAnnotation>)annotation;
- (void)convert:(id)annotation completionHandler:(ConversionCompletionHandler)completionHandler;
- (void)search:(CLLocationCoordinate2D)coord completionHandler:(CLGeocodeCompletionHandler)completionHandler;
- (void)route:(MKPlacemark *)placemark;

- (CLLocationCoordinate2D)defaultLocation;

///utils
- (MKCoordinateRegion)coordinateRegionWithCenter:(CLLocationCoordinate2D)centerCoordinate approximateRadiusInMeters:(CLLocationDistance)radiusInMeters;
@end
