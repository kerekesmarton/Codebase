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
    
    UIButton                    *positionerButton;
    FMFloatingControlView       *floatingControlView;
    FLoatingControlState        _floatingControlState;
    UIActivityIndicatorView     *_activityIndicator;
}


@property (nonatomic, strong)   SKMapView *mapView;

@property (nonatomic, assign)   SKMapFollowerMode followerMode;

@property (nonatomic, strong)   SKMapSearchObject     *currentPOI;

@property (nonatomic, strong)   FloatingControlDataModel    *floatingControlDataModel;


-(void)showActivityIndicator;
-(void)hideActivityIdincator;

@end
