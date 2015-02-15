//
//  ViewController.m
//  SlideExample
//
//  Created by Jozsef-Marton Kerekes on 6/10/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SlideViewController.h"

@implementation SlideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SlideViewNavigationBarDelegate Methods

- (void)slideViewNavigationBar:(FMSlideViewNavigationBar *)navigationBar touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}

- (void)slideViewNavigationBar:(FMSlideViewNavigationBar *)navigationBar touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)slideViewNavigationBar:(FMSlideViewNavigationBar *)navigationBar touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)performSelectorOnTopViewController:(SEL)selector withObject:(id)object {
    
    if (_slideNavigationController.topViewController && [_slideNavigationController.topViewController respondsToSelector:selector]) {
        [_slideNavigationController.topViewController performSelector:selector withObject:object];
    }
}

#pragma mark - Protected methods

- (void)sideMenu:(FMSlideMenuSide)side willAppear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(willShowMenuFromSide:) withObject:[NSNumber numberWithInteger:side]];
}

- (void)sideMenu:(FMSlideMenuSide)side didAppear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(didShowMenuFromSide:) withObject:[NSNumber numberWithInteger:side]];
}

- (void)sideMenu:(FMSlideMenuSide)side willDisappear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(willHideMenuFromSide:) withObject:[NSNumber numberWithInteger:side]];
}

- (void)sideMenu:(FMSlideMenuSide)side didDisappear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(didHideMenuFromSide:) withObject:[NSNumber numberWithInteger:side]];
}

- (void)detailScreenWillAppear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(willShowDetailScreen) withObject:nil];
}

- (void)detailScreenDidAppear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(didShowDetailScreen) withObject:nil];
}

- (void)detailScreenWillDisappear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(willHideDetailScreen) withObject:nil];
}

- (void)detailScreenDidDisappear:(BOOL)animated {
    [self performSelectorOnTopViewController:@selector(didHideDetailScreen) withObject:nil];
}

- (void)configureViewController:(UIViewController *)viewController {
    
}


@end



