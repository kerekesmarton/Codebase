//
//  UIScrollView+Additions.h
//  ForeverMapNGX
//
//  Created by Mihai Babici on 11/7/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Additions)

@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) CGFloat contentOffsetY;

@end
