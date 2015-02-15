//
//  SettingsOptionGroup.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/17/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingOptionGroup : NSObject
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSString *groupDescription;
-(NSArray*)items;

+(SettingOptionGroup*)newsGroup;
+(SettingOptionGroup*)artistsGroup;
+(SettingOptionGroup*)workshopsGroup;
+(SettingOptionGroup*)workshopDaysGroup;
+(SettingOptionGroup*)streamingGroup;
@end

