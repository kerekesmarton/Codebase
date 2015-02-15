//
//  WorkshopObject.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 12/10/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WorkshopObject.h"
#import "DateHelper.h"
#import "SettingsManager.h"

@implementation WorkshopObject

@dynamic name;
@dynamic time;
@dynamic endTime;
@dynamic details;
@dynamic favorited;
@dynamic location;
@dynamic difficulty;
@dynamic type;
@dynamic link;
@dynamic instructor;
@dynamic uID;
@dynamic feedbackComment;
@dynamic feedbackRating;
@dynamic feedbackUseful;
@dynamic feedbackSent;

+ (id)addWithParams:(NSDictionary *)params forManagedObjectContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uID == %@", [params objectForKey:workshopObjectID]];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"WorkshopObject" withPredicate:predicate forContext:context];
    
    WorkshopObject *item = (WorkshopObject *)[items lastObject];
    
    if (item != nil) {
        return [self editWithParams:params forObject:item];
    } else {
        return [self syncWithParams:params forManagedObjectContext:context];
    }
}

+ (id)setInformationFromDictionary:(NSDictionary *)params forObject:(NSManagedObject *)object
{
    WorkshopObject *item = (WorkshopObject *)object;
    
    item.uID = [[params objectForKey:workshopObjectID] isKindOfClass:[NSNull class]] ? item.uID : [params objectForKey:workshopObjectID];
    item.name = [[params objectForKey:workshopObjectNameKey] isKindOfClass:[NSNull class]] ? item.name : [params objectForKey:workshopObjectNameKey];
    item.time = [[params objectForKey:workshopObjectTimeKey] isKindOfClass:[NSNull class]] ? item.time : [params objectForKey:workshopObjectTimeKey];
    item.endTime = [[params objectForKey:workshopObjectEndTimeKey] isKindOfClass:[NSNull class]] ? item.endTime : [params objectForKey:workshopObjectEndTimeKey];
    item.details = [[params objectForKey:workshopObjectDetailsKey] isKindOfClass:[NSNull class]] ? item.details : [params objectForKey:workshopObjectDetailsKey];
    item.favorited = [params objectForKey:workshopObjectFavoritedKey] == nil ? item.favorited : [params objectForKey:workshopObjectFavoritedKey];
    item.location = [[params objectForKey:workshopObjectLocationKey] isKindOfClass:[NSNull class]] ? item.location : [params objectForKey:workshopObjectLocationKey];
    item.difficulty = [[params objectForKey:workshopObjectDifficultyKey] isKindOfClass:[NSNull class]] ? item.difficulty : [params objectForKey:workshopObjectDifficultyKey];
    item.type = [[params objectForKey:workshopObjectTypeKey] isKindOfClass:[NSNull class]] ? item.type : [params objectForKey:workshopObjectTypeKey];
    item.instructor = [[params objectForKey:workshopObjectInstructorKey] isKindOfClass:[NSNull class]] ? item.instructor : [params objectForKey:workshopObjectInstructorKey];
    
    return item;
}

+(NSArray *)fetchWorkshops {
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class])];
    return [results sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(WorkshopObject *)obj1 time] compare:[(WorkshopObject *)obj2 time]];
    }];
}

+(NSArray *)fetchWorkshopsForSelectedDayAndRooms {
    NSDate *day = [[SettingsManager sharedInstance].selectedDay.selectedValues lastObject];
    return [self fetchWorkshopsForDay:day rooms:[SettingsManager sharedInstance].workshopsFilter.selectedValues];
}

+(NSArray *)fetchWorkshopsForSelectedDayAllRooms {
    
    NSDate *day = [[SettingsManager sharedInstance].selectedDay.selectedValues lastObject];
    return [self fetchWorkshopsForDay:day rooms:[SettingsManager sharedInstance].workshopsFilter.possibleValues];
}

+(NSArray *)fetchWorkshopsForSelectedRooms {
    return [WorkshopObject fetchWorkshopsFromRooms:[SettingsManager sharedInstance].workshopsFilter.selectedValues];
}


+(WorkshopObject *)workshopForUID:(NSNumber *)uid {
    
    NSArray *result =[self fetchForPredicate:[NSPredicate predicateWithFormat:@"uID == %@",uid] forManagedObjectContext:[VICoreDataManager getInstance].managedObjectContext];
    if (result) {
        return [result lastObject];
    } else
    {
        return nil;
    }
    
}

+(NSArray *)fetchWorkshopsForDay:(NSDate*)day rooms:(NSArray *)rooms{
    
    if (!day) {
        return [NSArray array];
    }
    NSMutableArray *subpreds = [NSMutableArray array];
    for (NSString *str in rooms) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"location == %@",str];
        [subpreds addObject:pred];
    }
    NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType subpredicates:subpreds];
    
    NSMutableArray *firstResults = [NSMutableArray arrayWithArray:[WorkshopObject fetchForPredicate:predicate forManagedObjectContext:[VICoreDataManager getInstance].managedObjectContext]];
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSDate *startOfDay = [DateHelper begginingOfDay:day];
    NSDate *endOfDay = [DateHelper endOfDay:day];
    
    [firstResults enumerateObjectsUsingBlock:^(WorkshopObject *obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj.time earlierDate:startOfDay] == startOfDay && [obj.time laterDate:endOfDay]==endOfDay) {
            [results addObject:obj];
        }
    }];
    
    return [results sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(WorkshopObject *)obj1 time] compare:[(WorkshopObject *)obj2 time]];
    }];
}

/*
//TODO:  method to fetch all workshops of an artist
 */

+(NSArray*)fetchWorkshopsFromRooms:(NSArray*)rooms {
    
    NSMutableArray *subpreds = [NSMutableArray array];
    for (NSString *str in rooms) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"location == %@",str];
        [subpreds addObject:pred];
    }
    NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType subpredicates:subpreds];
    
    NSArray *results = [WorkshopObject fetchForPredicate:predicate forManagedObjectContext:[VICoreDataManager getInstance].managedObjectContext];
    return [results sortedArrayUsingComparator:^NSComparisonResult(WorkshopObject *obj1, WorkshopObject *obj2) {
        return [[obj1 time] compare:[obj2 time]];
    }];
}

+(NSArray *)fetchFavoritedWorkshops {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"favorited == ", @YES];
    
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class]) withPredicate:pred forContext:[VICoreDataManager getInstance].managedObjectContext];
    results = [results sortedArrayUsingComparator:^NSComparisonResult(WorkshopObject *obj1, WorkshopObject *obj2) {
        return [[obj1 time] compare:[obj2 time]];
    }];
    
    NSMutableDictionary *scannedDates = [NSMutableDictionary dictionary];
    
    for (WorkshopObject *item1 in results) {
        
        if (![scannedDates objectForKey:item1.time.description]) {
            NSIndexSet *indexesOfItemsAtSameTime = [results indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [[(WorkshopObject*)obj time] isEqualToDate:[item1 time]];
            }];
            
            [scannedDates setObject:[results objectsAtIndexes:indexesOfItemsAtSameTime] forKey:item1.time.description];
        }
    }
    
    return results;
}

+(NSArray *)distinctWorkshopDays {
    
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class])];
    NSMutableArray *days = [NSMutableArray array];
    [results enumerateObjectsUsingBlock:^(WorkshopObject *obj, NSUInteger idx, BOOL *stop) {
        NSDate *startOfDay = [DateHelper begginingOfDay:obj.time];
        if (![days containsObject:startOfDay]) {
            [days addObject:startOfDay];
        }
    }];
    
    return [NSArray arrayWithArray:[days sortedArrayUsingSelector:@selector(compare:)]];
}

+(NSArray *)distinctWorkshopHours:(BOOL)favorited {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"favorited == %@", [NSNumber numberWithBool:favorited]];
    
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class]) withPredicate:pred forContext:[VICoreDataManager getInstance].managedObjectContext];
    
    NSDate *day = [[SettingsManager sharedInstance].selectedDay.selectedValues lastObject];
    NSDate *startOfDay = [DateHelper begginingOfDay:day];
    NSDate *endOfDay = [DateHelper endOfDay:day];
    
    NSMutableArray *secondResults = [[NSMutableArray alloc] init];
    [results enumerateObjectsUsingBlock:^(WorkshopObject *obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj.time earlierDate:startOfDay] == startOfDay && [obj.time laterDate:endOfDay]==endOfDay) {
            [secondResults addObject:obj];
        }
    }];

    NSMutableArray *hours = [NSMutableArray array];
    [secondResults enumerateObjectsUsingBlock:^(WorkshopObject *obj, NSUInteger idx, BOOL *stop) {
        
        NSDate *date = [obj.time copy];
        if (![hours containsObject:date]) {
            [hours addObject:date];
        }
    }];
    
    return [NSArray arrayWithArray:[hours sortedArrayUsingSelector:@selector(compare:)]];
}

+(NSDictionary *)fetchWorkshopsForDistinctHours:(BOOL)favorited {
    
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"favorited == %@", [NSNumber numberWithBool:favorited]];
    NSArray *firstResults = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class]) withPredicate:pred forContext:[VICoreDataManager getInstance].managedObjectContext];
    
    
    [[self distinctWorkshopHours:favorited] enumerateObjectsUsingBlock:^(NSDate *date, NSUInteger idx, BOOL *stop) {
        
        NSMutableArray *secondResults = [NSMutableArray array];
        
        [firstResults enumerateObjectsUsingBlock:^(WorkshopObject *obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj.time isEqualToDate:date]) {
                [secondResults addObject:obj];
            }
        }];
        [results setObject:secondResults forKey:date.description];
        
    }];
    
    return [NSDictionary dictionaryWithDictionary:results];
}

+(NSString *)stringForDifficulty:(int)value {
    
    NSString *diff;
    
    switch (value) {
        case 1:
            diff = @"INTER-ADVANCED";
            break;
        case 2:
            diff = @"INTERMEDIATE";
            break;
        case 3:
            diff = @"ADVANCED";
            break;
        case 4:
            diff = @"ALL LEVELS";
            break;
        default:
            diff = @"";
            break;
    }
    return diff;
}

@end
