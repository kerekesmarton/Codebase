//
//  NSArray+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/17/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (id)safeObjectAtIndex:(NSUInteger)index {
    id obj = [self objectAtIndex:index];
    if (obj == [NSNull null]) {
        return nil;
    }
    
    return obj;
}

@end
