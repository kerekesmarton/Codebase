//
//  UIScrollView+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 11/7/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import "UIScrollView+Additions.h"

@implementation UIScrollView (Additions)

@dynamic contentHeight;
@dynamic contentWidth;
@dynamic contentOffsetX;
@dynamic contentOffsetY;

#pragma mark - Dynamic properties

- (CGFloat)contentWidth {
    return self.contentSize.width;
}

- (void)setContentWidth:(CGFloat)contentWidth {
    self.contentSize = CGSizeMake(contentWidth, self.contentSize.height);
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}

- (void)setContentHeight:(CGFloat)contentHeight {
    self.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
}

- (CGFloat)contentOffsetX {
    return self.contentOffset.x;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX {
    self.contentOffset = CGPointMake(contentOffsetX, self.contentOffset.y);
}

- (CGFloat)contentOffsetY {
    return self.contentOffset.y;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    self.contentOffset = CGPointMake(self.contentOffset.x, contentOffsetY);
}

@end
