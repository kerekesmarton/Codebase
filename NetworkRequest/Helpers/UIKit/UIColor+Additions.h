//
//  UIColor+Additions.h
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 05/02/14.
//  Copyright (c) 2014 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (id) colorWithHex:(unsigned int)hex;

+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

@end
