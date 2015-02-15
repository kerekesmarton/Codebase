//
//  NSMutableDictionary+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 1/17/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "NSMutableDictionary+Additions.h"

@implementation NSMutableDictionary (Additions)

- (void)setSafeObject:(id)object forKey:(NSString *)key {
    [self setObject:object ? object : [NSNull null] forKey:key];
}

- (void)setSafeValue:(id)value forKey:(NSString *)key {
    [self setValue:value ? value : [NSNull null] forKey:key];
}

@end
