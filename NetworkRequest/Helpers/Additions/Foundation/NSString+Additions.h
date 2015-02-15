//
//  NSString+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/17/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)isNotEmptyOrWhiteSpace;
- (BOOL)isEmptyOrWhiteSpace;
- (BOOL)containsAnyTokensFromArray:(NSArray *)strArray;
- (BOOL)containsAllTokensFromArray:(NSArray *)strArray;

- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

+ (NSString *)randomStringWithLength:(NSInteger)length;

@end
