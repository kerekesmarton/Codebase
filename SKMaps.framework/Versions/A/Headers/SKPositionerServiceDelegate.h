//
//  SKPositionerServiceDelegate.h
//  SKMaps
//
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKPositionerService;

/** SKPositionerServiceDelegate is used for receiving different GPS location updates.
 */
@protocol SKPositionerServiceDelegate <NSObject>

@optional

/** Called when the GPS location is changed.
 @param positionerService The positioner service.
 @param currentLocation The new GPS location.
 */
- (void)positionerService:(SKPositionerService *)positionerService updatedCurrentLocation:(CLLocation *)currentLocation;

/** Called when the GPS heading is changed.
 @param positionerService The positioner service.
 @param currentHeading The new GPS heading.
 */
- (void)positionerService:(SKPositionerService *)positionerService updatedCurrentHeading:(CLHeading *)currentHeading;

/** Called when the GPS accuracy is changed.
 @param positionerService The positioner service.
 @param level The type of the GPS accuracy.
 */
- (void)positionerService:(SKPositionerService *)positionerService changedGPSAccuracyToLevel:(SKGPSAccuracyLevel)level;

/** Called when an error has occurred.
 @param positionerService The positioner service.
 @param error The error that occured.
 */
- (void)positionerService:(SKPositionerService *)positionerService didFailWithError:(NSError *)error;

/** Called when the authorization status changes for the client application.
 @param positionerService The positioner service.
 @param status The new authorization status.
 */
- (void)positionerService:(SKPositionerService *)positionerService didChangeAuthorizationStatus:(CLAuthorizationStatus)status;


@end
