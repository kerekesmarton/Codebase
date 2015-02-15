//
//  SKMapSetting.h
//  SKMaps
//
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "SKDefinitions.h"

@class SKMapInternationalizationSettings;

/** SKMapSettings stores and controls various UI and behavior settings for the SKMapView class. This class should not be instantiated by the client application.
 */
@interface SKMapSettings : NSObject

#pragma mark - Gestures

/** Controls if rotation gestures are enabled or disabled. Default value is YES.
 */
@property(nonatomic, assign) BOOL rotationEnabled;

/** Controls if panning gestures are enabled or disabled. Default value is YES.
 */
@property(nonatomic, assign) BOOL panningEnabled;

/** If set to YES, when pinched the map will always zoom to the center point of the map instead of the pinched points. Default is NO.
 */
@property(nonatomic, assign) BOOL zoomWithCenterAnchor;

/** Controls map inertia for panning/zooming/rotating gestures. Default value is YES.
 */
@property(nonatomic, assign) BOOL inertiaEnabled;

#pragma mark - Settings

/** Controls if the map follows the user position, orientation or none of them. Default value is SKMapFollowerModeNone.
 */
@property(nonatomic, assign) SKMapFollowerMode followerMode;

/** Controls if the compass indicating the map bearing is displayed. Default value is NO.
 */
@property(nonatomic, assign) BOOL showCompass;

/** Controls if the accuracy circle is displayed. Default value is YES.
 */
@property(nonatomic, assign) BOOL showAccuracyCircle;

/** The relative position of the compass compared to its initial position (top right corner). For moving the compass to the left, set positive value to x, to move down set positive value to y. Default value is (0,0).
 */
@property(nonatomic, assign) CGPoint compassOffset;

/** The orientation indicator type, used when SKMapFollowerModePositionPlusHeading follower is active. If SKOrientationIndicatorCustomImage is set, the "heading.png" image file from the style's resources will be used.
 */
@property(nonatomic, assign) SKOrientationIndicatorType orientationIndicatorType;

/** Controls the map display mode ( 2D / 3D ).
 */
@property(nonatomic, assign) SKMapDisplayMode displayMode;

/** A mask of SKPOIDisplayingOption elements used to configure map POIs displaying. By default all of the POIs are displayed.
 */
@property(nonatomic, assign) SKPOIDisplayingOption poiDisplayingOption;

/** Controls the maps labeling language and transliteration. For further details see SKMapInternationalizationSettings.
 */
@property(nonatomic, strong) SKMapInternationalizationSettings *mapInternationalization;

/** Used for setting the zoom limits of the map. For the minimum and maximum values, check the SKDefinitions constants.
 */
@property(nonatomic, assign) SKMapZoomLimits zoomLimits;

/** Defines the starting zoom level where the annotation selection works. By default it's 12.0.
 */
@property(nonatomic,assign) float annotationTapZoomLimit;

#pragma mark - Display

/** Controls if the current position icon is displayed on the map.
 */
@property(nonatomic, assign) BOOL showCurrentPosition;

/** Controls if the street names should be displayed as pop-ups in 3D mode. Default value is NO.
 */
@property(nonatomic, assign) BOOL showStreetNamePopUps;

/** Controls if bicycle lanes are rendered on the map. Default value is NO.
 */
@property(nonatomic, assign) BOOL showBicycleLanes;

/** Controls if house numbers are rendered on the map. Default value is YES.
 */
@property(nonatomic, assign) BOOL showHouseNumbers;

/** Controls if one way streets are rendered on the map. Default value is YES.
 */
@property(nonatomic, assign) BOOL showOneWays;

/** Controls if street badges are rendered on the map. Default value is YES.
 */
@property(nonatomic, assign) BOOL showStreetBadges;

/** Controls if the map POI icons are rendered on the map. Default value is YES.
 */
@property(nonatomic, assign) BOOL showMapPoiIcons;

#pragma mark - Logo

/** Indicates the position of the osm attribution.
 */
@property(nonatomic, assign) SKAttributionPosition osmAttributionPosition;

/** Indicates the position of the company attribution.
 */
@property(nonatomic, assign) SKAttributionPosition companyAttributionPosition;

/** Specifies the drawing order for the drawable objects (e.g. polygons, polylines) and annotations. By default the annotations are rendered over drawable objects
 */
@property(nonatomic, assign) SKDrawingOrderType drawingOrderType;

#pragma mark - Factory method

/** A newly initialized SKMapSettings.
 */
+ (instancetype)mapSettings;

@end
