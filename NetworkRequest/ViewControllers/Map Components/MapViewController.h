//
//  MapViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/5/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapDefines.h"
#import "FMFloatingControlView.h"

@class FloatingControlDataModel;

@interface MapViewController : UIViewController {
    
    
    FLoatingControlState        _floatingControlState;
}


@property (nonatomic, strong)   SKMapView                   *mapView;

//@property (nonatomic, assign)   SKMapFollowerMode           followerMode;

@property (nonatomic, strong)   SKSearchResult              *currentPOI;

@property (nonatomic, strong)   SKRouteInformation          *routeInfo;

@property (nonatomic, strong)   FloatingControlDataModel    *floatingControlDataModel;

@property (nonatomic, strong)   FMFloatingControlView       *floatingControlView;

- (void)addAnnotationWithSearchObject:(SKSearchResult *)searchObject;
- (void)zoomToSearchObject:(SKSearchResult *)searchObject;
- (void)route;
@end
