//
//  ViewController.h
//  SlideExample
//
//  Created by Jozsef-Marton Kerekes on 6/10/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"

@class FMFunctionsViewController;
@class FMSlideViewNavigationBar;
@class FMMainMenuItem;

#define kSVCLeftAnchorX             (100.0f + 100.0 * [UIDevice isiPad])
#define kSVCRightAnchorX            (200.0f + 100.0 * [UIDevice isiPad])

#define kFMiPadSliderSnapThreshold  (100.0)
#define kFMiPodSliderSnapThreshold  (60.0)
#define kSVCSwipeNavigationBarOnly  (NO)

#define kFMRightMenuOffsetX         (60.0)
#define kFMRightMenuWidth           (260.0)
#define kFMRightMenuLandscapeWidth  (260.0)

#define kFMSideMenuWidth            (260.0)
#define kFMSideMenuLandscapeWidth   (260.0)
#define kFMDetailViewWidth          (320.0)



typedef enum {
    FMSlideNavigationControllerStateNormal = 0,
    FMSlideNavigationControllerStatePeeking = 1,
    FMSlideNavigationControllerStatePeekingRightMenu = 1 << 1,
    FMSlideNavigationControllerStatePeekingLeftMenu = 1 << 2,
    FMSlideNavigationControllerStateDragging = 1 << 3,
    FMSlideNavigationControllerStateDraggingLeft = 1 << 4,
    FMSlideNavigationControllerStateDraggingRight = 1 << 5,
    FMSlideNavigationControllerStateDrilledDown = 1 << 6,
    FMSlideNavigationControllerStateSecondPosition = 1 << 9,
    FMSlideNavigationControllerStateOffScreen = 1 << 12,
} FMSlideNavigationControllerState;

typedef enum {
    FMSlideMenuLeftSide = 0,
    FMSlideMenuRightSide
} FMSlideMenuSide;



@interface SlideViewController : UIViewController {
    
    UITableView             *_tableView;
    UIViewController        *_settingsViewController;
    UINavigationController  *_fixedNavigationController;
    UINavigationController  *_slideNavigationController;
    
    CGPoint                 _startingDragPoint;
    BOOL                    _startedDragging;
    CGFloat                 _startingDragTransformTx;
    
    __block FMSlideNavigationControllerState _slideNavigationControllerState;
}

@property (nonatomic, retain) UIViewController  *settingsViewController;

// Public methods
- (void)configureViewController:(UIViewController *)viewController;

// Protected methods
- (void)sideMenu:(FMSlideMenuSide)side willAppear:(BOOL)animated;
- (void)sideMenu:(FMSlideMenuSide)side didAppear:(BOOL)animated;
- (void)sideMenu:(FMSlideMenuSide)side willDisappear:(BOOL)animated;
- (void)sideMenu:(FMSlideMenuSide)side didDisappear:(BOOL)animated;

- (void)detailScreenWillAppear:(BOOL)animated;
- (void)detailScreenDidAppear:(BOOL)animated;
- (void)detailScreenWillDisappear:(BOOL)animated;
- (void)detailScreenDidDisappear:(BOOL)animated;

@end

@interface FMSlideViewNavigationBar : UINavigationBar {

}



@end




