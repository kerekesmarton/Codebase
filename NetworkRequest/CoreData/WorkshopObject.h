//
//  WorkshopObject.h
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 12/10/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIManagedObject.h"

#define workshopObjectRURI                    @"resourceURI"
#define workshopObjectID                      @"uID"
#define workshopObjectNameKey                 @"name"
#define workshopObjectTimeKey                 @"startTime"
#define workshopObjectEndTimeKey              @"endTime"
#define workshopObjectDetailsKey              @"details"
#define workshopObjectFavoritedKey            @"fav"
#define workshopObjectLocationKey             @"location"
#define workshopObjectDifficultyKey           @"difficulty"
#define workshopObjectTypeKey                 @"type"
#define workshopObjectLinkKey                 @"link"
#define workshopObjectInstructorKey           @"instructor"
#define workshopObjectResourceKey             @"resourceURI"

typedef enum WSDifficulty {
    AllLevels = 0,
    Easy,
    Medium,
    Hard,
} WorkshopDiddiculty;

@interface WorkshopObject : VIManagedObject

@property (nonatomic, retain) NSString * name;//
@property (nonatomic, retain) NSDate   * time;//
@property (nonatomic, retain) NSDate   * endTime;
@property (nonatomic, retain) NSString * details;//√
@property (nonatomic, retain) NSNumber * favorited;// bool
@property (nonatomic, retain) NSString * location;//
@property (nonatomic, retain) NSNumber * difficulty;// int
@property (nonatomic, retain) NSNumber * type;// int
@property (nonatomic, retain) NSString * link;//√
@property (nonatomic, retain) NSNumber * instructor;//
@property (nonatomic, retain) NSString * feedbackComment;
@property (nonatomic, retain) NSNumber * feedbackRating;
@property (nonatomic, retain) NSNumber * feedbackUseful;
@property (nonatomic, retain) NSNumber * feedbackSent;

+(NSArray *)fetchWorkshops;
+(NSArray *)fetchWorkshopsForSelectedRooms;
+(NSArray *)fetchWorkshopsForSelectedDayAndRooms;
+(NSArray *)fetchWorkshopsForSelectedDayAllRooms;

+(NSDictionary *)fetchWorkshopsForDistinctHours:(BOOL)favorited;

+(WorkshopObject *)workshopForUID:(NSNumber *)uid;
+(NSArray *)fetchWorkshopsForDay:(NSDate*)day rooms:(NSArray *)rooms;
//+(NSArray *)fetchWorkshopsBetweenDays:(NSDate*)startDay endDay:(NSDate*)endDay;
+(NSArray *)fetchWorkshopsFromRooms:(NSArray*)rooms;

+(NSArray *)distinctWorkshopDays;
+(NSArray *)distinctWorkshopHours:(BOOL)favorited;

+(NSString *)stringForDifficulty:(int)value;
@end
