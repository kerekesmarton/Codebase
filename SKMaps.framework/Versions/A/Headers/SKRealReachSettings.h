//
//  SKRealReachSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

/** SKRealReachSettings is used to store information about a real reach layer.
 */
@interface SKRealReachSettings : NSObject

/** The center coordinate of the realReach layer.
 */
@property(nonatomic, assign) CLLocationCoordinate2D centerLocation;

/** The range value of the RealReach.
 */
@property(nonatomic, assign) int range;

/** The unit of the range property. By default SKRealReachUnitSecond.
 */
@property(nonatomic, assign) SKRealReachUnit unit;

/** The connection mode used for route calculation. By default SKRouteConnectionOffline.
 */
@property(nonatomic, assign) SKRouteConnectionMode connectionMode;

/** The transport mode of the RealReach. By default SKTransportModePedestrian.
 */
@property(nonatomic, assign) SKTransportMode transportMode;

/** An array of NSNumber objects. Use this for SKRealReachUnitMiliAmp unit.
 */
@property(nonatomic, strong) NSArray *wattHour;

/** The number of objects in the wattHour array.
 */
@property(nonatomic, assign) int wattHourSize;

/** A newly initialized SKRealReachSettings.
 */
+ (instancetype)realReachSettings;

@end
