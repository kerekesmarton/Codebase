//
//  MapAnnotation.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/12/15.
//  Copyright © 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property(nonatomic,strong) CLPlacemark *placemark;

+ (instancetype) annotationWithPlacemark:(CLPlacemark *)placemark;

@end
