//
//  NSDictionary+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/17/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

- (id)safeObjectForKey:(NSString *)key {
    id obj = [self objectForKey:key];
    if (obj == [NSNull null]) {
        return nil;
    }
    
    return obj;
}

- (id)safeValueForKey:(NSString *)key {
    id obj = [self valueForKey:key];
    if (obj == [NSNull null]) {
        return nil;
    }
    
    return obj;
}

@end
