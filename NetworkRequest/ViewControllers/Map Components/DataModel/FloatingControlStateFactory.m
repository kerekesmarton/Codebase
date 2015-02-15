//
//  FloatingControlStateFactory.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "FloatingControlStateFactory.h"
#import <SKMaps/SKSearchResult.h>
#import "FMToolbarButton.h"
#import "FMToolbarSegmentedControl.h"

#define defaultWidth    [UIScreen mainScreen].bounds.size.width
#define defaultHeight   60
#define defaultRect     CGRectMake(0, 0, defaultWidth, defaultHeight)


@implementation FloatingControlDataModel

@synthesize title,imageTitle,views,action;

+(FloatingControlDataModel *)emptyDataModel {
    
    FloatingControlDataModel *model = [[FloatingControlDataModel alloc] init];
    model.title = @"";
    model.imageTitle = @"";
    model.views = [NSArray array];
    model.action = ^(int row, int index){};
    return model;
}

@end

@implementation FloatingControlStateFactory
static SKSearchResult *staticSearchObject = nil;

+(void)setStaticSearchObject:(SKSearchResult *)searchObject {
    
    staticSearchObject = searchObject;
}

/*
 typedef enum FloatingControlState {
 
 FLoatingControlStateOff,
 FLoatingControlStateTitle,
 FLoatingControlStateDetails,
 
 }FLoatingControlState;
 */

+(FloatingControlDataModel *)dataSourceForState:(FLoatingControlState)state {
    FloatingControlDataModel *model = [FloatingControlDataModel emptyDataModel];
    
    switch (state) {
        case FLoatingControlStateOff:
            break;
        case FLoatingControlStateOptions:
            model.title = staticSearchObject.name;
            model.imageTitle = @"route";
            model.views = [self viewsForStateOptions];
            model.action = ^(int row, int index) {
                
                
            };
            break;
        default:
            break;
    }
    
    return model;
}

+(NSArray *)viewsForStateOptions {
    
    FMToolbarButton *search = [self searchbutton:YES];
    FMToolbarSegmentedControl *searchControl = [self segmentedControlWithItems:@[search]];
    
    FMToolbarButton *button = [self routeButton:YES];
    
    FMToolbarButton *button2 = [self wikiButton:YES];
    FMToolbarSegmentedControl *details = [self segmentedControlWithItems:@[button,button2]];
    
    return @[searchControl,details];
}

+(FMToolbarButton *)searchbutton:(BOOL)enabled {
    
    FMToolbarButton *button = [self standardToobarButton];
    button.normalStateColor = [UIColor colorWithHex:0xff5649];
    button.textColor = [UIColor colorWithHex:0xFFFFFF];
    button.text = @"Search";
    button.image = nil;
    button.enabled = enabled;
    
    return button;
}

+(FMToolbarButton *)routeButton:(BOOL)enabled {
    
    FMToolbarButton *button = [self standardToobarButton];
    button.normalStateColor = [UIColor colorWithHex:0xff5649];
    button.textColor = [UIColor colorWithHex:0xFFFFFF];
    button.text = @"Route";
    button.image = nil;
    button.enabled = enabled;
    
    return button;
}

+(FMToolbarButton *)wikiButton:(BOOL)enabled {
    
    FMToolbarButton *button = [self standardToobarButton];
    button.normalStateColor = [UIColor colorWithHex:0xff5649];
    button.textColor = [UIColor colorWithHex:0xFFFFFF];
    button.text = @"Wiki";
    button.image = nil;
    button.enabled = enabled;
    
    return button;
}

+(FMToolbarButton *) standardToobarButton {
    FMToolbarButton *button = [[FMToolbarButton alloc] initWithFrame:defaultRect];
    button.textColor = [UIColor colorWithHex:0x3a3a3a];
    button.highlightedTextColor = [UIColor colorWithHex:0xffffff];
    button.disabledTextColor = [UIColor colorWithHex:0xc4c4c4];
    button.image = nil;
    button.normalStateColor = [UIColor whiteColor];
    button.disabledColor = [UIColor colorWithHex:0xefefef];
    button.backgroundColor = [UIColor clearColor];
    
    return button;
}

+(FMToolbarSegmentedControl *)segmentedControlWithItems:(NSArray *)items {
    FMToolbarSegmentedControl *control = [[FMToolbarSegmentedControl alloc] initWithFrame:defaultRect buttons:items] ;
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    control.separatorWidth = 2;
    control.separatorColor = [UIColor darkGrayColor];
    
    return control;
}




@end
