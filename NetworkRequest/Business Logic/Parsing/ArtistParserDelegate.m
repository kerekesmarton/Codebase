//
//  ArtistParserDelegate.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 12/26/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ArtistParserDelegate.h"
#import "ArtistObject.h"
#import "ParsedArtist.h"


@implementation ArtistParserDelegate

-(void)sendDidFinishNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kArtistParsingFinished object:nil]];
}

-(void)sendDidFailNotification {
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kArtistParsingFailed object:nil]];
}


-(id)objectForDictionary:(NSDictionary *)dictionary {
    
    ParsedArtist *artist = [[ParsedArtist alloc] init];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"id"]) {
            artist.identifier = obj;
        }
        if ([key isEqualToString:@"name"]) {
            artist.name = obj;
        }
        if ([key isEqualToString:@"resource_uri"]) {
            artist.resourceUri = obj;
        }
        if ([key isEqualToString:@"type"]) {
            artist.type = [self evaluateitem:obj forKey:key];
        }
        if ([key isEqualToString:@"location"]) {
            artist.loc = obj;
        }
        if ([key isEqualToString:@"shortDescription"]) {
            artist.desc1 = obj;
        }
        if ([key isEqualToString:@"fullDescription"]) {
            artist.desc2 = obj;
        }
        if ([key isEqualToString:@"img"]) {
            artist.img = obj;
        }
    }];
    
    return artist;
}

-(id)evaluateitem:(id)element forKey:(NSString *)key {
    
    if ([key isEqualToString:@"type"]) {
        
        return element;
    }
    return nil;
}

-(void)saveDataAfterFinishingItem:(ParsedArtist *)item{
    
    [ArtistObject addWithParams:[item dictionaryRepresentation] forManagedObjectContext:_context];
}


@end