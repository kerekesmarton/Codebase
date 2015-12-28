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
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
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

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    }
}

//- (void)mapView:(SKMapView *)mapView didStartRegionChangeFromRegion:(SKCoordinateRegion)region {
//    
//    mapView.settings.followerMode = SKMapFollowerModeNone;
//}


//- (void)mapView:(SKMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
//    [self.mapView removeAnnotationWithID:100];
//    [self hideFloatingControl];
//    
//}

//- (void)mapView:(SKMapView *)mapView didLongTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
//    
//    self.currentPOI = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:coordinate];
//    
//    [self addAnnotationWithSearchObject:self.currentPOI];
//    
//    [self openFloatingControlWithSearchObject:self.currentPOI];
//}

//- (void)mapView:(SKMapView *)mapView didSelectMapPOI:(SKMapPOI *)mapPOI {
//    
//    self.currentPOI = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:mapPOI.coordinate];
//    
//    self.currentPOI.name = mapPOI.name;
//    
//    [self addAnnotationWithSearchObject:self.currentPOI];
//    
//    [self openFloatingControlWithSearchObject:self.currentPOI];
//}

//- (void)mapView:(SKMapView *)mapView didSelectPOICluster:(SKPOICluster *)poiCluster {
//    
//    SKMapPOI *mapPOI = [poiCluster.mapPOIList objectAtIndex:0];
//    
//    self.currentPOI = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:mapPOI.coordinate];
//    
//    self.currentPOI.name = mapPOI.name;
//    
//    [self addAnnotationWithSearchObject:self.currentPOI];
//    
//    [self openFloatingControlWithSearchObject:self.currentPOI];
//}

//- (void)mapViewDidSelectCompass:(SKMapView *)mapView {
//    
//    mapView.bearing = 0.0f;
//}

//- (void)mapViewDidSelectCurrentPositionIcon:(SKMapView *)mapView {
//    
//    switch (mapView.settings.followerMode) {
//        case SKMapFollowerModeNone:
//            mapView.settings.followerMode = SKMapFollowerModePosition;
//            break;
//        case SKMapFollowerModePosition:
//            mapView.settings.followerMode = SKMapFollowerModePositionPlusHeading;
//            break;
//        case SKMapFollowerModePositionPlusHeading:
//            mapView.settings.followerMode = SKMapFollowerModeNone;
//            break;
//        default:
//            break;
//    }
//}

@end
