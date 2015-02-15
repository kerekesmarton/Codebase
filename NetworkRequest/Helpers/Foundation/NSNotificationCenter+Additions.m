//
//  NSNotificationCenter+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 7/4/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "NSNotificationCenter+Additions.h"

@implementation NSNotificationCenter (Additions)

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName {
    [NSNotificationCenterInstance addObserver:observer selector:aSelector name:aName object:nil];
}

- (void)removeObserver:(id)observer name:(NSString *)aName {
    [NSNotificationCenterInstance removeObserver:observer name:aName object:nil];
}

- (void)postNotificationName:(NSString *)aName {
    [NSNotificationCenterInstance postNotificationName:aName object:nil];
}

@end
