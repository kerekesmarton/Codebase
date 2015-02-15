//
//  FMToolbarButton.m
//  ForeverMapNGX
//
//  Created by BogdanB on 7/9/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "FMToolbarButton.h"

@interface FMToolbarButton ()
{
    
}

@end

@implementation FMToolbarButton

@synthesize image = _image;
@dynamic highlightedImage;
@synthesize  disabledImage = _disabledImage;
@dynamic text;
@synthesize textColor = _textColor;
@dynamic highlightedTextColor;
@synthesize disabledTextColor = _disabledTextColor;
@dynamic textFont;
@synthesize normalStateColor = _normalStateColor;
@synthesize highlightedStateColor = _highlightedStateColor;
@synthesize highlighted = _highlighted;
@synthesize enabled = _enabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addImage];
        [self addLabel];
        self.highlightedStateColor =  [UIColor blackColor];
        self.normalStateColor = [UIColor blackColor];
        self.backgroundColor = [UIColor blackColor];
        self.highlighted = NO;
        self.selected = NO;
        self.enabled = YES;
        self.disabledColor = [UIColor grayColor];
        self.disabledImage = nil;
        self.highlightedImage = nil;
        self.textColor = [UIColor colorWithHex:0xa3a3a3];
        self.layout = FMToolbarButtonLayoutCenteredTextAndImage;
    }
    return self;
}

- (void) dealloc {
    self.image = nil;
    self.disabledImage = nil;
    self.textColor = nil;
    self.disabledTextColor = nil;
    self.normalStateColor = nil;
    self.highlightedStateColor = nil;
    [super dealloc];
}

#pragma mark - UI creation

- (void)addImage {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.boundsWidth, self.image.size.height)];
    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
    [_imageView release];
}

- (void)addLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _imageView.frameMaxY, self.boundsWidth, self.boundsHeight - _imageView.frameMaxY)];
    _label.text = @"";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.highlightedTextColor = [UIColor whiteColor];
    _label.font = [UIFont fontWithName:@"Avenir" size:16.0];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_label];
    [_label release];
}

#pragma mark - Overriden

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_image) {
        _imageView.frameHeight = _image.size.height;
    } else if (_imageView.highlightedImage) {
        _imageView.frameHeight = _imageView.highlightedImage.size.height;
    } else if (_disabledImage) {
        _imageView.frameHeight = _disabledImage.size.height;
    } else {
        _imageView.frameHeight = 0.0;
    }

    CGSize constrainSize = CGSizeMake(self.boundsWidth, self.boundsHeight - _imageView.frameMaxY - 2.0);
    float labelHeight = [_label.text sizeWithFont:_label.font constrainedToSize:constrainSize lineBreakMode:NSLineBreakByTruncatingTail].height;
    labelHeight = MIN(self.boundsHeight - _imageView.boundsHeight - 2.0, labelHeight);
    _label.frameHeight = labelHeight;
    if (self.layout == FMToolbarButtonLayoutCenteredTextAndImage) {
        float totalHeight = labelHeight + _imageView.boundsHeight + 2.0;
        float imageYPosition = roundf((self.boundsHeight - totalHeight) / 2.0);
        _imageView.frame = CGRectMake(0.0, imageYPosition, self.boundsWidth, _imageView.frame.size.height);
        _label.frameY = _imageView.frameMaxY + 2.0;
    } else {
        _imageView.frame = CGRectMake(0.0,
                                      roundf((self.boundsHeight - labelHeight - 3.0 - _imageView.boundsHeight) / 2.0),
                                      self.boundsWidth,
                                      _imageView.boundsHeight);
        _label.frameY = self.boundsHeight - labelHeight - 3.0;
    }
    
    _imageView.centerX = roundf(_imageView.centerX);
    _imageView.centerY = roundf(_imageView.centerY);
}

#pragma mark - Public properties

- (void)setImage:(UIImage *)newImage {
    if(_image != newImage){
        [_image release];
        _image = [newImage retain];
    }
    _imageView.image = newImage;
    if (!_disabledImage){
        self.disabledImage = newImage;
    }
    if (!self.highlightedImage){
        self.highlightedImage = newImage;
    }
    [self setNeedsLayout];
}

- (void)setHighlightedImage:(UIImage *)newImage {
    _imageView.highlightedImage = newImage;
    [self setNeedsLayout];
}

- (UIImage*)highlightedImage {
    return _imageView.highlightedImage;
}

- (void)setDisabledImage:(UIImage *)disabledImage{
    if (_disabledImage != disabledImage){
        [_disabledImage release];
        _disabledImage = [disabledImage retain];
    }
    if (!_enabled){
        _imageView.image = disabledImage;
    }
    [self setNeedsLayout];
}

- (void)setText:(NSString *)newText {
    _label.text = newText;
}

- (NSString*)text {
    return _label.text;
}

- (void)setTextColor:(UIColor *)newColor {
    if (_textColor != newColor){
        [_textColor release];
        _textColor = [newColor retain];
    }
    _label.textColor = newColor;
}

- (void)setHighlightedTextColor:(UIColor *)newColor {
    _label.highlightedTextColor = newColor;
}

- (UIColor*)highlightedTextColor {
    return _label.highlightedTextColor;
}

- (void)setDisabledTextColor:(UIColor *)disabledTextColor{
    if (_disabledTextColor != disabledTextColor){
        [_disabledTextColor release];
        _disabledTextColor = [disabledTextColor retain];
    }
    if(!_enabled){
        self.textColor = disabledTextColor;
    }
}

- (void)setTextFont:(UIFont *)newFont {
    _label.font = newFont;
}

- (UIFont*)textFont {
    return _label.font;
}

- (void)setNormalStateColor:(UIColor *)newColor {
    if (_normalStateColor != newColor) {
        [_normalStateColor release];
        _normalStateColor = [newColor retain];
        if (!self.highlighted) {
            self.backgroundColor = newColor;
        }
    }
}

- (void)setHighlightedStateColor:(UIColor *)newColor {
    if (_highlightedStateColor != newColor) {
        [_highlightedStateColor release];
        _highlightedStateColor = [newColor retain];
        if (self.highlighted) {
            self.backgroundColor = newColor;
        }
    }
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    if (disabledColor != _disabledColor) {
        [_disabledColor release];
        _disabledColor = [disabledColor retain];
    }
    if (!_enabled){
        self.backgroundColor = _disabledColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    BOOL shouldUnhighlight = !self.selected;
    if (highlighted || (!highlighted && shouldUnhighlight)) {
        _highlighted = highlighted;
        self.backgroundColor = _highlighted ? self.highlightedStateColor : self.normalStateColor;
        _label.highlighted = _highlighted;
        _imageView.highlighted = _highlighted;
    }
    
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.highlighted = selected;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if (enabled) {
        if (self.isSelected) {
            self.backgroundColor = _highlightedStateColor;
        } else {
            self.backgroundColor = _normalStateColor;
        }
        self.image = _image;
        self.textColor = _textColor;
    } else {
        self.backgroundColor = _disabledColor;
        self.image = _disabledImage;
        self.textColor = _disabledTextColor;
    }
}

@end