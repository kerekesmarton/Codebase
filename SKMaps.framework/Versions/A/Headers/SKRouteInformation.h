//
//  SKRouteInformation.h
//  SKMaps
//
//  Created by Alex Cimpean on 1/28/14.
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

/** SKRouteInformation stores information returned on a route calculation.
 */
@interface SKRouteInformation : NSObject

/** The unique identifier of the calculated route.
 */
@property(nonatomic, assign) SKRouteID routeID;

/** The distance of the calculated route, in meters.
 */
@property(nonatomic, assign) int distance;

/** The estimated duration of the calculated route, in seconds.
 */
@property(nonatomic, assign) int estimatedTime;

/** Flag that indicates if the route corridor was downloaded.
 */
@property(nonatomic, assign) BOOL corridorIsDownloaded;

/** Flag that indicates if the route was calculated due to a rerouting.
 */
@property(nonatomic, assign) BOOL calculatedAfterRerouting;

/** Flag that indicates if the rute contains highways.
 */
@property(nonatomic, assign) BOOL containsHighways;

/** Flag that indicates if the rute contains toll roads.
 */
@property(nonatomic, assign) BOOL containsTollRoads;

/** Flag that indicates if the rute contains ferry lines.
 */
@property(nonatomic, assign) BOOL containsFerryLines;

@end
