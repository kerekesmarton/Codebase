//
//  MapViewController+MapDelegate.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController+MapDelegate.h"

@implementation MapViewController (MapDelegate)

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    UIButton *routeBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.leftCalloutAccessoryView = routeBtn;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    for (MKAnnotationView *annotationView in views)
    {
        CGRect endFrame = annotationView.frame;
        annotationView.frame = CGRectOffset(endFrame, 0, -500);
        [UIView animateWithDuration:0.1 animations:^{ annotationView.frame = endFrame; }];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MKCoordinateRegion region = [self coordinateRegionWithCenter:userLocation.coordinate approximateRadiusInMeters:500];
        [self.mapView setRegion:region];
    });
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(nonnull NSError *)errors
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MKCoordinateRegion region = [self coordinateRegionWithCenter:[self defaultLocation] approximateRadiusInMeters:500];
        [self.mapView setRegion:region];
    });
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self convert:view.annotation completionHandler:^(CLPlacemark *placemark, NSError *error) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"There was a problem loading the address" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else
        {
            [self route:[[MKPlacemark alloc] initWithPlacemark:placemark]];
        }
    }];
    
}

@end
