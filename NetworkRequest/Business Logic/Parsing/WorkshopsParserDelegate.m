//
//  WorkshopsParserDelegate.m
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/27/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WorkshopsParserDelegate.h"
#import "WorkshopObject.h"
#import "ParsedWorkshop.h"

@implementation WorkshopsParserDelegate

-(void)sendDidFinishNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kWorkshopsParsingFinished object:nil]];
}

-(void)sendDidFailNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kWorkshopsParsingFailed object:nil]];
}

-(id)objectForDictionary:(NSDictionary *)dictionary {
    
    ParsedWorkshop *workshop = [[ParsedWorkshop alloc] init];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"id"]) {
            workshop.identifier = obj;
        }
        
        if ([key isEqualToString:@"name"]) {
            workshop.name = obj;
        }
        
        if ([key isEqualToString:@"location"]) {
            workshop.loc = [self evaluateitem:obj forKey:key];
        }
        
        if ([key isEqualToString:@"startTime"]) {
            workshop.time = [self evaluateitem:obj forKey:key];
            
            NSDate *startDate = workshop.time;
            NSDate *endDate = [NSDate dateWithTimeInterval:3600 sinceDate:startDate];
            workshop.endTime = endDate;
        }
        
        if ([key isEqualToString:@"isoweekday"]) {
            workshop.isoWeekday = obj;
        }
        
        if ([key isEqualToString:@"difficulty"]) {
            workshop.difficulty = obj;
        }
        
        if ([key isEqualToString:@"instructor"]) {
            workshop.instructor = obj;
        }
        
        if ([key isEqualToString:@"description"]) {
            workshop.desc = obj;
        }
        
        if ([key isEqualToString:@"resource_uri"]) {
            workshop.resourceUri = obj;
        }
    }];
    
    return workshop;
}

-(void)saveDataAfterFinishingItem:(ParsedObject *)item {
    
    [WorkshopObject addWithParams:[item dictionaryRepresentation] forManagedObjectContext:self.context];
}

-(id)evaluateitem:(id)element forKey:(NSString *)key {
    
    if ([key isEqualToString:workshopObjectTimeKey]) {
        
        NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:[element intValue]];
        
        return eventDate;
    }
    
    if ([key isEqualToString:workshopObjectLocationKey]) {
        if (!self.rooms) {
            self.rooms = [[NSMutableArray alloc] init];
        }
        if (![self.rooms containsObject:element]) {
            [self.rooms addObject:element];
//            NSString *savekey = [NSString stringWithFormat:@"room%d",(int)self.rooms.count];
//            [[NSUserDefaults standardUserDefaults] setObject:element forKey:savekey];
//            [[NSUserDefaults standardUserDefaults] setObject:@(self.rooms.count) forKey:@"numWorkshopRooms"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        return element;
    }
    
        return nil;
}

@end
