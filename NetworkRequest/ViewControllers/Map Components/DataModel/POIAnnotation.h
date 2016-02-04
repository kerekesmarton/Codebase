//
//  POIAnnotation.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 31/12/15.
//  Copyright © 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface POIAnnotation : NSObject <MKAnnotation>

+ (instancetype)annotationWithLocation:(CLLocationCoordinate2D)coordinates;

@property(nonatomic,strong) NSString *primaryDetails;
@property(nonatomic,strong) NSString *secondaryDetails;
@end
