//
//  SKTrailSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

/** SKTrailSettings stores settings for trail UI during turn by turn navigation.
 */
@interface SKTrailSettings : NSObject

/** Dotted trail or line.
 */
@property(nonatomic, assign, getter = isDotted) BOOL dotted;

/** Trail's color.
 */
@property(nonatomic, strong) UIColor *color;

/**Trail's width. Must be in (1-10) interval.
 */
@property(nonatomic, assign) unsigned int width;

/** A newly initialized SKTrailSettings.
 */
+ (instancetype)trailSettings;

@end
