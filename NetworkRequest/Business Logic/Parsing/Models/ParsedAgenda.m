//
//  ParsedAgenda.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedAgenda.h"
#import "AgendaObject.h"


@implementation ParsedAgenda

-(NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    if (self.identifier) {
        [result setObject:self.identifier forKey:agendaObjectID];
    }
    if (self.resourceUri) {
        [result setObject:self.resourceUri forKey:agendaObjectLinkKey];
    }
    if (self.desc) {
        [result setObject:self.desc forKey:agendaObjectDetailsKey];
    }
    if (self.name) {
        [result setObject:self.name forKey:agendaObjectNameKey];
    }
    
    if (self.time) {
        [result setObject:self.time forKey:agendaObjectTimeKey];
    }
    
    if (self.endTime) {
        [result setObject:self.endTime forKey:agendaObjectEndTimeKey];
    }
    
    if (self.isoWeekday) {
                [result setObject:self.isoWeekday forKey:agendaObjectWeekDay];
    }
    if (self.loc) {
        [result setObject:self.loc forKey:agendaObjectLocationKey];
    }
    
    return [NSDictionary dictionaryWithDictionary:result];
}

@end
