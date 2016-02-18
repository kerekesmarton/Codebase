//
//  AgendaObject.h
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 11/22/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "VIManagedObject.h"

#define agendaObjectID                      @"uID"
#define agendaObjectRURI                    @"resourceURI"
#define agendaObjectNameKey                 @"name"
#define agendaObjectTimeKey                 @"startTime"
#define agendaObjectEndTimeKey              @"endTime"
#define agendaObjectDetailsKey              @"details"
#define agendaObjectFavoritedKey            @"fav"
#define agendaObjectLocationKey             @"loc"
#define agendaObjectDifficultyKey           @"diff"
#define agendaObjectTypeKey                 @"type"
#define agendaObjectLinkKey                 @"link"
#define agendaObjectWeekDay                 @"weekday"
#define agendaObjectInstructorKey           @"instructor"

typedef enum AgendaObjectType {
    SAFworkshop = 0,
    SAFworkshops = 1,
    SAFshow = 2,
    SAFparty = 3,
    SAFother = 4,
} SAFeventType;

@interface AgendaObject : VIManagedObject

@property (nonatomic, retain) NSString * name;//
@property (nonatomic, retain) NSDate   * time;//
@property (nonatomic, retain) NSDate   * endTime;
@property (nonatomic, retain) NSString * details;//√
@property (nonatomic, retain) NSNumber * favorited;// bool
@property (nonatomic, retain) NSString * location;//
@property (nonatomic, retain) NSNumber * difficulty;// int
@property (nonatomic, retain) NSNumber * type;// int
@property (nonatomic, retain) NSString * link;//√
@property (nonatomic, retain) NSNumber * weekday;
@property (nonatomic, retain) NSString * instructor;//

+(id)fetchAgenda;
+(id)fetchAgendaForDay:(NSDate*)day;
+(NSArray*)distinctAgendaDays;
+(NSDictionary *)dataSource;

@end
