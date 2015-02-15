//
//  MapViewController+RoutingDelegate.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController+RoutingDelegate.h"

@implementation MapViewController (RoutingDelegate)

-(void)routingService:(SKRoutingService *)routingService didFailWithErrorCode:(SKRoutingErrorCode)errorCode {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Route calculation failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    self.routeInfo = nil;

}

- (void)routingService:(SKRoutingService *)routingService didFinishRouteCalculationWithInfo:(SKRouteInformation *)routeInformation {
    
    self.routeInfo = routeInformation;    
}

-(void)routingServiceDidCalculateAllRoutes:(SKRoutingService *)routingService {
    
    if (self.routeInfo) {
        [[SKRoutingService sharedInstance] zoomToRouteWithInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    }
}

@end
