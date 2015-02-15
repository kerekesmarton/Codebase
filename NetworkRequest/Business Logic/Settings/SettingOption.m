//
//  SettingsHelper.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/13/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SettingOption.h"

@implementation SettingOption

@synthesize name,type,selectedValues,possibleValues;



+(SettingOption*)settingOptionWithName:(NSString*)name{
    
    SettingOption *option = [[SettingOption alloc] init];
    option.name = name;
    [option load];
    
    return option;
}

-(void)save {
    
    [[NSUserDefaults standardUserDefaults] setObject:[SettingOption optionWithType:self.type value:self.selectedValues displayName:self.displayName possibleValues:self.possibleValues displayValues:self.displayValues] forKey:self.name];
    self.actionBlock();
}

#pragma mark - private config

+(NSDictionary*)optionWithType:(SettingType)type value:(NSArray*)values displayName:(NSString*)string possibleValues:(NSArray*)pValues displayValues:(NSArray *)displayValues{
    
    NSMutableDictionary *option = [NSMutableDictionary dictionary];
    [option setObject:[NSNumber numberWithInt:type] forKey:kType];
    [option setObject:values forKey:kValues];
    [option setObject:string forKey:kDName];
    [option setObject:pValues forKey:kPossibleValues];
    [option setObject:displayValues forKey:kDisplayValues];

    return [NSDictionary dictionaryWithDictionary:option];
}

-(void)load {
    
    NSDictionary *option = [[NSUserDefaults standardUserDefaults] objectForKey:self.name];
    if (!option) {
        option = [SettingOption initForKey:self.name];
    }
    
    self.type = [(NSNumber*)[option objectForKey:kType] intValue];
    self.selectedValues = [option objectForKey:kValues];
    self.displayName = [option objectForKey:kDName];
    self.possibleValues = [option objectForKey:kPossibleValues];
    self.displayValues = [option objectForKey:kDisplayValues];
    self.actionBlock = [SettingOption blockForName:self.name];
}



#pragma mark - public config

-(void)changeWithControl:(id)sender {
    
    if ([sender isMemberOfClass:[UISwitch class]] && self.type == SettingBool) {
        UISwitch *control = sender;
        
        self.selectedValues = @[[NSNumber numberWithBool:control.isOn]];

    }
    
    [self save];
}

-(void)addToSelectedValues:(id)value {
    
    
    
    if ([self.selectedValues containsObject:value]) {
        return;
    }
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.selectedValues];
    if (self.type != SettingMultiple) {
        [temp removeAllObjects];
    }
    [temp addObject:value];
    self.selectedValues = [NSArray arrayWithArray:temp];
    
    [self save];
}

-(void)removeFromSelectedValues:(id)value {
    if (![self.selectedValues containsObject:value]) {
        return;
    }
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.selectedValues];
    [temp removeObject:value];
    self.selectedValues = [NSArray arrayWithArray:temp];
    
    [self save];
}

-(void)addPossibleValues:(NSArray *)items {
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.possibleValues];
    
    [items enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (![temp containsObject:obj]) {
            [temp addObject:obj];
        }
    }];
    self.possibleValues = [NSArray arrayWithArray:temp];
    self.displayValues = [NSArray arrayWithArray:temp];
    [self save];
}

-(void)removeItemsFromPossibleValues:(NSArray *)items {
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.possibleValues];
    [items enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        
        if ([temp containsObject:obj]) {
            [temp removeObject:obj];
        }
    }];
    self.possibleValues = temp;
    [self save];
}

-(void)reset {
    
    self.selectedValues = [NSArray array];
    self.possibleValues = [NSArray array];
    self.displayValues = [NSArray array];
    [self save];
}

#pragma mark - Initializers

+(NSDictionary*)initForKey:(NSString *)key {
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    NSNumber *type ;
    id value;
    NSString *displayName;
    NSArray *possibleValues;
    NSArray *displayValsues;
    
    if ([key isEqualToString:NewsRefreshName]) {
        
        type = [NSNumber numberWithInt:SettingBool];
        value = @[[NSNumber numberWithBool:NO]];
        displayName = @"Refresh On/Off";
        possibleValues = @[];
        
    }
    
    if ([key isEqualToString:NewsRefreshRate]) {
        
        type = [NSNumber numberWithInt:SettingEnum];
        displayName = @"Refresh Rate";
        possibleValues = @[
                           @"Off",
                           [NSNumber numberWithFloat:1],//one hour
                           [NSNumber numberWithFloat:3],
                           [NSNumber numberWithFloat:12],
                           [NSNumber numberWithFloat:24],//one day
                           [NSNumber numberWithFloat:168],//one week
                           ];
        value = [NSArray arrayWithObject:[possibleValues objectAtIndex:0]];
        displayValsues = @[@"Off",@"One hour",@"Three hours",@"Twelve hours",@"One day",@"One week"];
    }
    
    if ([key isEqualToString:ArtistFilter]) {
        
        type = [NSNumber numberWithInt:SettingEnum];
        displayName = @"Artist Types";
        possibleValues = @[
                           @"instructor",
                           @"performer",
                           @"dj",
                           @"mc",
                           @"photo"
                           ];
        value = [NSArray arrayWithObject:[possibleValues objectAtIndex:0]];
        displayValsues = @[
                           @"Instructor",
                           @"Performer",
                           @"DJ",
                           @"MC",
                           @"Photographer"
                           ];
    }
    
    if ([key isEqualToString:DayFilter]) {
        
        type = [NSNumber numberWithInt:SettingEnum];
        displayName = @"Day Filter";
        possibleValues = [NSArray array];
        value = [NSArray array];
        displayValsues = [NSArray array];
    }
    
    if ([key isEqualToString:WorkshopFilter]) {
        
        type = [NSNumber numberWithInt:SettingEnum];
        displayName = @"Workshop Rooms";
        
        possibleValues = [NSArray array];
        value = [NSArray array];
        displayValsues = [NSArray array];
//                          @[
//                           @"Sober Room",
//                           @"Rehab Room",
//                           @"Residential Treatment",
//                           @"Surprise Treatment"
//                          ];
//        NSNumber *counter = [[NSUserDefaults standardUserDefaults] objectForKey:@"numWorkshopRooms"];
//        if (counter && [counter intValue] > 0) {
//            
//            NSMutableArray *tmp = [NSMutableArray array];
//            for (int i = 0; i < [counter intValue]; i++) {
//                NSString *readKey = [NSString stringWithFormat:@"room%d",i];
//                id obj = [[NSUserDefaults standardUserDefaults] objectForKey:readKey];
//                if (obj) {
//                    [tmp addObject:obj];
//                }
//            }
//            possibleValues = [NSArray arrayWithArray:tmp];
//            displayValsues = [NSArray arrayWithArray:tmp];
//        }        
    }
    
    if ([key isEqualToString:StreamingTags]) {
        
        type = [NSNumber numberWithInt:SettingEnum];
        displayName = @"Pick your style";
        possibleValues = @[@"salsa",@"mambo",@"chacha",@"son",@"rumba",@"guaguanco",@"guajira",@"bachata",@"zouk",@"kizomba"];
        value = @[@"salsa"];
        displayValsues = [NSArray arrayWithArray:possibleValues];
    }
    
    [properties setObject:value forKey:kValues];
    [properties setObject:type forKey:kType];
    [properties setObject:displayName forKey:kDName];
    [properties setObject:possibleValues forKey:kPossibleValues];
    [properties setObject:displayValsues forKey:kDisplayValues];
    
    [[NSUserDefaults standardUserDefaults] setObject:[SettingOption optionWithType:[type intValue] value:value displayName:displayName possibleValues:possibleValues displayValues:displayValsues] forKey:key];
    
    return [NSDictionary dictionaryWithDictionary:properties];
}

+ (SettingBlock)blockForName:(NSString*)key {
    
    if ([key isEqualToString:NewsRefreshRate]) {
        
        return ^(void){
            [[NewsDataManager sharedInstance] setupRefreshRate];
        };
    }
    return ^(void){};
}

@end