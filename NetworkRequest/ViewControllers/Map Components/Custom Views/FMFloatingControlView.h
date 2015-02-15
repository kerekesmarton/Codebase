//
//  FMFloatingControlView.h
//  ForeverMapNGX
//
//  Created by Kerekes Jozsef-Marton on 7/11/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMToolbarButton.h"
#import "FMToolbarSegmentedControl.h"

typedef enum FMFloatingControlViewStates{
    
    FMFloatingControlViewStateHidden = 0,
    FMFloatingControlViewStateCollapsed,
    FMFloatingControlViewStateExpanded,
    FMFloatingControlViewStateFull,
    
}FMFloatingControlViewState;

@class FMFloatingControlView;

@protocol FMFloatingControlViewDelegate <NSObject>

-(void)floatingControlView:(FMFloatingControlView*)floatingControl didTapOnControl:(FMToolbarSegmentedControl *)control Row:(int)row atIndex:(int)index;
-(BOOL)floatingControlView:(FMFloatingControlView*)floatingControl shouldExpandToState:(FMFloatingControlViewState)state;
-(void)floatingControlView:(FMFloatingControlView*)floatingControl didExpandToState:(FMFloatingControlViewState)state;
-(void)floatingControlView:(FMFloatingControlView*)floatingControl titleImageTapped:(FMFloatingControlViewState)state;

@end

@protocol FMFloatingControlViewDataSource <NSObject>

@optional
-(NSString*)titleForFloatingControl:(FMFloatingControlView*)floatingControl;
-(UIImage*)imageForTitleAccessoryViewForFloatingControl:(FMFloatingControlView*)floatingControl;
@required
-(int)numberOfRowsInFloatingControlView:(FMFloatingControlView*)floatingControl;
/*
 For row views you should use
 
 - FMToolbarSegmentedControl
 - FMToolbarButton
 */
-(FMToolbarSegmentedControl*)floatingControlView:(FMFloatingControlView*)floatingControl viewForRow:(int)row;

@end

@interface FMFloatingControlView : UIView <FMToolbarSegmentedControlDelegate>

@property (nonatomic, assign) id <FMFloatingControlViewDelegate>    delegate;
@property (nonatomic, assign) id <FMFloatingControlViewDataSource>  dataSource;
@property (nonatomic, assign) FMFloatingControlViewState            state;
-(id)   initWithState:(FMFloatingControlViewState)state;
-(void) setState:(FMFloatingControlViewState)state completion:(void (^)(void))block;
-(void) showInView:(UIView *)view;
-(void) dismiss;
-(void) hide;
@end
