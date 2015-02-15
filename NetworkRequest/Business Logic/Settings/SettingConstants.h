//
//  SettingConstants.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/15/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#ifndef NetworkRequest_SettingConstants_h
#define NetworkRequest_SettingConstants_h

typedef enum {
    SettingBool = 1,
    SettingEnum,
    SettingMultiple,
    SettingGroup,
}SettingType;

#define NewsGroup       @"News"
#define NewsDescription @"Set the interval at which we should fetch news automatically from our servers"
#define NewsRefreshName @"Refresh News"
#define NewsRefreshRate @"Refresh Rate"

#define ArtistsGroup    @"Artists"
#define ArtistFilter    @"Artist Type"

#define WorkshopsGroup  @"Workshops"
#define WorkshopFilter  @"Workshop Type"

#define DayFilter       @"Day Filter"

#define StreamingGroup  @"Tags"
#define StreamingTags   @"Tags"

#endif
