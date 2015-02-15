//
//  SettingsHelper.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/13/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingConstants.h"
#import "NewsDataManager.h"
#import "WorkshopsDataManager.h"

#define kDName              @"displayName"
#define kType               @"type"
#define kValues             @"value"
#define kPossibleValues     @"pValues"
#define kDisplayValues      @"dValues"
#define kActionBlock        @"action"



typedef void (^ SettingBlock)(void);

@interface SettingOption : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic) SettingType type;
@property (nonatomic, weak) SettingBlock actionBlock;

// config helper properties
@property (nonatomic, strong) NSArray *possibleValues;
@property (nonatomic, strong) NSArray *selectedValues;
@property (nonatomic, strong) NSArray *displayValues;



+(SettingOption*)settingOptionWithName:(NSString*)name;
-(void)save;

//only for boolean
-(void)changeWithControl:(id)sender;

//for enum / multi
-(void)addToSelectedValues:(id)value;
-(void)removeFromSelectedValues:(id)value;

//to update possible values;
-(void)addPossibleValues:(NSArray *)items;
-(void)removeItemsFromPossibleValues:(NSArray *)items;

-(void)reset;


#pragma mark - private 
+(NSDictionary*)optionWithType:(SettingType)type value:(NSArray*)values displayName:(NSString*)string possibleValues:(NSArray*)pValues displayValues:(NSArray *)displayValues;

@end


