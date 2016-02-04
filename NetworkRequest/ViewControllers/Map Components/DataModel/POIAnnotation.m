//
//  POIAnnotation.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 31/12/15.
//  Copyright © 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "POIAnnotation.h"

@interface POIAnnotation()

@property(nonatomic, assign) CLLocationCoordinate2D coords;

@end

@implementation POIAnnotation

+(instancetype)annotationWithLocation:(CLLocationCoordinate2D)coordinates
{
    POIAnnotation *annotation = [POIAnnotation new];
//    CLPlacemark *placemark = [[CLPlacemark alloc] init];
//    placemark.location = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    annotation.coords = coordinates;
    
    return annotation;
}

-(NSString *)title
{
    return _primaryDetails;
}

-(NSString *)subtitle
{
    return _secondaryDetails;
}

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    
}

-(CLLocationCoordinate2D)coordinate
{
    return _coords;
}

@end
