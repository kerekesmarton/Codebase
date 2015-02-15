//
//  SettingsManager.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/1/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SettingsManager.h"

NSString *kNewsRefresh = @"kNewsRefresh";


@implementation SettingsManager

+(SettingsManager *)sharedInstance {
    static SettingsManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SettingsManager alloc] init];
    });
    return manager;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - properties to contrsuct settings VC-s

-(SettingOptionGroup *)structureForNews{
    
    return [SettingOptionGroup newsGroup];
}

-(SettingOptionGroup *)structureForArtists {
    
    return [SettingOptionGroup artistsGroup];
}

-(SettingOptionGroup *)structureForWorkshops {
    
    return [SettingOptionGroup workshopsGroup];
}

-(SettingOptionGroup *)structureForWorkshopDays {
    
    return [SettingOptionGroup workshopDaysGroup];
}

-(SettingOptionGroup *)structureForStreaming {
    
    return [SettingOptionGroup streamingGroup];;
}

#pragma mark - individual properties to access app settings


-(SettingOption *)newsRefreshSettings {
    
    return [SettingOption settingOptionWithName:NewsRefreshRate];
}

-(SettingOption *)artistsFilter {
    
    return [SettingOption settingOptionWithName:ArtistFilter];
}

-(SettingOption *)workshopsFilter {
    
    return [SettingOption settingOptionWithName:WorkshopFilter];
}

-(SettingOption *)selectedDay {
    
    return [SettingOption settingOptionWithName:DayFilter];
}

-(SettingOption *)selectedTags {
   
    return [SettingOption settingOptionWithName:StreamingTags];
}
@end





