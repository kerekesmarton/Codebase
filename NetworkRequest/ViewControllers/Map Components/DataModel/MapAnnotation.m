//
//  MapAnnotation.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/12/15.
//  Copyright © 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@dynamic coordinate,title,subtitle;

+(instancetype)annotationWithPlacemark:(CLPlacemark *)placemark
{
    MapAnnotation *annotation = [MapAnnotation new];
    annotation.coordinate = placemark.location.coordinate;
    annotation.placemark = placemark;
    
    return annotation;
}

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
}

-(CLLocationCoordinate2D)coordinate
{
    return _placemark.location.coordinate;
}

-(NSString *)title
{
    return _placemark.name;
}

-(NSString *)subtitle
{
    NSString *text = nil;
    text = [self addComponent:_placemark.thoroughfare toText:text];
    text = [self addComponent:_placemark.subThoroughfare toText:text];
    text = [self addComponent:_placemark.locality toText:text];
    
    return text;
}

- (NSString *)addCommaTo:(NSString *)text
{
    if ([text length] > 0)
    {
        text = [text stringByAppendingFormat:@", "];
    }
    
    return text;
}

- (NSString *)addComponent:(NSString *)component toText:(NSString *)text
{
    if (component && ![component isEqualToString:@"(null)"])
    {
        if (!text)
        {
            text = [NSString string];
        }
        text = [self addCommaTo:text];
        text = [text stringByAppendingFormat:@"%@",component];
    }
    
    return text;
}


@end
