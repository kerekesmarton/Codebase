//
//  ParsedArtist.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedArtist.h"
#import "ArtistObject.h"

@implementation ParsedArtist

-(NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    if (self.identifier) {
        [result setObject:self.identifier forKey:kArtistIDKey];
    }
    if (self.resourceUri) {
//        [result setObject:self.resourceUri forKey:kArtist];
    }
    
    if (self.desc) {
//        [result setObject:self.desc forKey:kArtistDesc1Key];
    }
    if (self.desc1) {
        [result setObject:self.desc1 forKey:kArtistDesc1Key];
    }
    if (self.desc2) {
        [result setObject:self.desc2 forKey:kArtistDesc2Key];
    }
    if (self.name) {
        [result setObject:self.name forKey:kArtistNameKey];
    }
    
    if (self.type) {
        [result setObject:self.type forKey:kArtistTypeKey];
    }
    if (self.img) {
        [result setObject:self.img forKey:kArtistImgKey];
    }
    if (self.loc) {
        [result setObject:self.loc forKey:kArtistLocKey];
    }
    
    return [NSDictionary dictionaryWithDictionary:result];
}

@end
