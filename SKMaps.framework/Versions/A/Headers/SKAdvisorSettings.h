//
//  SKAdvisorSettings.h
//  SKMaps
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>

/** SKAdvisorSettings stores information about the audio advisor settings, that will be used during a navigation.
 */
@interface SKAdvisorSettings : NSObject

/** The voice folder name, located in the resourcesPath. The default is "en_us" .
 */
@property(nonatomic, strong) NSString *advisorVoice;

/** The absolute path to the advisor files resource folder. The default is SKAdvisorResources.bundle/Languages, located in the main bundle. Should be changed only for downloaded advisor languages.
 */
@property(nonatomic, strong) NSString *resourcesPath;

/** The language code of the advice. The default is "en_us".
 */
@property(nonatomic, strong) NSString *language;

/** The absolute path to the advisor files configs folder. The default is SKAdvisorResources.bundle/Configs, located in the main bundle.
 */
@property(nonatomic, strong) NSString *configPath;

/** A newly initialized SKAdvisorSettings.
 */
+ (instancetype)advisorSettings;

@end
