//
//  UIApplication+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 11/28/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

typedef enum UIInterfaceMasks {
    UIInterfaceOrientationPortraitMask = (1 << UIInterfaceOrientationPortrait),
    UIInterfaceOrientationLandscapeLeftMask = (1 << UIInterfaceOrientationLandscapeLeft),
    UIInterfaceOrientationLandscapeRightMask = (1 << UIInterfaceOrientationLandscapeRight),
    UIInterfaceOrientationPortraitUpsideDownMask = (1 << UIInterfaceOrientationPortraitUpsideDown),
    UIInterfaceOrientationLandscapeMask = (UIInterfaceOrientationLandscapeLeftMask | UIInterfaceOrientationLandscapeRightMask),
    UIInterfaceOrientationAllMask = (UIInterfaceOrientationPortraitMask | UIInterfaceOrientationLandscapeLeftMask | UIInterfaceOrientationLandscapeRightMask | UIInterfaceOrientationPortraitUpsideDownMask),
    UIInterfaceOrientationAllButUpsideDownMask = (UIInterfaceOrientationPortraitMask | UIInterfaceOrientationLandscapeLeftMask | UIInterfaceOrientationLandscapeRightMask),
    
} UIInterfaceMasks;

@interface UIApplication (Additions)

+ (AppDelegate *)appDelegate;

+(NSString*)getUniqueIdentifier;

@end
