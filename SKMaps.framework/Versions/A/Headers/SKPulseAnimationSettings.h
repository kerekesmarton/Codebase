//
//  SKPulseAnimationSettings.h
//  SKMaps
//
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKAnimationSettings.h"
@class UIColor;

/** Stores the pulse animation settings.
 */
@interface SKPulseAnimationSettings : SKAnimationSettings

/** The pulse animation color.
 */
@property(nonatomic, strong) UIColor *color;

/** Specifies if the animation is continuous.
 */
@property(nonatomic, assign) BOOL isContinuous;

/** The pulse animation span.
 */
@property(nonatomic, assign) float span;

/** The time needed for the pulse animation to dissapear, measured in milliseconds.
 */
@property(nonatomic, assign) int fadeOutTime;

/** A newly initialized SKPulseAnimationSettings.
 */
+ (instancetype)pulseAnimationSettings;

@end
