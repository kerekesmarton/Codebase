//
//  AgendaParserDelegate.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/1/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AgendaParserDelegate.h"
#import "AgendaObject.h"
#import "ParsedAgenda.h"

@implementation AgendaParserDelegate

-(void)sendDidFinishNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kAgendaParsingFinished object:nil]];
}

-(void)sendDidFailNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kAgendaParsingFailed object:nil]];
}

-(id)objectForDictionary:(NSDictionary *)dictionary {
    
    ParsedAgenda *agenda = [[ParsedAgenda alloc] init];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"id"]) {
            agenda.identifier = obj;
        }
        
        if ([key isEqualToString:@"name"]) {
            agenda.name = obj;
        }
        
        if ([key isEqualToString:@"location"]) {
            agenda.loc = obj;
        }
        
        if ([key isEqualToString:@"startTime"]) {
            agenda.time = [self evaluateitem:obj forKey:key];
        }
        
        if ([key isEqualToString:@"endTime"]) {
            agenda.endTime = [self evaluateitem:obj forKey:key];
        }
        
        if ([key isEqualToString:@"isoweekday"]) {
            agenda.isoWeekday = obj;
        }
        
        if ([key isEqualToString:@"type"]) {
            agenda.type = [self evaluateitem:obj forKey:key];
        }
        
        if ([key isEqualToString:@"resource_uri"]) {
            agenda.resourceUri = obj;
        }
        if ([key isEqualToString:@"details"]) {
            agenda.desc = obj;
        }
    }];
    
    return agenda;
}
-(id)evaluateitem:(id)element forKey:(NSString *)key {
    
    if ([key isEqualToString:@"startTime"] || [key isEqualToString:@"endTime"]) {
        
        if ([element isEqualToString:@"none"]) {
            return nil;
        } else {
            NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:[element intValue]];
            return eventDate;
        }        
    }

    if ([key isEqualToString:agendaObjectTypeKey]) {
        
        if ([element isEqualToString:@"party"]) {
            return @(SAFparty);
        }
        if ([element isEqualToString:@"other"]) {
            return @(SAFother);
        }
        if ([element isEqualToString:@"shows"]) {
            return @(SAFshow);
        }
        if ([element isEqualToString:@"workshops"]) {
            return @(SAFworkshops);
        }
        if ([element isEqualToString:@"workshop"]) {
            return @(SAFworkshop);
        }
    }
    
    return nil;
}

-(void)saveDataAfterFinishingItem:(id)item {
    
    [AgendaObject addWithParams:[item dictionaryRepresentation] forManagedObjectContext:_context];
}
//
//-(void)saveString:(NSString *)string forElement:(NSString *)element {
//    
//    if ([self.startedElementName isEqualToString:agendaObjectTimeKey]) {
//        
//        NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:[string intValue]];
//        [readData setObject:eventDate forKey:self.startedElementName];
//        startReading = NO;
//        
//        return;
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectEndTimeKey]) {
//        
//        NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:[string intValue]];
//        [readData setObject:eventDate forKey:self.startedElementName];
//        startReading = NO;
//        
//        return;
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectInstructorKey]) {
//        
//        [readData setObject:[NSNumber numberWithInt:[string intValue]] forKey:self.startedElementName];
//        startReading = NO;
//        
//        return;
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectDifficultyKey]) {
//        
//        [readData setObject:[NSNumber numberWithInt:[string intValue]] forKey:self.startedElementName];
//        startReading = NO;
//        return;
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectLocationKey]) {
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectID]) {
//        
//        [readData setObject:[NSNumber numberWithInt:[string intValue]] forKey:self.startedElementName];
//        startReading = NO;
//        return;
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectDetailsKey]) {
//        
//        NSString *saved = [readData objectForKey:self.startedElementName];
//        if (!saved) {
//            saved = [NSString string];
//        }
//        saved = [saved stringByAppendingFormat:@"\n %@",[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
//        [readData setObject:saved forKey:self.startedElementName];
//        
//        return;
//    }
//    
//    if ([self.startedElementName isEqualToString:agendaObjectTypeKey]) {
//        
//        SAFeventType objectType = 0;
//        if ([string isEqualToString:@"party"]) {
//            objectType = SAFparty;
//        }
//        if ([string isEqualToString:@"other"]) {
//            objectType = SAFother;
//        }
//        if ([string isEqualToString:@"shows"]) {
//            objectType = SAFshow;
//        }
//        if ([string isEqualToString:@"workshops"]) {
//            objectType = SAFworkshops;
//        }
//        if ([string isEqualToString:@"workshop"]) {
//            objectType = SAFworkshop;
//        }
//        
//        [readData setObject:[NSNumber numberWithInt:objectType] forKey:self.startedElementName];
//        startReading = NO;
//        return;
//    }
//
//    
//    [readData setObject:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:self.startedElementName];
//    startReading = NO;
//    
//    
//    
//    
//}
@end
