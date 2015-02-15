//
//  SKRoutingDelegate.h
//  SKMaps
//
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

@class SKRoutingService, SKRouteInformation;

/** The routing delegate of the SKRoutingService must adopt the SKRoutingDelegate protocol. The SKRoutingDelegate protocol is used to receive routing related update messages.
 */
@protocol SKRoutingDelegate <NSObject>

@optional

/** Called when a route is succesfully calculated including a requested route alternative.
 @param routingService The routing service.
 @param routeInformation An object that contains information regarding the calculated route.
 */
- (void)routingService:(SKRoutingService *)routingService didFinishRouteCalculationWithInfo:(SKRouteInformation *)routeInformation;

/** Called when the route cannot be calculated.
 @param routingService The routing service.
 @param errorCode The error code of the failure.
 */
- (void)routingService:(SKRoutingService *)routingService didFailWithErrorCode:(SKRoutingErrorCode)errorCode;

/** Called when all the routes including alternatives are calculated. Not all the times the required number of alternatives can be calculated, because the routes may be too similar. This callback is called when no more route alternatives will be provided.
 @param routingService The routing service.
 */
- (void)routingServiceDidCalculateAllRoutes:(SKRoutingService *)routingService;

/** Called when a route calculation started with calculateRouteWithRequest: is finished.
 @param routingService The routing service
 @param response The response, in a JSON format.
 */
- (void)routingService:(SKRoutingService *)routingService didFinishRouteRequestWithJSONResponse:(NSString *)response;

/** Called during the route calculation process. If the route cannot be calculated because of a connectivity issue, this callback can be used to control the retry mechanism. Id it's not implemented the route calculation will be retried until successful.
 @param routingService The routing service.
 @param timeInterval The time interval since the route calculation is hanging in seconds.
 @return A boolean value which indicates if the route calculation should be retried.
 */
- (BOOL)routingServiceShouldRetryCalculatingRoute:(SKRoutingService *)routingService withRouteHangingTime:(int)timeInterval;

@end
