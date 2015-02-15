//
//  SKNavigationSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

@class SKTrailSettings;

/** SKNavigationSettings stores settings for a navigation session.
 */
@interface SKNavigationSettings : NSObject

/** The distance format for audio and visual advices. The default value is SKDistanceFormatMetric.
 */
@property(nonatomic, assign) SKDistanceFormat distanceFormat;

/** Used for changing the position of the car position icon on the vertical axis. It is a scale which indicates the distance between the icon and the center of the screen (in [ -0.5, 0.5 ] interval).
 The default value is -0.25.
 */
@property(nonatomic, assign) float positionerVerticalAlignment;

/** Used for changing the position of the car position icon on the horizontal axis. It is a scale which indicates the distance between the icon and the center of the screen (in [ -0.5, 0.5 ] interval).
 The default value is 0.
 */
@property(nonatomic, assign) float positionerHorizontalAlignment;

/** Sets the threshold for speed warning callbacks inside cities. If the current speed is greater than current speed limit + speedWarningThresholdInCity, the routingService:didUpdateSpeedWarningToStatus:withAudioWarnings:insideCity: callback from the SKNavigationDelegate is called.
 */
@property(nonatomic, assign) double speedWarningThresholdInCity;

/** Sets the threshold for speed warning callbacks outside cities. If the current speed is greater than current speed limit + speedWarningThresholdOutsideCity, the routingService:didUpdateSpeedWarningToStatus:withAudioWarnings:insideCity: callback from the SKNavigationDelegate is called.
 */
@property(nonatomic, assign) double speedWarningThresholdOutsideCity;

/** If enabled, the route behind current position will be hidden. Default is NO.
 */
@property(nonatomic, assign) BOOL enableSplitRoute;

/** Marks the path behind the current position with trail settings.
 */
@property(nonatomic, strong) SKTrailSettings *trail;

#pragma mark - Debug settings

/** The positioning type of the navigation.
 */
@property(nonatomic, assign) SKNavigationType navigationType;

/** Enables the displaying of real, unmatched GPS positions, for debug purposes.
 */
@property(nonatomic, assign) BOOL showRealGPSPositions;

#pragma mark - Factory method

/** A newly initialized SKNavigationSettings.
 */
+ (instancetype)navigationSettings;

@end
