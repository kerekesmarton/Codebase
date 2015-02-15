//
//  SettingsOptionGroup.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/17/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SettingOptionGroup.h"
#import "SettingOption.h"
#import "SettingConstants.h"

@interface SettingOptionGroup()
@property (nonatomic, retain) NSMutableArray *options;

@end

@implementation SettingOptionGroup

@synthesize options;

+(SettingOptionGroup*)newsGroup {
    
    return [SettingOptionGroup optionGroupWithItems:@[
            //            [SettingOption settingOptionWithName:NewsRefreshName],
            [SettingOption settingOptionWithName:NewsRefreshRate]
            ] name:NewsGroup andDescription:NewsDescription];
}

+(SettingOptionGroup*)artistsGroup {
    
    return [SettingOptionGroup optionGroupWithItems:@[
            [SettingOption settingOptionWithName:ArtistFilter]
            ] andName:ArtistsGroup];
}

+(SettingOptionGroup*)workshopsGroup {
    
    return [SettingOptionGroup optionGroupWithItems:@[
            [SettingOption settingOptionWithName:WorkshopFilter]
            ] andName:WorkshopsGroup];
}

+(SettingOptionGroup*)workshopDaysGroup {
    
    return [SettingOptionGroup optionGroupWithItems:@[
            [SettingOption settingOptionWithName:DayFilter]
            ] andName:DayFilter];
}

+(SettingOptionGroup*)streamingGroup {
    
    return [SettingOptionGroup optionGroupWithItems:@[
            [SettingOption settingOptionWithName:StreamingTags]
            ] andName:StreamingGroup];
}
+(SettingOptionGroup*)optionGroupWithItems:(NSArray*)array andName:(NSString*)groupName{
    
    return [self optionGroupWithItems:array name:groupName andDescription:nil];
}

+(SettingOptionGroup*)optionGroupWithItems:(NSArray*)array name:(NSString*)groupName andDescription:(NSString *)descriptionStr{
    
    SettingOptionGroup *optionGroup = [[SettingOptionGroup alloc] init];
    optionGroup.options = [NSMutableArray arrayWithArray:array];
    optionGroup.groupName = groupName;
    optionGroup.groupDescription = descriptionStr;
    return optionGroup;
}

-(NSArray*)items {
    
    return self.options;
}
@end
