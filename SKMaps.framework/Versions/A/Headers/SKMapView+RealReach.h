//
//  SKMapView+RealReach.h
//  SKMaps
//
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import "SKMapView.h"

@class SKRealReachSettings;

/**
 */
@interface SKMapView (RealReach)

/** Adds a RealReach layer on the map.
 @param realReachSettings Contains settings for the RealReach layer.
 */
- (void)displayRealReachWithSettings:(SKRealReachSettings *)realReachSettings;

/** Clears the RealReach layer from the map.
 */
- (void)clearRealReachDisplay;

/** Verifies is the RealReach layer fits in the specified bounding box.
 @param boundingBox Defines a bounding box on the map.
 @return A boolean value indicating if the RealReach fits in the specified bounding box.
 */
- (BOOL)isRealReachDisplayedInBoundingBox:(SKBoundingBox *)boundingBox;


@end
