//
//  SKRouteAlternativeSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "SKDefinitions.h"

/** The SKRouteAlternativeSettings is used to store information about a route alternative.
 */
@interface SKRouteAlternativeSettings : NSObject

/** The mode for the alternative route calculation. The default is SKRouteCarShortest.
 */
@property(nonatomic, assign) SKRouteMode routeMode;

/** The number of alternative routes that are calculated in this mode. Default is 1.
 */
@property(nonatomic, assign) int numberOfRoutes;

/** Indicates whether to use the roads' slopes when calculating the route.
 */
@property(nonatomic, assign) BOOL useSlopes;

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

@end
