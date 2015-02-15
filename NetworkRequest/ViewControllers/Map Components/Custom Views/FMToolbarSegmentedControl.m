//
//  FMToolbarSegmentedControl.m
//  ForeverMapNGX
//
//  Created by BogdanB on 7/9/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "FMToolbarSegmentedControl.h"
#import "FMToolbarButton.h"

@interface FMToolbarSegmentedControl()
{
    NSMutableArray *_separators;
}

@end

@implementation FMToolbarSegmentedControl

@synthesize buttons = _buttons;
@synthesize titles = _titles;
@synthesize images = _images;
@synthesize highlightedImages = _highlightedImages;
@synthesize font = _font;
@synthesize textColors = _textColors;
@synthesize highlightedTextColors = _highlightedTextColors;
@synthesize normalStateColors = _normalStateColors;
@synthesize highlightedStateColors = _highlightedStateColors;
@synthesize selectedIndex = _selectedIndex;
@synthesize separatorColor = _separatorColor;
@synthesize separatorWidth = _separatorWidth;
@synthesize delegate;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame buttonCount:(int)buttonCount {
    self = [super initWithFrame:frame];
    if (self) {
        [self createButtons:buttonCount];
        _separators = [[NSMutableArray alloc] init];
        self.separatorColor = [UIColor blueColor];
        _separatorWidth = 0.0;
        [self initSeparators];
        self.selectedIndex = -1;
        
        _titles = nil;
        _images = nil;
        _highlightedImages = nil;
        _normalStateColors = nil;
        _highlightedStateColors = nil;
        _font = [[UIFont fontWithName:@"Avenir" size:16.0] retain];
        self.behaviour = FMToolbarSegmentedControlAutoSelect | FMToolbarSegmentedControlNotifyOnIndexChange;
    }
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        _separators = [[NSMutableArray alloc] init];
        self.separatorColor = [UIColor blueColor];
        _separatorWidth = 0.0;
        self.selectedIndex = -1;
        
        _titles = nil;
        _images = nil;
        _highlightedImages = nil;
        _normalStateColors = nil;
        _highlightedStateColors = nil;
        _font = [[UIFont fontWithName:@"Avenir" size:16.0] retain];
        self.behaviour = FMToolbarSegmentedControlAutoSelect | FMToolbarSegmentedControlNotifyOnIndexChange;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame buttons:(NSArray*)buttons {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons = [[buttons mutableCopy] autorelease];
        self.separatorColor = [UIColor blueColor];
        [self initButtons];
    }
    
    return self;
}

- (void) dealloc {
    [_buttons release];
    [_separators release];
    [_titles release];
    [_textColors release];
    [_highlightedTextColors release];
    [_images release];
    [_highlightedImages release];
    [_normalStateColors release];
    [_highlightedStateColors release];
    [_separatorColor release];
    [_font release];
    [super dealloc];
}

#pragma mark - Public methods

- (FMToolbarButton *)buttonAtIndex:(int)index {
    if (index < self.buttons.count && index >= 0) {
        return [self.buttons objectAtIndex:index];
    } else {
        return nil;
    }
}

#pragma mark - Overidden

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float buttonWidth = roundf((self.boundsWidth - _separatorWidth * _separators.count) / self.buttons.count);
    float buttonPlusSeparatorWidth = buttonWidth + _separatorWidth;
    
    for (int i = 0; i < self.buttons.count; i++) {
        FMToolbarButton *button = (FMToolbarButton*)[self.buttons objectAtIndex:i];
        button.frameWidth = buttonWidth;
        button.frameX = buttonPlusSeparatorWidth * i;
        button.frameHeight = self.boundsHeight;
    }
    
    for (int i = 0; i < _separators.count; i++) {
        UIView *separator = [_separators objectAtIndex:i];
        separator.frame = CGRectMake(buttonPlusSeparatorWidth * (i + 1) - _separatorWidth, 0, _separatorWidth, self.boundsHeight);
    }
}

#pragma mark - Public properties

- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        [_titles release];
        _titles = [titles retain];
    }
    
    [self reloadTitles];
}

- (void)setFont:(UIFont *)font {
    if (font != _font) {
        [_font release];
        _font = [font retain];
        for (FMToolbarButton *button in self.buttons) {
            button.textFont = font;
        }
        
    }
}

- (void)setImages:(NSArray *)images {
    if (_images != images) {
        [_images release];
        _images = [images retain];
    }
    
    [self reloadImages];
}

- (void)setHighlightedImages:(NSArray *)highlightedImages {
    if (_highlightedImages != highlightedImages) {
        [_highlightedImages release];
        _highlightedImages = [highlightedImages retain];
    }
    
    [self reloadHighlightedImages];
}

- (void)setTextColors:(NSArray *)textColors {
    if (_textColors != textColors) {
        [_textColors release];
        _textColors = [textColors retain];
    }
    
    [self reloadTextColors];
}

- (void)setHighlightedTextColors:(NSArray *)highlightedTextColors {
    if (_highlightedTextColors != highlightedTextColors) {
        [_highlightedTextColors release];
        _highlightedTextColors = [highlightedTextColors retain];
    }
    
    [self reloadHighlightedTextColors];
}

- (void)setNormalStateColors:(NSArray *)normalStateColors {
    if (_normalStateColors != normalStateColors) {
        [_normalStateColors release];
        _normalStateColors = [normalStateColors retain];
    }
    
    [self reloadNormalStateColors];
}

- (void)setHighlightedStateColors:(NSArray *)highlightedStateColors{
    if (_highlightedStateColors != highlightedStateColors) {
        [_highlightedStateColors release];
        _highlightedStateColors = [highlightedStateColors retain];
    }
    
    [self reloadHighlightedStateColors];
}

#pragma mark - Private methods

- (void)createButtons:(int)count {
    _buttons = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < count; i++) {
        FMToolbarButton *button = [[FMToolbarButton alloc] init];
        [self.buttons addObject:button];
        [button release];
    }
    
    [self initButtons];
}

- (void)initButtons {
    CGRect frame = CGRectZero;
    frame.size.height = self.boundsHeight;
    frame.size.width = roundf((self.boundsWidth - _separatorWidth * (self.buttons.count - 1)) / self.buttons.count);
    for (int i = 0; i < self.buttons.count; i++) {
        FMToolbarButton *button = [self.buttons objectAtIndex:i];
        frame.origin.x = (frame.size.width + _separatorWidth) * i;
        button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        button.tag = i;
        button.frame = frame;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)initSeparators {
    for (UIView *separator in _separators) {
        [separator removeFromSuperview];
    }
    [_separators removeAllObjects];
    
    float buttonWidth = roundf((self.boundsWidth - _separatorWidth * (self.buttons.count - 1)) / self.buttons.count);
    float buttonPlusSeparatorWidth = buttonWidth + _separatorWidth;
    for (int i = 0; i < self.buttons.count - 1; i++) {
        UIView *separator = [[UIView alloc] init];
        [_separators addObject:separator];
        separator.frame = CGRectMake(buttonPlusSeparatorWidth * (i + 1) - _separatorWidth, 0, _separatorWidth, self.boundsHeight);
        separator.backgroundColor = _separatorColor;
        [self addSubview:separator];
        [separator release];
    }
}

- (void)reloadButtons {
    [self reloadTitles];
    [self reloadTextColors];
    [self reloadHighlightedTextColors];
    [self reloadFonts];
    [self reloadImages];
    [self reloadHighlightedImages];
    [self reloadNormalStateColors];
    [self reloadHighlightedStateColors];    
}

- (void)reloadTitles {
    if (self.titles.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.text = [self.titles objectAtIndex:button.tag];
        }
    }
}

- (void)reloadTextColors {
    if (self.textColors.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.textColor = [self.textColors objectAtIndex:button.tag];
        }
    }
}

- (void)reloadHighlightedTextColors {
    if (self.highlightedTextColors.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.highlightedTextColor = [self.highlightedTextColors objectAtIndex:button.tag];
        }
    }
}

- (void)reloadFonts {
    for (FMToolbarButton *button in self.buttons) {
        button.textFont = self.font;
    }
}


- (void)reloadImages {
    if (self.images.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.image = [self.images objectAtIndex:button.tag];
        }
    }
}

- (void)reloadHighlightedImages {
    if (self.highlightedImages.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.highlightedImage = [self.highlightedImages objectAtIndex:button.tag];
        }
    }
}

- (void)reloadNormalStateColors {
    if (self.normalStateColors.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.normalStateColor = [self.normalStateColors objectAtIndex:button.tag];
        }
    }
}

- (void)reloadHighlightedStateColors {
    if (self.highlightedStateColors.count == self.buttons.count) {
        for (FMToolbarButton *button in self.buttons) {
            button.highlightedStateColor = [self.highlightedStateColors objectAtIndex:button.tag];
        }
    }
}

- (void)setSelectedIndex:(int)newIndex {
    if (newIndex >= 0 && newIndex < self.buttons.count) {
        if (_selectedIndex >= 0 && _selectedIndex < self.buttons.count) {
            ((FMToolbarButton*)[self.buttons objectAtIndex:_selectedIndex]).selected = NO;
        }
        
        _selectedIndex = newIndex;
        ((FMToolbarButton*)[self.buttons objectAtIndex:_selectedIndex]).selected = YES;
    }
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    if (separatorColor != _separatorColor) {
        [_separatorColor release];
        _separatorColor = [separatorColor retain];
        for (UIView *separator in _separators) {
            separator.backgroundColor = _separatorColor;
        }
    }
}

- (void)setButtons:(NSMutableArray *)buttons {
    if (buttons != _buttons) {
        [_buttons release];
        _buttons = [buttons retain];
    }
    [self initButtons];
    [self initSeparators];
}

- (void)setSeparatorWidth:(float)separatorWidth {
    _separatorWidth = separatorWidth;
    [self setNeedsLayout];
}

#pragma mark - Actions

-(void)deselectAllButtons {
    
   [self.buttons enumerateObjectsUsingBlock:^(FMToolbarButton *obj, NSUInteger idx, BOOL *stop) {
       obj.selected = NO;
   }];
}

- (void)buttonPressed:(FMToolbarButton*)button {
    if (button.selected && (self.behaviour & FMToolbarSegmentedControlNotifyOnIndexChange)) {
        return;
    }
    
    if (self.behaviour & FMToolbarSegmentedControlAutoSelect) {
        if (self.selectedIndex >= 0 && self.selectedIndex < self.buttons.count) {
            ((FMToolbarButton*)[self.buttons objectAtIndex:self.selectedIndex]).selected = NO;
        }
        button.selected = YES;
        self.selectedIndex = button.tag;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolbarSegmentedControl:didSelectButtonAtIndex:)]) {
        [self.delegate toolbarSegmentedControl:self didSelectButtonAtIndex:button.tag];
    }
}

@end