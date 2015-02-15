//
//  SKGPXDataComponent.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

/** SKGPXDataComponent is the model class for a track or a route contained in a GPX file.
 */
@interface SKGPXDataComponent : NSObject

/** The component type;
 */
@property(nonatomic, assign) SKGPXComponentType componentType;

/** The name of the component.
 */
@property(nonatomic, strong) NSString *name;

/**  A newly initialized SKGPXDataComponent.
 @param componentType The component type.
 @param name The component name.
 @return An autoreleased SKGPXDataComponent object.
 */
+ (instancetype)gpxDataComponentWithType:(SKGPXComponentType)componentType name:(NSString *)name;

@end
