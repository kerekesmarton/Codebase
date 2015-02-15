//
//  UIView+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/16/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

// Frame & bounds additions
@property (nonatomic, assign) CGFloat frameX;
@property (nonatomic, assign) CGFloat frameY;
@property (nonatomic, assign) CGFloat frameMaxX;
@property (nonatomic, assign) CGFloat frameMaxY;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
