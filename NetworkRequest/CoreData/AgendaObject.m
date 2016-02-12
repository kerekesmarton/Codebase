//
//  AgendaObject.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 11/22/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AgendaObject.h"

#import "DateHelper.h"


@implementation AgendaObject

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
@dynamic weekday;

+ (id)addWithParams:(NSDictionary *)params forManagedObjectContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uID == %@", [params objectForKey:agendaObjectID]];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"AgendaObject" withPredicate:predicate forContext:context];
    
    AgendaObject *agendaObject = (AgendaObject *)[items lastObject];
    
    if (agendaObject != nil) {
        return [self editWithParams:params forObject:agendaObject];
    } else {
        return [self syncWithParams:params forManagedObjectContext:context];
    }
}

+ (id)setInformationFromDictionary:(NSDictionary *)params forObject:(NSManagedObject *)object
{
    AgendaObject *agendaItem = (AgendaObject *)object;
    
    agendaItem.uID = [[params objectForKey:agendaObjectID] isKindOfClass:[NSNull class]] ? agendaItem.uID : [params objectForKey:agendaObjectID];
    agendaItem.name = [[params objectForKey:agendaObjectNameKey] isKindOfClass:[NSNull class]] ? agendaItem.name : [params objectForKey:agendaObjectNameKey];
    agendaItem.time = [[params objectForKey:agendaObjectTimeKey] isKindOfClass:[NSNull class]] ? agendaItem.time : [params objectForKey:agendaObjectTimeKey];
    agendaItem.endTime = [[params objectForKey:agendaObjectEndTimeKey] isKindOfClass:[NSNull class]] ? agendaItem.endTime : [params objectForKey:agendaObjectEndTimeKey];
    agendaItem.details = [[params objectForKey:agendaObjectDetailsKey] isKindOfClass:[NSNull class]] ? agendaItem.details : [params objectForKey:agendaObjectDetailsKey];
    agendaItem.favorited = [[params objectForKey:agendaObjectFavoritedKey] isKindOfClass:[NSNull class]] ? agendaItem.favorited : [params objectForKey:agendaObjectFavoritedKey];
    agendaItem.location = [[params objectForKey:agendaObjectLocationKey] isKindOfClass:[NSNull class]] ? agendaItem.location : [params objectForKey:agendaObjectLocationKey];
    agendaItem.difficulty = [[params objectForKey:agendaObjectDifficultyKey] isKindOfClass:[NSNull class]] ? agendaItem.difficulty : [params objectForKey:agendaObjectDifficultyKey];
    agendaItem.type = [[params objectForKey:agendaObjectTypeKey] isKindOfClass:[NSNull class]] ? agendaItem.type : [params objectForKey:agendaObjectTypeKey];
    agendaItem.link = [[params objectForKey:agendaObjectLinkKey] isKindOfClass:[NSNull class]] ? agendaItem.link : [params objectForKey:agendaObjectLinkKey];
    agendaItem.instructor = [[params objectForKey:agendaObjectInstructorKey] isKindOfClass:[NSNull class]] ? agendaItem.instructor : [params objectForKey:agendaObjectInstructorKey];
    agendaItem.weekday = [[params objectForKey:agendaObjectWeekDay] isKindOfClass:[NSNull class]] ? agendaItem.weekday : [params objectForKey:agendaObjectWeekDay];
    return agendaItem;
}

+(id)fetchAgenda {
    
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class])];
    return [results sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(AgendaObject *)obj1 time] compare:[(AgendaObject *)obj2 time]];
    }];
}

+(id)fetchAgendaForDay:(NSDate*)day{
    
    NSNumber *weekday = [DateHelper weekdayOfDay:day];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"weekday = %@", weekday];
    
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class]) withPredicate:pred forContext:[VICoreDataManager getInstance].managedObjectContext];
    return [results sortedArrayUsingComparator:^NSComparisonResult(AgendaObject *obj1, AgendaObject *obj2) {
        return [[obj1 time] compare:[obj2 time]];
    }];;
}

+(NSArray*)distinctAgendaDays {
    
    NSArray *results = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class])];
    NSMutableArray *days = [NSMutableArray array];
    [results enumerateObjectsUsingBlock:^(AgendaObject *obj, NSUInteger idx, BOOL *stop) {
        NSDate *startOfDay = [DateHelper begginingOfDay:obj.time];
        if (![days containsObject:startOfDay]) {
            [days addObject:startOfDay];
        }
    }];
    
    return [NSArray arrayWithArray:[days sortedArrayUsingSelector:@selector(compare:)]];
}

+(NSDictionary *)dataSource {
    
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    for (NSDate *date in [self distinctAgendaDays]) {
        
        NSArray *agenda = [self fetchAgendaForDay:date];
        [results setObject:agenda forKey:date];
    }
    return [results copy];
}

@end
