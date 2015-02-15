//
//  SKRouteSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SKDefinitions.h"

/** The SKRouteSettings stores settings about a route. Used as input for a route calculation.
 */
@interface SKRouteSettings : NSObject

/** The start coordinate of the route.
 */
@property(nonatomic, assign) CLLocationCoordinate2D startCoordinate;

/** The destination coordinate of the route.
 */
@property(nonatomic, assign) CLLocationCoordinate2D destinationCoordinate;


/** The route calculation mode. The default is SKRouteCarEfficient.
 */
@property(nonatomic, assign) SKRouteMode routeMode;

/** The route calculation connectivity mode. The default value is SKRouteConnectionHybrid.
 */
@property(nonatomic, assign) SKRouteConnectionMode routeConnectionMode;

/** Indicates whether the route should be rendered on the map.
 */
@property(nonatomic, assign) BOOL shouldBeRendered;

/** Indicates whether to avoid toll roads when calculating the route.
 */
@property(nonatomic, assign) BOOL avoidTollRoads;

/** Indicates whether to avoid highways (Motorways & Motorway links) when calculating the route.
 */
@property(nonatomic, assign) BOOL avoidHighways;

/** Indicates whether to avoid ferry lines when calculating the route.
 */
@property(nonatomic, assign) BOOL avoidFerryLines;

/** Indicates whether to avoid roads that make the user walk along his bike when calculating the route.
 */
@property(nonatomic, assign) BOOL avoidBicycleWalk;

/** Indicates whether to avoid roads that make the user carry his bike when calculating the route.
 */
@property(nonatomic, assign) BOOL avoidBicycleCarry;

/** If set to YES, routeCountriesForRouteWithId: will return valid country codes after calculation. Default is NO.
 */
@property(nonatomic, assign) BOOL requestCountryCodes;

/** If set to YES, the route can be used for turn by turn navigation and getRouteAdviceList will return valid advices. Default is YES.
 */
@property(nonatomic, assign) BOOL requestAdvices;

#pragma mark - Route Alternatives

/** The number of routes to be calculated, including alternatives. Setting this property to a value > 1 is enough for getting basic route alternatives. Default value is 1.
 */
@property(nonatomic, assign) NSUInteger numberOfRoutes;

/** Route calculation modes for alternative routes, an array of SKRouteAlternativeSettings objects. If nil, default alternatives will be generated.
 */
@property(nonatomic, strong) NSArray *alternativeRoutesModes;

/** Indicates whether to filter/remove the alternatives that are too similar with the previous calculated ones. Two routes are considered similar if less than 10% of them are different.
 */
@property(nonatomic, assign) BOOL filterAlternatives;

#pragma mark - Advanced settings

/** Indicates whether to use the roads' slopes when calculating the route.
 */
@property(nonatomic, assign) BOOL useSlopes;

/** If set to YES, routeCoordinatesForRouteWithId: coordinates will also contain elevation data. Will be slower to calculate. Default is NO.
 */
@property(nonatomic, assign) BOOL requestExtendedRoutePointsInfo;

/** Indicates whether to download the tiles of the route corridor.
 */
@property(nonatomic, assign) BOOL downloadRouteCorridor;

/** It specifies the route corridor width, in meters. The corridor will have routeCorridorWidth on both sides of the route.
 */
@property(nonatomic, assign) int routeCorridorWidth;

/** Indicates whether to wait for the corridor download before sending the route calculation finished callback.
 */
@property(nonatomic, assign) BOOL waitForCorridorDownload;

/** Indicates whether the destination is a specific point ( POI, street with house number, etc. ) or not ( a street, a city ).
 This affects audio advices for reaching the destination.
 */
@property(nonatomic, assign) BOOL destinationIsPoint;

#pragma mark - Factory method

/** A newly initialized SKRouteSettings.
 */
+ (instancetype)routeSettings;

@end
