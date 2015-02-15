//
//  NSString+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/17/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)isNotEmptyOrWhiteSpace {
    return ([self stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0);
}

- (BOOL)isEmptyOrWhiteSpace {
    return ([self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0);
}

- (BOOL)containsAnyTokensFromArray:(NSArray *)strArray {
    NSMutableArray *tokens = [NSMutableArray array];
    for (NSString *token in strArray) {
        if ([token isNotEmptyOrWhiteSpace]) {
            [tokens addObject:token];
        }
    }
    
    NSInteger flags = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch | NSWidthInsensitiveSearch;
    for (NSString *token in tokens) {
        if ([self rangeOfString:token options:flags].location != NSNotFound) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)containsAllTokensFromArray:(NSArray *)strArray {
    NSMutableArray *tokens = [NSMutableArray array];
    for (NSString *token in strArray) {
        if ([token isNotEmptyOrWhiteSpace]) {
            [tokens addObject:token];
        }
    }
    
    NSInteger flags = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch | NSWidthInsensitiveSearch;
    for (NSString *token in tokens) {
        if ([self rangeOfString:token options:flags].location == NSNotFound) {
            return NO;
        }
    }
    
    return YES;
}


+ (NSString *)randomStringWithLength:(NSInteger)length {
    NSString *letters = @"abcdef ghijkl mnopqr stuvw xyz ABCDEF GHIJKL MNOPQR STUVW XYZ 0123456789 ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGFloat fontSize = [font pointSize];
    CGFloat height = [self sizeWithFont:font constrainedToSize:CGSizeMake(size.width,FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    UIFont *newFont = font;
    
    while (height > size.height && height != 0 && fontSize > 0) {
        fontSize--;
        newFont = [UIFont fontWithName:font.fontName size:fontSize];
        height = [self sizeWithFont:newFont constrainedToSize:CGSizeMake(size.width,FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    };
    
    for (NSString *word in [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) {
        CGFloat width = [word sizeWithFont:newFont].width;
        while (width > size.width && width != 0 && fontSize > 0) {
            fontSize--;
            newFont = [UIFont fontWithName:font.fontName size:fontSize];
            width = [word sizeWithFont:newFont].width;
        }
    }
    
    return fontSize;
}

@end
