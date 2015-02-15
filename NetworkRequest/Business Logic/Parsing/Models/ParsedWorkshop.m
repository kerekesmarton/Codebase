//
//  WorkshopObject.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 26/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedWorkshop.h"
#import "WorkshopObject.h"

@implementation ParsedWorkshop

-(NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *result = [[super dictionaryRepresentation] mutableCopy];
    
    if (self.time) {
        [result setObject:self.time forKey:workshopObjectTimeKey];
    }
    
    if (self.endTime) {
        [result setObject:self.endTime forKey:workshopObjectEndTimeKey];
    }
    
    if (self.difficulty) {
        [result setObject:self.difficulty forKey:workshopObjectDifficultyKey];
    }
    if (self.instructor) {
        [result setObject:self.instructor forKey:workshopObjectInstructorKey];
    }
    if (self.isoWeekday) {
//        [result setObject:self.resourceUri forKey:workshopObjectNameKey];
    }
    if (self.loc) {
        [result setObject:self.loc forKey:workshopObjectLocationKey];
    }
    return [NSDictionary dictionaryWithDictionary:result];
}
@end
