//
//  MapViewController+FloatingControl.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController+FloatingControl.h"
#import "FloatingControlStateFactory.h"
#import <SKMaps/SKSearch.h>

@implementation MapViewController (FloatingControl)

@dynamic floatingControlState;

-(void)openFloatingControlWithSearchObject:(SKMapSearchObject *)searchObject {
    
    //configure map properties.
    self.currentPOI = searchObject;
    
    //configure data source for floating control
    [FloatingControlStateFactory setStaticSearchObject:self.currentPOI];
    self.floatingControlDataModel = [FloatingControlStateFactory dataSourceForState:FLoatingControlStateOptions];
    
    //configure floating control.
    self.floatingControlState = FLoatingControlStateOptions;
}

-(void)hideFloatingControl {
    self.currentPOI = nil;
    self.floatingControlState = FLoatingControlStateOff;
}

-(FLoatingControlState)floatingControlState {
    return _floatingControlState;
}

-(void)setFloatingControlState:(FLoatingControlState)state {
    
    _floatingControlState = state;
        switch (state) {
        case FLoatingControlStateOff:
            [self modifyStateOff];
            break;
        case FLoatingControlStateOptions:
            [self modifyStateTitle];
            break;
        default:
            break;
    }
}

-(void)modifyStateOff {
    [floatingControlView setState:FMFloatingControlViewStateHidden];
}
-(void)modifyStateTitle {
    [floatingControlView setState:FMFloatingControlViewStateCollapsed];
}
-(void)modifyStateOptions {
    [floatingControlView setState:FMFloatingControlViewStateExpanded];
}

#pragma mark - delegate

-(void)floatingControlView:(FMFloatingControlView*)floatingControl didTapOnControl:(FMToolbarSegmentedControl *)control Row:(int)row atIndex:(int)index {
    self.floatingControlDataModel.action(row,index);
    
}
-(BOOL)floatingControlView:(FMFloatingControlView*)floatingControl shouldExpandToState:(FMFloatingControlViewState)state {
    
    return NO;
}
-(void)floatingControlView:(FMFloatingControlView*)floatingControl didExpandToState:(FMFloatingControlViewState)state {

    //
}
-(void)floatingControlView:(FMFloatingControlView*)floatingControl titleImageTapped:(FMFloatingControlViewState)state {
    
    if (self.currentPOI) {
        SKRoute *route = [SKRoute route];
        route.startCoordinate = [[SKPositionerService sharedInstance] currentCoordinate];
        route.destinationCoordinate = CLLocationCoordinate2DMake(self.currentPOI.gpsLat, self.currentPOI.gpsLon);
        route.routeMode = SKRouteCarFastest;
        route.routeConnectionMode = SKRouteConnectionHybrid;
        route.downloadRouteCorridor = YES;
        route.routeCorridorWidthInMeters = 100;
        route.waitForCorridorDownload = YES;
        
        [self.mapView calculateRoute:route];
        
        [self showActivityIndicator];
    }    
}

#pragma mark - dataSource

-(NSString*)titleForFloatingControl:(FMFloatingControlView*)floatingControl {
    
    return self.floatingControlDataModel.title;
}

-(UIImage*)imageForTitleAccessoryViewForFloatingControl:(FMFloatingControlView*)floatingControl {
    
    return [UIImage imageNamed:self.floatingControlDataModel.imageTitle];
}

-(int)numberOfRowsInFloatingControlView:(FMFloatingControlView*)floatingControl {
    
    return self.floatingControlDataModel.views.count;
}

-(FMToolbarSegmentedControl*)floatingControlView:(FMFloatingControlView*)floatingControl viewForRow:(int)row {
    
    return [self.floatingControlDataModel.views objectAtIndex:row];
}
@end
