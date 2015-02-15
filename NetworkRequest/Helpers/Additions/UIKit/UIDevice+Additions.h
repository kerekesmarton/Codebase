//
//  UIDevice+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 11/28/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Additions)

+ (BOOL)isiPad;
+ (BOOL)isRetinaiPad;
+ (BOOL)isWidescreeniPhone;
+ (NSString *)deviceModel;

-(NSString*)uniqueDeviceID;

@end
