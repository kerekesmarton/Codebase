//
//  ParsedNews.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedNews.h"
#import "NewsObject.h"

@implementation ParsedNews

-(NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    if (self.identifier) {
        [result setObject:self.identifier forKey:@"id"];
    }
    if (self.resourceUri) {
        [result setObject:self.resourceUri forKey:newsLinkKey];
    }
    if (self.desc) {
        [result setObject:self.desc forKey:newsDescriptionKey];
    }
    if (self.title) {
        [result setObject:self.title forKey:newsTitleKey];
    }
    if (self.pubDate) {
        [result setObject:self.pubDate forKey:newsTimeStamp];
    }    
    if (self.isRead) {
        [result setObject:self.isRead forKey:newsRead];
    }
    if (self.isDeleted) {
        [result setObject:self.isDeleted forKey:newsDeleted];
    }
    
    return [NSDictionary dictionaryWithDictionary:result];
}
@end
