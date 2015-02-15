//
//  ViewControllerPhone.m
//  SlideExample
//
//  Created by Jozsef-Marton Kerekes on 6/10/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SlideViewControllerPhone.h"


@implementation SlideViewControllerPhone {
    UIPanGestureRecognizer *_panGesture;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addSlideNavigationController];
    
    [self addPanGestureRecognizer];
    [self addTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSlideNavigationController {
    _slideNavigationControllerState = FMSlideNavigationControllerStateNormal;
    
    _slideNavigationController = [[UINavigationController alloc] initWithNavigationBarClass:[CustomNavigationBar class] toolbarClass:[UIToolbar class]];
    [self addChildViewController:_slideNavigationController];
    [self.view addSubview:_slideNavigationController.view];
    _slideNavigationController.view.frame = self.view.frame;
    _slideNavigationController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImageView *shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_details"]];
    shadowView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    shadowView.frame = CGRectMake(-14.0, 0.0, 14.0, _slideNavigationController.view.frameHeight);
    shadowView.transform = CGAffineTransformMakeRotation(degreesToRadians(-180));
    [_slideNavigationController.view addSubview:shadowView];
    
    UIImageView *rightShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_details"]];
    rightShadowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    rightShadowView.frame = CGRectMake(_slideNavigationController.view.frameWidth, 0.0, 14.0, _slideNavigationController.view.frameHeight);
    [_slideNavigationController.view addSubview:rightShadowView];
    
    UIViewController *baseVC = [[UIViewController alloc] initWithNibName:@"SlideViewController" bundle:nil];
    [self configureViewController:baseVC];
    [_slideNavigationController setViewControllers:[NSArray arrayWithObject:baseVC] animated:NO];
}

- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOccured:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    _panGesture = panGesture;
}

- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOccured:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

#define kFMMainMenuPanThreshold (30.0)

- (void)panOccured:(UIPanGestureRecognizer *)panGesture {
    static FMSlideMenuSide side = FMSlideMenuLeftSide;
    static BOOL startedFromNormalMode = YES;
    static CGFloat startX = 0.0;
    
    CGPoint location = [panGesture locationInView:self.view];
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingLeftMenu) != 0 && location.x > kFMSideMenuWidth) ||
            ((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingRightMenu) != 0 && location.x < self.view.boundsWidth - kFMSideMenuWidth)) {
            startedFromNormalMode = NO;
            side = (location.x > kFMSideMenuWidth) ? FMSlideMenuLeftSide : FMSlideMenuRightSide;
            startX = _slideNavigationController.view.transform.tx;
            _startingDragPoint = location;
        } else {
            startedFromNormalMode = YES;
            if (location.x <= kFMMainMenuPanThreshold) {
                _startingDragPoint = location;
                _settingsViewController.view.hidden = YES;
                side = FMSlideMenuLeftSide;
            }
            
            if (location.x >= self.view.boundsWidth - kFMMainMenuPanThreshold) {
                _startingDragPoint = location;
                _settingsViewController.view.hidden = NO;
                side = FMSlideMenuRightSide;
            }
        }
    }
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGFloat dx = location.x - _startingDragPoint.x;
        if (startedFromNormalMode) {
            _slideNavigationController.view.transform = CGAffineTransformMakeTranslation(dx, 0.0f);
        } else {
            _slideNavigationController.view.transform = CGAffineTransformMakeTranslation(startX + dx, 0.0f);
        }
    }
    
    if (panGesture.state == UIGestureRecognizerStateCancelled ||
        panGesture.state == UIGestureRecognizerStateEnded) {
        CGFloat dx = location.x - _startingDragPoint.x;
        
        if ((startedFromNormalMode && fabsf(dx) <= kFMiPodSliderSnapThreshold) ||
            (!startedFromNormalMode && fabsf(dx) >= kFMiPodSliderSnapThreshold)) {
            [self slideInSlideNavigationControllerView];
        } else {
            [self slideOutSlideNavigationControllerViewDirection:side];
        }
    }
}

- (void)tapOccured:(UITapGestureRecognizer *)tapGesture {
    [self slideInSlideNavigationControllerView];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    float width = kFMSideMenuWidth;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        width = kFMSideMenuLandscapeWidth;
    }
    
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint location = [gestureRecognizer locationInView:self.view];
        
        if (((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingLeftMenu) != 0 && location.x > width) ||
            ((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingRightMenu) != 0 && location.x < self.view.boundsWidth - kFMSideMenuWidth)) {
            return YES;
        } else if (location.x < kFMMainMenuPanThreshold || (location.x >= self.view.boundsWidth - kFMMainMenuPanThreshold && self.settingsViewController)) {
            if (gestureRecognizer == _panGesture &&
                (_slideNavigationControllerState & FMSlideNavigationControllerStatePeeking) == 0 &&
                (_slideNavigationControllerState & FMSlideNavigationControllerStateDragging) == 0) {
                return YES;
            } else {
                return NO;
            }
        }
    } else if ([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] &&
               (_slideNavigationControllerState & FMSlideNavigationControllerStatePeeking) != 0) {
        CGPoint location = [gestureRecognizer locationInView:self.view];
        if (((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingLeftMenu) != 0 && location.x > width) ||
            ((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingRightMenu) != 0 && location.x < self.view.boundsWidth - kFMSideMenuWidth)) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] && _panGesture == otherGestureRecognizer) ||
        ([otherGestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] && _panGesture == gestureRecognizer)) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Private methods

- (void)slideOutSlideNavigationControllerViewDirection:(FMSlideMenuSide)direction {
    CGFloat sign = (direction == FMSlideMenuRightSide) ? -1.0 : 1.0;
    FMSlideNavigationControllerState flag = (direction == FMSlideMenuRightSide) ? FMSlideNavigationControllerStatePeekingRightMenu : FMSlideNavigationControllerStatePeekingLeftMenu;
    [self sideMenu:direction willAppear:YES];
    
    self.settingsViewController.view.hidden = (direction == FMSlideMenuLeftSide);
    if (!self.settingsViewController.view.hidden) {
        [self.view bringSubviewToFront:self.settingsViewController.view];
        [self.view bringSubviewToFront:_slideNavigationController.view];
    }
    
    [UIView animateWithDuration:0.2 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            _slideNavigationController.view.transform = CGAffineTransformMakeTranslation(sign * kFMSideMenuLandscapeWidth, 0.0);
        } else {
            _slideNavigationController.view.transform = CGAffineTransformMakeTranslation(sign * kFMSideMenuWidth, 0.0);
        }
    } completion:^(BOOL finished) {
        _slideNavigationControllerState = FMSlideNavigationControllerStatePeeking | flag;
        [self sideMenu:direction didAppear:YES];
    }];
}

- (void)slideInSlideNavigationControllerView {
    FMSlideMenuSide fromSide = ((_slideNavigationControllerState & FMSlideNavigationControllerStatePeekingRightMenu) != 0) ? FMSlideMenuRightSide : FMSlideMenuLeftSide;
    [self sideMenu:fromSide willDisappear:YES];
    
    [UIView animateWithDuration:0.2 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        _slideNavigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _slideNavigationControllerState = FMSlideNavigationControllerStateNormal;
        _settingsViewController.view.hidden = YES;
        
        [self sideMenu:fromSide didDisappear:YES];
    }];
}

- (void)menuBarButtonItemClicked {
    if ((_slideNavigationControllerState & FMSlideNavigationControllerStatePeeking) != 0) {
        [self slideInSlideNavigationControllerView];
    } else {
        [self slideOutSlideNavigationControllerViewDirection:FMSlideMenuLeftSide];
    }
}

@end
