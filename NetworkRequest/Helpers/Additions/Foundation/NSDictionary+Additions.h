//
//  NSDictionary+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/17/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (id)safeObjectForKey:(NSString *)key;
- (id)safeValueForKey:(NSString *)key;

@end
