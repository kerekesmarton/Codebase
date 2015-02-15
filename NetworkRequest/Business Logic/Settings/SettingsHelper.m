//
//  SettingsHelper.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/13/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SettingsHelper.h"



@implementation SettingOption {
    
}

@synthesize name,type,value;

+(NSDictionary*)optionWithType:(SettingType)type andValue:(id)value{
    
    NSMutableDictionary *option = [NSMutableDictionary dictionary];
    [option setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [option setObject:value forKey:@"value"];
    
    return [NSDictionary dictionaryWithDictionary:option];
}

-(void)save {
    
    [[NSUserDefaults standardUserDefaults] setObject:[SettingOption optionWithType:self.type andValue:self.value] forKey:self.name];
}

-(void)load {
    
    NSDictionary *option = [[NSUserDefaults standardUserDefaults] objectForKey:self.name];
    self.type = [(NSNumber*)[option objectForKey:@"type"] intValue];
    self.value = [option objectForKey:@"value"];
}

+(SettingOption*)settingOptionWithName:(NSString*)name {
    
    SettingOption *option = [[SettingOption alloc] init];
    option.name = name;
    [option load];
    
    return option;
}

@end