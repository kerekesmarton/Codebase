//
//  SKMapView+Overlays.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "SKMapView.h"

@class SKPolygon, SKCircle, SKPolyline;

/**
 */
@interface SKMapView (Overlays)

/** Adds a polygon overlay on the map.
 @param polygon Stores all the information about the polygon.
 @return The unique identifier of the added polygon. Can be used for removing the overlay.
 */
- (int)addPolygon:(SKPolygon *)polygon;

/** Adds a polyline overlay on the map.
 @param polyline Stores all the information about the polyline.
 @return The unique identifier of the added polyline. Can be used for removing the overlay.
 */
- (int)addPolyline:(SKPolyline *)polyline;

/** Adds a circle overlay on the map.
 @param circle Stores all the information about the circle.
 @return The unique identifier of the added circle. Can be used for removing the overlay.
 */
- (int)addCircle:(SKCircle *)circle;

/** Removes an overlay from the map.
 @param overlayID The id of the overlay that needs to be deleted.
 @return Succes/Failure of removing the overlay.
 */
- (BOOL)clearOverlayWithID:(int)overlayID;

/** Removes all overlays from the map.
 */
- (void)clearAllOverlays;

@end
