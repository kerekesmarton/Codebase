//
//  CustomNavigationBar.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/9/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar


- (void)drawRect:(CGRect)rect {
    // Start by filling the area with the blue color
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        [[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_top_bar"]] setFill];
    } else {
        [[UIColor clearColor] setFill];
    }
    
    UIRectFill( rect );
    
}

@end
