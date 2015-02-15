//
//  MapViewController+FloatingControl.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MapViewController+FloatingControl.h"
#import "FloatingControlStateFactory.h"
#import <SKMaps/SKSearch.h>

@implementation MapViewController (FloatingControl)

@dynamic floatingControlState;

-(void)openFloatingControlWithSearchObject:(SKSearchResult *)searchObject {
    
    //configure data source for floating control
    [FloatingControlStateFactory setStaticSearchObject:searchObject];
    self.floatingControlDataModel = [FloatingControlStateFactory dataSourceForState:FLoatingControlStateOptions];
    
    //configure floating control.
    self.floatingControlState = FLoatingControlStateOptions;
}

-(void)hideFloatingControl {
    self.floatingControlState = FLoatingControlStateOff;
}

-(FLoatingControlState)floatingControlState {
    return _floatingControlState;
}

-(void)setFloatingControlState:(FLoatingControlState)state {
    
    _floatingControlState = state;
        switch (state) {
        case FLoatingControlStateOff:
            [self modifyStateOff];
            break;
        case FLoatingControlStateOptions:
            [self modifyStateTitle];
            break;
        default:
            break;
    }
}

-(void)modifyStateOff {
    [self.floatingControlView setState:FMFloatingControlViewStateHidden];
}
-(void)modifyStateTitle {
    [self.floatingControlView setState:FMFloatingControlViewStateCollapsed];
}
-(void)modifyStateOptions {
    [self.floatingControlView setState:FMFloatingControlViewStateExpanded];
}

#pragma mark - delegate

-(void)floatingControlView:(FMFloatingControlView*)floatingControl didTapOnControl:(FMToolbarSegmentedControl *)control Row:(int)row atIndex:(int)index {
    self.floatingControlDataModel.action(row,index);
    
}
-(BOOL)floatingControlView:(FMFloatingControlView*)floatingControl shouldExpandToState:(FMFloatingControlViewState)state {
    
    return NO;
}
-(void)floatingControlView:(FMFloatingControlView*)floatingControl didExpandToState:(FMFloatingControlViewState)state {

    //
}
-(void)floatingControlView:(FMFloatingControlView*)floatingControl titleImageTapped:(FMFloatingControlViewState)state {
    
    [self route];
}

#pragma mark - dataSource

-(NSString*)titleForFloatingControl:(FMFloatingControlView*)floatingControl {
    
    return self.floatingControlDataModel.title;
}

-(UIImage*)imageForTitleAccessoryViewForFloatingControl:(FMFloatingControlView*)floatingControl {
    
    return [UIImage imageNamed:self.floatingControlDataModel.imageTitle];
}

-(int)numberOfRowsInFloatingControlView:(FMFloatingControlView*)floatingControl {
    
    return self.floatingControlDataModel.views.count;
}

-(FMToolbarSegmentedControl*)floatingControlView:(FMFloatingControlView*)floatingControl viewForRow:(int)row {
    
    return [self.floatingControlDataModel.views objectAtIndex:row];
}

@end
