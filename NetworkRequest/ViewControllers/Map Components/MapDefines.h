//
//  MapDefines.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SKMaps/SKMaps.h>

typedef enum FloatingControlState {
    
    FLoatingControlStateOff,
    FLoatingControlStateOptions,
    
}FLoatingControlState;


#define GoToPoiNotification     @"GoToPoiNotification"

@interface MapDefines : NSObject

@end
