//
//  SettingsManager.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/1/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingOption.h"
#import "SettingOptionGroup.h"
#import "SettingConstants.h"

@interface SettingsManager : NSObject


+(SettingsManager *)sharedInstance;

#pragma mark - properties to contrsuct settings VC-s

-(SettingOptionGroup*)structureForNews;
-(SettingOptionGroup*)structureForArtists;
-(SettingOptionGroup*)structureForWorkshops;
-(SettingOptionGroup*)structureForWorkshopDays;
-(SettingOptionGroup*)structureForStreaming;


#pragma mark - individual properties for app settings

@property (nonatomic, readonly) SettingOption *newsRefreshSettings;
@property (nonatomic, readonly) SettingOption *artistsFilter;
@property (nonatomic, readonly) SettingOption *workshopsFilter;
@property (nonatomic, readonly) SettingOption *selectedDay;
@property (nonatomic, readonly) SettingOption *selectedTags;



@end



