//
//  SKRouteAdvice.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

/**SKRouteAdvice stores information about a route advice.
 */

@interface SKRouteAdvice : NSObject

/** Unique ID of the advice.
 */
@property(nonatomic, assign) int adviceID;

/** Time left to reach the destination, in seconds.
 */
@property(nonatomic, assign) int timeToDestination;

/** Distance to destination, in the desired format.
 */
@property(nonatomic, assign) int distanceToDestination;

/** Distance between the previous and the current advice, in meters.
 */
@property(nonatomic, assign) int distanceToAdvice;

/** Time between the previous and the current advice, in seconds.
 */
@property(nonatomic, assign) int timeToAdvice;

/** The street after the advice.
 */
@property(nonatomic, strong) NSString *streetName;

/** Path to the visual advice file generated on the disk.
 */
@property(nonatomic, strong) NSString *visualAdviceFile;

/** The playlist for the advice, containing NSString objects with the names of audio .mp3 files.
 */
@property(nonatomic, strong) NSMutableArray *audioFilePlaylist;

/** The sentence of the instructions.
 */
@property(nonatomic, strong) NSString *adviceInstruction;

/** The GPS coordinate of the advice.
 */
@property(nonatomic, assign) CLLocationCoordinate2D location;

@end
