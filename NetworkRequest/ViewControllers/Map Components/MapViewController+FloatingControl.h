//
//  MapViewController+FloatingControl.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController.h"
#import "MapDefines.h"

@interface MapViewController (FloatingControl) <FMFloatingControlViewDelegate, FMFloatingControlViewDataSource>

@property FLoatingControlState  floatingControlState;

-(void)openFloatingControlWithSearchObject:(SKSearchResult *)searchObject;
-(void)hideFloatingControl;

@end
