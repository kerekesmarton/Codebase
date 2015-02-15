//
//  UIView+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 10/16/12.
//  Copyright (c) 2012 Kerekes Marton. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

@dynamic frameX;
@dynamic frameY;
@dynamic frameMaxX;
@dynamic frameMaxY;
@dynamic frameHeight;
@dynamic frameWidth;
@dynamic boundsHeight;
@dynamic boundsWidth;

#pragma mark - Dynamic properties

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)frameX {
    self.frame = CGRectMake(frameX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)frameY {
    self.frame = CGRectMake(self.frame.origin.x, frameY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameMaxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setFrameMaxX:(CGFloat)frameMaxX {
    CGFloat newWidth = fabsf(self.frame.origin.x - frameMaxX);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (CGFloat)frameMaxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setFrameMaxY:(CGFloat)frameMaxY {
    CGFloat newHeight = fabsf(self.frame.origin.x - frameMaxY);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)frameWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)frameHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
}

- (CGFloat)boundsWidth {
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)boundsWidth {
    self.bounds = CGRectMake(0.0, 0.0, boundsWidth, self.bounds.size.height);
}

- (CGFloat)boundsHeight {
    return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)boundsHeight {
    self.bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, boundsHeight);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
