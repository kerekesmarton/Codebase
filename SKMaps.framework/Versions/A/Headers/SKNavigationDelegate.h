//
//  SKNavigationControllerDelegate.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <UIKit/UIImage.h>
#import "SKDefinitions.h"
@class SKRouteState, SKTrafficUpdateData, SKRoutingService;

/** The navigation delegate of the SKRoutingService must adopt the SKNavigationDelegate protocol. The SKNavigationDelegate protocol is used to receive navigation related update messages.
 */
@protocol SKNavigationDelegate <NSObject>

@optional

/** Called when the distance to the destination changed.
 @param routingService The routing service.
 @param distance The distance to the destination, in meters.
 @param formattedDistance The formatted and rounded distance.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeDistanceToDestination:(int)distance withFormattedDistance:(NSString *)formattedDistance;

/** Called when the estimated arrival time to the destination changed.
 @param routingService The routing service.
 @param time The estimated time to the destination, in seconds.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeEstimatedTimeToDestination:(int)time;

/** Called when the unique ID of the current advice is changed. Consistent with the adviceID from the SKRouteAdvice.
 @param routingService The routing service.
 @param adviceID The unique ID.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeAdviceID:(int)adviceID;

/** Called when the current street name changed.
 @param routingService The routing service.
 @param currentStreetName The current street name.
 @param streetType The current street's type.
 @param countryCode The current country code.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCurrentStreetName:(NSString *)currentStreetName streetType:(SKStreetType)streetType countryCode:(NSString *)countryCode;

/** Called when the next street name changed.
 @param routingService The routing service.
 @param nextStreetName The next street name.
 @param streetType The next street's type.
 @param countryCode The current country code.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeNextStreetName:(NSString *)nextStreetName streetType:(SKStreetType)streetType countryCode:(NSString *)countryCode;

/** Called when the street after the next street is changed.
 @param routingService - The routing service
 @param nextStreetName The next street name.
 @param streetType The next street's type.
 @param countryCode The current country code.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeSecondNextStreet:(NSString *)nextStreetName streetType:(SKStreetType)streetType countryCode:(NSString *)countryCode;

/** Called when the current visual advice image changed.
 @param routingService The routing service.
 @param adviceImage Current visual advice image.
 @param isLastAdvice Specifies if this is the last visual advice before reaching the destination.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCurrentAdviceImage:(UIImage *)adviceImage withLastAdvice:(BOOL)isLastAdvice;

/** Called when the distance to the current visual advice changed.
 @param routingService The routing service.
 @param distance The distance to the current visual advice, in meters.
 @param formattedDistance The formatted and rounded distance.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCurrentVisualAdviceDistance:(int)distance withFormattedDistance:(NSString *)formattedDistance;

/** Called when the secondary visual advice image changed.
 @param routingService The routing service.
 @param adviceImage Secondary visual advice image.
 @param isLastAdvice Specifies if this is the last visual advice before reaching the destination.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeSecondaryAdviceImage:(UIImage *)adviceImage withLastAdvice:(BOOL)isLastAdvice;

/** Called when the distance to the secondary visual advice changed.
 @param routingService The routing service.
 @param distance The distance to the secondary visual advice, in meters.
 @param formattedDistance The formatted and rounded distance.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeSecondaryVisualAdviceDistance:(int)distance withFormattedDistance:(NSString *)formattedDistance;

/** Called when a new filtered audio advice should be played. This is called when a filtered advice is generated. It's not called as often as the routingService:didUpdateUnfilteredAudioAdvices:withDistance:.
 Distance and other logical filters are applied, so that only useful advices are played. If custom filters are required, implement the routingService:didUpdateUnfilteredAudioAdvices: method and apply your own filter.
 @param routingService The routing service.
 @param audioAdvices An array of mp3 files names. The actual mp3 files are located in the SKAdvisorResources.bundle.
 */
- (void)routingService:(SKRoutingService *)routingService didUpdateFilteredAudioAdvices:(NSArray *)audioAdvices;

/** Called when a new audio advice is generated. This should be used if custom distance filters have to be applied to generated advices. Otherwise, use the routingService:didUpdateFilteredAudioAdvices:withDistance: callback.
 @param routingService The routing service.
 @param audioAdvices An array of mp3 files names. The actual mp3 files are located in the SKAdvisorResources.bundle.
 @param distance The distance to the location of the advice. This can be used for filtering.
 */
- (void)routingService:(SKRoutingService *)routingService didUpdateUnfilteredAudioAdvices:(NSArray *)audioAdvices withDistance:(int)distance;

/** Called when the current speed changed.
 @param routingService The routing service.
 @param speed The current speed, in m/s.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCurrentSpeed:(double)speed;

/** Called when the current speed limit changed.
 @param routingService The routing service.
 @param speedLimit The current speed limit, in m/s.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCurrentSpeedLimit:(double)speedLimit;

/** Called when a rerouting starts. This happens when the device doesn't follow the calculated route. When this is done, a new route is automatically calculated and will send success/failure callbacks via the SKRoutingDelegate. The calculatedAfterRerouting field of the SKRouteInformation will be set to YES.
 @param routingService The routing service.
 */
- (void)routingServiceDidStartRerouting:(SKRoutingService *)routingService;

/** Called when the speed warning status is updated. Thresholds for speed warnings can be set using the speedWarningThresholdInCity, speedWarningThresholdOutsideCity properties from the SKNavigationSettings object.
 @param routingService The routing service.
 @param speedWarningIsActive If YES, the speed warning is active. If NO, the speed warning is over.
 @param audioWarnings If the speedWarningIsActive is YES, _audioFiles_ contains an audio playlist for an audio warning.
 @param isInsideCity Indicates that the device is inside/outside a city.
 */
- (void)routingService:(SKRoutingService *)routingService didUpdateSpeedWarningToStatus:(BOOL)speedWarningIsActive withAudioWarnings:(NSArray *)audioWarnings insideCity:(BOOL)isInsideCity;

/** Called when a via point of the route used in navigation is reached. The reached via point is identified by the viaPointIndex parameter of this callback.
 @param routingService The routing service.
 @param index The index of reached via point.
 */
- (void)routingService:(SKRoutingService *)routingService didReachViaPointWithIndex:(int)index;

/** Called when the destination is reached.
 @param routingService The routing service.
 */
- (void)routingServiceDidReachDestination:(SKRoutingService *)routingService;

/**
 skFirstVisualAdviceChanged:secondaryVisualAdviceChanged:isLastAdvice:withRouteState: is called when the first or secondary visual advice is changed, or the last advice exists before reaching the destination.
 @param routingService - The routing service
 @param isFirstVisualAdviceChanged It indicates the changing of the first visual advice.
 @param isSecondaryAdviceChanged It indicates the changing of the secondary visual advice.
 @param isLastAdvice Specifies if this is the last visual advice before reaching the destination.
 @param routeState Contains information about how to generate a visual advice image.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeFirstVisualAdvice:(BOOL)isFirstVisualAdviceChanged withSecondVisualAdvice:(BOOL)isSecondaryAdviceChanged lastAdvice:(BOOL)isLastAdvice routeState:(SKRouteState *)routeState;

/** Called when the country code changed.
 @param routingService The routing service.
 @param countryCode The current country code.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCountryCode:(NSString *)countryCode;

/** Called when the exit number changed.
 @param routingService The routing service.
 @param exitNumber The number of the exit from a highway.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeExitNumber:(NSString *)exitNumber;

/** Called when the current or next advice instruction is changed.
 @param routingService The routing service.
 @param currentAdviceInstruction The instruction of the current advice.
 @param nextAdviceInstruction The instruction of the next advice.
 */
- (void)routingService:(SKRoutingService *)routingService didChangeCurrentAdviceInstruction:(NSString *)currentAdviceInstruction nextAdviceInstruction:(NSString *)nextAdviceInstruction;

@end
