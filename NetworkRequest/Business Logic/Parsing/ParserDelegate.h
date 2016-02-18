//
//  ParserDelegate.h
//  SAFport
//
//  Created by Jozsef-Marton Kerekes on 11/15/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VICoreDataManager.h"

@interface ParserDelegate : NSObject

@property(nonatomic,strong) NSManagedObjectContext *context;

- (void)saveDataAfterFinishingItem:(id)item;

/// Returns with an array containing the parsed objects.
- (NSArray *)parseAndSaveObjects:(NSDictionary *)jsonTree;
- (id)objectForDictionary:(NSDictionary *)name;

@end
