//
//  SKMapInternationalizationSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

/** SKMapInternationalizationSettings stores information about the maps labeling language. First the primary option will be applied for displaying the name of the map elements (country, city, street names) on the first row. If it doesn't exist then the second option will be applied. For displaying both rows, the showBothRows property should be set to YES.
 */
@interface SKMapInternationalizationSettings : NSObject

/** This option will be applied first for the map labeling.
 */
@property(nonatomic, assign) SKMapInternationalizationOption primaryOption;

/** This option will be applied if the primaryOption is not available for a map element.
 */
@property(nonatomic, assign) SKMapInternationalizationOption fallbackOption;

/** The main language to be used if SKMapInternationalizationOptionInternational is used. By default is set to SKMapLanguageEN.
 */
@property(nonatomic, assign) SKMapLanguage primaryInternationalLanguage;

/** The fallback language to be used if SKMapInternationalizationOptionInternational is used. This language will be used if the primary international language is not available. By default is set to SKMapLanguageDE.
 */
@property(nonatomic, assign) SKMapLanguage fallbackInternationalLanguage;

/** Enables the displaying of the second row with the next available option.
 */
@property(nonatomic, assign) BOOL showBothRows;

/** Enables transliteration for the local names.
 */
@property(nonatomic, assign) BOOL backupToTransliterated;

/** A newly initialized SKMapInternationalizationSettings.
 */
+ (instancetype)mapInternationalization;

@end
