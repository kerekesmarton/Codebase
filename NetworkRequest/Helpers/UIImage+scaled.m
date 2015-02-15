//
//  UIImage+scaled.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 2/8/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "UIImage+scaled.h"

@implementation UIImage (scaled)

- (UIImage *)scaleToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
