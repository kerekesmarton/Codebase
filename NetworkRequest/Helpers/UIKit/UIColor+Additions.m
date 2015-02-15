//
//  UIColor+Additions.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 05/02/14.
//  Copyright (c) 2014 Jozsef-Marton Kerekes. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (id) colorWithHex:(unsigned int)hex{
	return [UIColor colorWithHex:hex alpha:1];
}

+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
	
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
	
}

@end
