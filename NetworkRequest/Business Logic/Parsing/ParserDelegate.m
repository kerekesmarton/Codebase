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

-(NSArray *)parseAndSaveObjects:(NSDictionary *)jsonTree {
    
    NSMutableArray *freshObjects = [NSMutableArray array];
    
    self.context = [[VICoreDataManager getInstance] startTransaction];
    if ([jsonTree objectForKey:@"objects"])
    {
        NSArray *array = [jsonTree objectForKey:@"objects"];
        
        for (NSDictionary *obj in array)
        {
            ParsedObject *parsedObject = [self parseObject:obj];
            if (parsedObject)
            {
                [freshObjects addObject:parsedObject];
            }
        }
        
        [[VICoreDataManager getInstance] endTransactionForContext:self.context];
    }
    self.context = nil;
    
    return [freshObjects copy];
}

-(id)parseObject:(id)object {
    
    ParsedObject *obj = [self objectForDictionary:object];
    [self saveDataAfterFinishingItem:obj];
    return obj;
}

-(id)objectForDictionary:(NSDictionary *)name{

    NSAssert(1, @"Base implementation");
    return nil;
}

-(void)saveDataAfterFinishingItem:(id)item {
    
    NSAssert(1, @"Base implementation");
}

@end
