//
//  FMToolbarSegmentedControl.h
//  ForeverMapNGX
//
//  Created by BogdanB on 7/9/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMToolbarButton.h"

typedef enum FMToolbarSegmentedControlBehaviour {
    FMToolbarSegmentedControlAutoSelect  = 1,
    FMToolbarSegmentedControlNotifyOnIndexChange = 1 << 1
} FMToolbarSegmentedControlBehaviour;

@protocol FMToolbarSegmentedControlDelegate;

@interface FMToolbarSegmentedControl : UIView

@property (nonatomic, retain) NSArray   *titles;
@property (nonatomic, retain) NSArray   *images;
@property (nonatomic, retain) NSArray   *highlightedImages;
@property (nonatomic, retain) UIFont    *font;
@property (nonatomic, retain) NSArray   *textColors;
@property (nonatomic, retain) NSArray   *highlightedTextColors;
@property (nonatomic, retain) NSArray   *normalStateColors;
@property (nonatomic, retain) NSArray   *highlightedStateColors;
@property (nonatomic, assign) int       selectedIndex;
@property (nonatomic, assign) float     separatorWidth;
@property (nonatomic, retain) UIColor   *separatorColor;
@property (nonatomic, assign) FMToolbarSegmentedControlBehaviour behaviour;
@property (nonatomic, retain) NSMutableArray   *buttons;
@property (nonatomic, assign) id<FMToolbarSegmentedControlDelegate> delegate;

- (id)initWithFrame:(CGRect)frame buttonCount:(int)buttonCount;
- (id)initWithFrame:(CGRect)frame buttons:(NSArray*)buttons;
- (void)deselectAllButtons;
@end

@protocol FMToolbarSegmentedControlDelegate <NSObject>

- (void)toolbarSegmentedControl:(FMToolbarSegmentedControl*)control didSelectButtonAtIndex:(int)index;

@end
