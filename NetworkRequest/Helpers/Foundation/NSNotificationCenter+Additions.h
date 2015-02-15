//
//  NSNotificationCenter+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 7/4/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSNotificationCenterInstance ([NSNotificationCenter defaultCenter])

@interface NSNotificationCenter (Additions)

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName;
- (void)removeObserver:(id)observer name:(NSString *)aName;
- (void)postNotificationName:(NSString *)aName;

@end
