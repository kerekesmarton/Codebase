//
//  MapViewController+MapDelegate.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController+MapDelegate.h"

#import "MapViewController+FloatingControl.h"

#import <SKMaps/SKSearch.h>

@implementation MapViewController (MapDelegate)
/**
 SKMapRegionChangedToRegion is called when the region of the map changed. This method is called whenever the currently displayed map region changes. During panning/zooming, this method may be called many times to report updates to the map position. Therefore, your implementation of this method should be as lightweight as possible to avoid affecting performance.
 @param region The new visible map region.
 */
-(void)SKMapRegionChangedToRegion:(SKCoordinateRegion)region {
    
//    positionerButton.transform = CGAffineTransformMakeRotation(-degreesToRadians(self.mapView.skMapBearing));
}

/**
 SKMapRegionChangeStartedFromRegion is called when the region of the map will begin changing. During one panning/zooming, this method is called once, at the beginning.
 @param region The current visible map region.
 */
-(void)SKMapRegionChangeStartedFromRegion:(SKCoordinateRegion)region {
    
    self.followerMode = SKMapFollowerModeNone;
}

/**
 SKMapRegionChangeEndedToRegion is called when the region of the map finished changing. During one panning/zooming, this method is called once, at the end.
 @param region The final visible map region.
 */
-(void)SKMapRegionChangeEndedToRegion:(SKCoordinateRegion)region {
    
}

/**
 SKMapTappedAtCoordinate is called when the user taps the SKMapView.
 @param coordinate The location where the tap occured.
 */
-(void)SKMapTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    [self.mapView SKAnnotationDeleteAnnotationWithId:100];
    [self hideFloatingControl];
}

/**
 SKMapLongTappedAtCoordinate is called when the user long taps the SKMapView.
 @param coordinate The location where the tap occured.
 */
-(void)SKMapLongTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    
    SKMapSearchObject *searchObject = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:coordinate.longitude withLatY:coordinate.latitude];
    
    SKAnnotation *annotation = [SKAnnotation annotation];
    annotation.uniqueAnnotationId = 100;
    annotation.annotationType = SKAnnotationTypeBlue;
    annotation.location = coordinate;
    [self.mapView addAnnotation:annotation];
    
    [self openFloatingControlWithSearchObject:searchObject];    
}

/**
 SKMapDoubleTappedAtCoordinate is called when the user double taps the SKMapView.
 @param coordinate The location where the double tap occured. On double tap, the map also zooms closer to that location.
 */
-(void)SKMapDoubleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
}

/**
 SKMapPannedFromPoint is called when the user panned the SKMapView.
 @param fromPoint The point where the panning started.
 @param toPoint The point where the panning finished.
 */
-(void)SKMapPannedFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
}

/**
 SKMapPinchedToZoomLevel is called when the user pinched the SKMapView to zoom it.
 @param scale The scale of the pinch. scale is > 1 for zoom in and < 1 for zoom out.
 */
-(void)SKMapPinchedWithScale:(float)scale {
    
}

/**
 SKMapRotatedWithAngle is called when the user rotates the SKMapView.
 @param angle The angle of the rotation, in degrees.
 */
-(void)SKMapRotatedWithAngle:(float)angle {
   
}

/**
 SKRouteCalculationFinished is called when the route is succesfully calculated. For long routes, this might be called twice, if the route is set to download a corridor, with properly set _corridorIsDownloaded_ parameter of the routeInformation.
 @param routeInformation A struct that contains the _distance_ ,  _estimatedTime_ , _corridorIsDownloaded_ and _calculatedAfterRerouting_ info regarding the calculated route.
 */
-(void)SKRouteCalculationFinished:(SKRouteInformation)routeInformation {
    
    [self.mapView SKZoomToRouteWithInsets:UIEdgeInsetsMake(44, 44, 44, 44)];
}
/**SKRouteCalculationFailed is called when the route cannot be calculated.
 */
-(void)SKRouteCalculationFailed {
    
    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Route calculation failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];    
}

/**SKRouteAllRoutesCalculated is called when all the all the route alternatives are calculated. Not all the times the required number of alternatives can be calculated, because the routes may be too similar. This callback is called when no more route alternatives will be provided.
 */
-(void)SKRouteAllRoutesCalculated {
    
    [self hideActivityIdincator];
}

/**SKNeedsOnlineConnection is called when the map is panned to an area where no tiles are downloaded and the framework is in connectivity mode offline.
 */
-(void)SKNeedsOnlineConnection {
    
}

/**
 Called when a route calculation started with calculateRouteWithRequest: is finished.
 @param response The response, in a JSON format.
 */
-(void)routeRequestFinishedWithJSONResponse:(NSString*)response {
    
}

/**It's called during the route calculation process.
 @return A boolean value which indicates the status of the internet connection.
 */

//-(BOOL)SKInternetConnectionIsAvailable {
//    
//}

/**
 SKMapPOISelected is called when a map POI is tapped
 @param mapPOI The POI that was selected.
 */
-(void)SKMapPOISelected:(SKMapPOI *)mapPOI {
    
    SKMapSearchObject *searchObject = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:mapPOI.longitude withLatY:mapPOI.latitude];

    searchObject.searchObjectName = mapPOI.name;
    
    SKAnnotation *annotation = [SKAnnotation annotation];
    annotation.uniqueAnnotationId = 100;
    annotation.annotationType = SKAnnotationTypeBlue;
    annotation.location = CLLocationCoordinate2DMake(mapPOI.latitude, mapPOI.longitude);
    [self.mapView addAnnotation:annotation];
    
    [self openFloatingControlWithSearchObject:searchObject];
}

/**An annotation was tapped in the map. Use this method to provide extra info for selected annotation.
 @param annotation The annotation that was selected.
 */
-(void)SKAnnotationWasSelected:(SKAnnotation*)annotation {
    
}

/**An annotation was tapped in the map. Use this method to provide extra info for selected annotation.
 @param uniqueAnnotationID The unique ID of the annotation view that was selected.
 @param screenCoordinate The screen coordinate where the annotation is displayed.
 */
-(void)SKAnnotationWithIDWasSelected:(int)uniqueAnnotationID withScreenCoordinate:(CGPoint)screenCoordinate {
    
}

/**An annotations cluster was tapped. Use this method to provide extra info for selected annotations cluster.
 @param customPOIList An array of NSNumber objects. The annotation ID's for the custom POI's grouped by the cluster.
 @param mapPOIList An array of SKMapPOI objects. The map POI object's grouped by the cluster.
 @param isCustomPOICluster If the cluster will be placed on a custom POI this will be set to YES. Note that the cluster will pe placed on the first annotation/mapPOI from the corresponding array.
 */
-(void)SKAnnotationClusterWithAnnotationIDsWasSelected:(NSArray *)customPOIList withMapPOIList:(NSArray *)mapPOIList isCustomPOICluster:(BOOL)isCustomPOICluster {
    
}
@end
