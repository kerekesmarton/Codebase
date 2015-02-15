//
//  ParserDelegate.m
//  SAFport
//
//  Created by Jozsef-Marton Kerekes on 11/15/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "ParserDelegate.h"
#import "ParsedObject.h"

@implementation ParserDelegate

#pragma mark - xml parsing

-(void)parseAndSaveObjects:(NSDictionary *)jsonTree {
    
    _context = [[VICoreDataManager getInstance] startTransaction];
    
    if ([jsonTree objectForKey:@"objects"]) {
        NSArray *array = [jsonTree objectForKey:@"objects"];
        for (NSDictionary *obj in array) {
            [self parseObject:obj];
        }
        
        [[VICoreDataManager getInstance] endTransactionForContext:_context];
    }
}

-(void)parseObject:(id)object {
    
    ParsedObject *obj = [self objectForDictionary:object];
    [self saveDataAfterFinishingItem:obj];
}

-(id)objectForDictionary:(NSDictionary *)name{
//    overwrite in successors
    return nil;
}

-(void)saveDataAfterFinishingItem:(id)item {
    
    //TODO : implement by successors
}

@end
