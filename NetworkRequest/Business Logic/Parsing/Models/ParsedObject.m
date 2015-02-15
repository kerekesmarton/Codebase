//
//  ParsedObject.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 26/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedObject.h"

#import "WorkshopObject.h"

@implementation ParsedObject

-(NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    if (self.identifier) {
        [result setObject:self.identifier forKey:workshopObjectID];
    }
    
    if (self.resourceUri) {
        [result setObject:self.resourceUri forKey:workshopObjectLinkKey];
    }
    if (self.desc) {
        [result setObject:self.desc forKey:workshopObjectDetailsKey];
    }
    if (self.name) {
        [result setObject:self.name forKey:workshopObjectNameKey];
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

@end
