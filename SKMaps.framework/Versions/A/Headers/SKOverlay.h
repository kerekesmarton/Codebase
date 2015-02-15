//
//  SKOverlay.h
//  SKMaps
//
//  Created by csongor on 04/08/14.
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIColor;

/** Stores information about an overlay.
 */
@interface SKOverlay : NSObject

/** The inner/outer color of the polygon depending on the value of the isMask property.
 */
@property(nonatomic, strong) UIColor *fillColor;

/** The number of pixels of a dotted line. Set to 0 for solid boder.
 */
@property(nonatomic, assign) int borderDotsSize;

/** The number of pixels between the dotted lines.
 */
@property(nonatomic, assign) int borderDotsSpacingSize;

@end
