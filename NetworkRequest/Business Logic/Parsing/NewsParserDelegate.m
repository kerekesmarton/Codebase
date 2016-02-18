//
//  NewsParserDelegate.m
//  Festival
//
//  Created by Jozsef-Marton Kerekes on 3/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "NewsParserDelegate.h"
#import "ParsedNews.h"
#import "NewsObject.h"

@implementation NewsParserDelegate

-(void)sendDidFinishNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNewsParsingFinished object:nil]];
}

-(void)sendDidFailNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNewsParsingFailed object:nil]];
}

-(id)objectForDictionary:(NSDictionary *)dictionary {
    
     ParsedNews *news = [[ParsedNews alloc] init];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"id"]) {
            news.identifier = obj;
        }
        if ([key isEqualToString:@"title"]) {
            news.title = obj;
        }
        if ([key isEqualToString:@"publicationDate"]) {
            news.pubDate = [self evaluateitem:obj forKey:key];
        }
        if ([key isEqualToString:@"description"]) {
            news.desc = obj;
        }
        if ([key isEqualToString:@"resource_uri"]) {
            news.resourceUri = obj;
        }
    }];
    
    return news;
}

-(id)evaluateitem:(id)element forKey:(NSString *)key {
    
    if ([key isEqualToString:@"publicationDate"]) {
        
        NSDate *eventDate = [NSDate dateWithTimeIntervalSince1970:[element intValue]];
        
        return eventDate;
    }
    return nil;
}

-(void)saveDataAfterFinishingItem:(ParsedNews *)item {
    
    item.deleted = @NO;
    item.read = @NO;
    
    [NewsObject addWithParams:[item dictionaryRepresentation] forManagedObjectContext:self.context];
}

@end
